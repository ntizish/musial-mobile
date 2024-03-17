//
//  MainAuthS.swift
//  AuthSUI8
//  Created by brfsu on 13.03.2024.
//
import SwiftUI

struct MainAuthS: View {
    @State private var errorState: ErrorState = .None
    
    var body: some View {
        NavigationView {
            VStack {
                // Sign in button
                NavigationLink(destination: SigninS(errorState: $errorState)) {
                    Text("Sign in")
                }
                .font(.system(size: 25, weight: .bold))
                .frame(width: 200, height: 50)
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 5)
                    // Login button
                    
                    //                let body: [String: Any] = [
                    //                    "username": username,
                    //                    "password": password
                    //                ]
                    //                viewModel.postRequest(endpoint: "signin", body: body)
                }
                //            .disabled(!isLoginEnabled).onReceive(viewModel.$loginCounter) {
                //                counter in
                //                if (counter == 3) {
                //                    isLoginEnabled = false
                //                } else {
                //                    isLoginEnabled = true
                //                }
                //            }

                
                // Reset password button
                NavigationLink(destination: ResetS(errorState: $errorState)) {
                    Text("Reset password")
                }
                .font(.system(size: 25, weight: .bold))
                .frame(width: 200, height: 30).padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 5)
                }
                
                
                // Sign up button
                NavigationLink(destination: SignupS(errorState: $errorState)) {
                    Text("Sign up")
                }
                .font(.system(size: 25, weight: .bold))
                .frame(width: 200, height: 30).padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 5)
                }
                
                
                // Delete user account button
                NavigationLink(destination: DropS(errorState: $errorState)) {
                    Text("Delete account")
                }
                .font(.system(size: 25, weight: .bold))
                .frame(width: 200, height: 30).padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 5)
                }
                
            }.navigationTitle("Auth")
        }
    }
}
