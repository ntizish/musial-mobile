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
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case type
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
    @State private var selectedOption = "all"
    
    var filteredArticles: [Article] {
        if selectedOption == "all" {
            return articles
        } else {
            return articles.filter { $0.type == selectedOption }
        }
    }
    
    
    init() {
        // customize the appearance of the navigation bar
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .blue
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some View { // layout
        
        NavigationView {
            VStack {
                Picker(selection: $selectedOption, label: Text("Select Type")) {
                    Text("Все").tag("all")
                    Text("Обложки").tag("CoverPost")
                    Text("Промо").tag("PromoPost")
                    Text("Видео").tag("VideoPost")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                
                ScrollView {
                    LazyVStack(spacing: 4) {
                        ForEach(filteredArticles) { article in
                            ArticlePreview(article: article)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Constants.Colors.backgroundMain)
                    .onAppear { // fetch all post
                        fetchData()
                    }
                }
                .navigationBarTitle("Articles")
                //            .foregroundColor(.red)
            }
            .background(Constants.Colors.modalGreyColor)
        
        
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
                        print(self.articles)
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

