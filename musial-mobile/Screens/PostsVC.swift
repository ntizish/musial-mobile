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
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
    }
}

struct ArticlePreview: View {
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(article.name)")
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1) // Limit to a single line
                .truncationMode(.tail) // Truncate with three dots in the middle if text doesn't fit
                                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("\(article.description)")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1) // Limit to a single line
                                .truncationMode(.tail) // Truncate with three dots in the middle if text doesn't fit
                                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct PostsVC: View {
    @State private var selectedTab = 0
    @State private var articles: [Article] = []
    
    
    init() {
        // customize the appearance of the navigation bar
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .blue
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some View { // layout
        
        NavigationView {
            
            ScrollView {
                LazyVStack(spacing: 4) {
                    ForEach(articles) { article in
                                        ArticlePreview(article: article)
                                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Constants.Colors.backgroundMain)
            }
            .navigationBarTitle("Articles")
//            .foregroundColor(.red)
            
        }
        .onAppear { // fetch all post
            fetchData()
        }
    }
    
    func fetchData() {
            guard let url = URL(string: "http://localhost:3000/api/v1/posts.json") else {
                print("Invalid URL")
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error fetching data: \(error)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Invalid response")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode([Article].self, from: data)
                    DispatchQueue.main.async {
                        self.articles = decodedData
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }.resume()
        }
    
}

#Preview {
    PostsVC()
}

