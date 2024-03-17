//
//  ContentView.swift
//  AuthSUI8
//  Created by brfsu on 07.02.2024.
//
import SwiftUI

struct StartS: View {
    @State private var navigationState: NavigationState = .Auth
    @State private var errorState: ErrorState = .None
    var body: some View {
        VStack {
            switch navigationState {
            case .Auth:
//                AuthS(navigationState: $navigationState.animation(), errorState: $errorState.animation())
                MainAuthS()
//                LoginS()
            case .Main:
                MainS(errorState: $errorState) //navigationState: $navigationState.animation())
            }
        }
        .overlay (
            ErrorView(errorState: $errorState)
        )
    }
}
