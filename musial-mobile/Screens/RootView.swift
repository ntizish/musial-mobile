//
//  TabBa.swift
//  musial-mobile
//
//  Created by Danil Perednja on 18.02.2024.
//

import Foundation
import SwiftUI

struct RootView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabBar(selectedTab: .constant(0))
    }
}

#Preview {
    RootView()
}



