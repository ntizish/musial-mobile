//
//  ChangeableAvatarView.swift
//  musial-mobile
//
//  Created by Danil Perednja on 30.03.2024.
//

import SwiftUI
import PhotosUI

struct ChangableAvatarView: View {
    
    @ObservedObject var viewModel: UserModel
    
    var body: some View {
        
        ProfileImage(imageState: viewModel.imageState).scaledToFill().clipShape(Circle()).frame(width: 136, height: 136).background {
            Circle().fill(
                Constants.Colors.modalGreyColor)
        } .overlay(alignment: .center) {
            PhotosPicker(selection: $viewModel.imageSelection, matching: .images, photoLibrary: .shared()) {
                Circle().opacity(0)
            }.buttonStyle(.borderless)
        }
    }
}
