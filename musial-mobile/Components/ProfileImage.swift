//
//  ProfileImage.swift
//  musial-mobile
//
//  Created by Danil Perednja on 30.03.2024.
//

import SwiftUI
import PhotosUI

struct ProfileImage: View {
    
    let imageState: UserModel.ImageState
    
    var body: some View {
        switch imageState {
        case .success(let image):
            image.resizable()
            
        case .loading: //(let progress):
            Image("Load").font(.system(size: 40)).foregroundColor(.white)

        case .empty:
            Image("NoAvatar").resizable().scaledToFit().font(.system(size: 40)).foregroundColor(.white)
       
        case .failure: //(let error):
            Image("Warning").font(.system(size: 40)).foregroundColor(.white)
        }
        
    }
}
