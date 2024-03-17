//
//  Posts.swift
//  musial-mobile
//
//  Created by Danil Perednja on 18.02.2024.
//

import Foundation
import SwiftUI


struct Article: Codable, Identifiable {
    var id = UUID()
    let name: String
    let description: String
}

struct ArticlePreview: View {
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
                    Text("Title: \(article.name)")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("Description: \(article.description)")
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
        // customize the appearance of the navigation bar
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .blue
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some View { // layout
        
        var posts: [[String: Any]] = getPostsByType(postType: "all")
        NavigationView {
            
            ScrollView {
                LazyVStack(spacing: 4) {
                    ForEach(posts) { article in
                                        ArticlePreview(article: article)
                                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Constants.Colors.backgroundMain)
            }
            .navigationBarTitle("Articles")
//            .foregroundColor(.red)
            
        }
        .onAppear { // fetch all post
            HTTPReceiver().fetchDataFromServer()
        }
    }
    
    func getPostsByType(postType: String) -> [[String: Any]] {
        
        var allPosts: [[String: Any]] = HTTPReceiver().getPosts()
        var postsToReturn: [[String: Any]] = []
        
        for post in allPosts {
            postsToReturn.append(post)
        }
        
        
        
        return postsToReturn
    }
    
}

#Preview {
    PostsVC()
}

