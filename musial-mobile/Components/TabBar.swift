//
//  TabBa.swift
//  musial-mobile
//
//  Created by Danil Perednja on 18.02.2024.
//

import Foundation
import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            Group { // group everything together to maintain same tabbar color on all pages
//                Text("Главная") // put a view here like HomeVC()
//                    .tabItem {
//                        Image(systemName: "house")
//                        Text("Главная")
//                    }
//                    .tag(0)
                
                
                    PostsVC()
//                        .toolbar {
//                            ToolbarItem(placement: .topBarLeading) {
//                      VStack {
//                        Text("Посты")
//                              .font(.largeTitle)
//                          .padding(.top, 85)
//                          .foregroundColor(.white)
//                      }
//                    }
//                  }
//                  .toolbarBackground(.visible, for: .navigationBar)
//                  .toolbarBackground(Constants.Colors.modalGreyColor, for: .navigationBar)
//                  .navigationBarTitleDisplayMode(.automatic)
//                }
                
                .tabItem {
                    Image(systemName: "text.word.spacing")
                    Text("Посты")
                }
                .tag(1)
                
                
                Text("Tab 3")
                    .tabItem {
                        Image(systemName: "plus")
                        Text("Создать")
                    }
                    .tag(2)
                
                Text("Tab 4")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Поиск")
                    }
                    .tag(3)
                
                Text("Tab 5")
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Профиль")
                    }
                    .tag(4)
            }
            .toolbarBackground(Constants.Colors.modalGreyColor, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .padding(.top, 7)
        }
        .accentColor(Constants.Colors.accentOrangeColor)
    }
}

#Preview {
    RootView()
}
