//
//  UserModel.swift
//  musial-mobile
//
//  Created by Danil Perednja on 30.03.2024.
//

import SwiftUI
import PhotosUI
import UIKit
import CoreTransferable

@MainActor
class UserModel: ObservableObject {
    
    // MARK: - User details
    
    @Published var name: String = ""
    @Published var nickname: String = ""
    @Published var email: String = ""
    @Published var tg: String = ""
    @Published var birthday = Date()
    
    // MARK: - User image state

    enum ImageState {
        case empty
        case loading(Progress)
        case success(Image)
        case failure(Error)
    }
    
    @Published private(set) var imageState: ImageState = .empty
    
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    // MARK: - if transfer failed

    enum transferError: Error {
        case importFaild
    }
    
    struct ProfileImage: Transferable {
            let image: Image
            
            static var transferRepresentation: some TransferRepresentation { DataRepresentation(importedContentType: .image) { data in
                guard let uiImage = UIImage(data: data) else {
                throw transferError.importFaild
            }
                UserDefaults.standard.setValue(data, forKey: "Avatar")
                let image = Image(uiImage: uiImage)
                return ProfileImage(image: image)
                }
            }
        }
    
    // all key values in user defaults
    let keyValues = ["Name",  "Nickname", "Email", "TG", "Birthday" ]
    
    //save all fields in user defualts
    public func saveInUserDefaults() {
        print("Save")
        for key in keyValues {
            switch key {
                case "Name":
                    UserDefaults.standard.set(name, forKey: key)
                case "Nickname":
                    UserDefaults.standard.set(nickname, forKey: key)
                case "Email":
                    UserDefaults.standard.set(email, forKey: key)
                case "TG":
                    UserDefaults.standard.set(tg, forKey: key)
                case "Birthday":
                    UserDefaults.standard.set(birthday, forKey: key)
                
                default:
                    print("No Value")
            }
        }
    }
    
    public func setImageStateSuccess(image: Image) {
        self.imageState = .success(image)
    }
    
    //MARK: - private methods
    
    //loading
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: ProfileImage.self) {
            result in
            
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed")
                    return
                }
                
                switch result {
                case .success(let profileImage?):
                    self.imageState = .success(profileImage.image)
                
                case .success(nil):
                    self.imageState = .empty
                
                case .failure(let error):
                    self.imageState = .failure(error)
                }
                
            }
        }
    }
}
