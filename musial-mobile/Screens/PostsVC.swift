//
//  Posts.swift
//  musial-mobile
//
//  Created by Danil Perednja on 18.02.2024.
//

import Foundation
import SwiftUI


struct ArticlePreview: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Article Title")
                .font(.headline)
                .foregroundColor(.primary)
            Text("Article Description")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct PostsVC: View {
    @State private var selectedTab = 0
    
    init() {
        // Customize the appearance of the navigation bar
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .blue // Change this to your desired background color
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                LazyVStack(spacing: 4) {
                    ForEach(0..<10) { _ in
                        ArticlePreview()
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Constants.Colors.backgroundMain)
            }
            .navigationBarTitle("Articles")
            .foregroundColor(.red)
            
        }
    }
}

#Preview {
    PostsVC()
}

