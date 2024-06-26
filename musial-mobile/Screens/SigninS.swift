//
//  LoginS.swift
//  AuthSUI8
//  Created by brfsu on 13.03.2024.
//
import SwiftUI

struct SigninS: View {
    @StateObject private var viewModel = AuthViewModel()
    @Binding var errorState: ErrorState
    
    @State private var authorized = false
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    @Environment(\.dismiss) var dismiss
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                VStack(spacing: 20) {
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).onAppear {
                            email = ""
                            password = ""
                        }
                    PasswordTextField("Password", text: $password, isSecure: !isPasswordVisible)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay {
                            HStack {
                                Spacer()
                                Button {
                                    isPasswordVisible.toggle()
                                } label: {
                                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.secondary)
                                }
                                .padding(.trailing, 8)
                            }
                        }
                    
                    Button {
                        let body: [String: Any] = [
                            "sign_in": [
                                    "email": email,
                                    "password": password
                                ]
                            ]

                        viewModel.postRequest(endpoint: "sign_in", body: body, callback: { jwt in
                            if jwt.count > 0 {
                                print(jwt)
                                authorized = true
                                errorState = .Success(message: "Signed in successfully.")
                            }
                        })
                    } label: {
                        Text("Login")
                            .font(.system(size: 25, weight: .bold))
                            .frame(width: 200, height: 50)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    
                    // go back
                    Button {
                        dismiss()
                    } label: {
                        Text("Back")
                            .font(.system(size: 25, weight: .bold))
                            .frame(width: 200, height: 40)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }.navigate(to: RootView(), when: $authorized)
            }.padding()
        }
        .onReceive(viewModel.$errorState) { newState in
            if case .Success(_) = errorState {
                if case .None = newState {
                    return
                }
            }
            withAnimation {
                errorState = newState
            }
        }
        .navigationTitle("Sign in")
        .overlay (
            ErrorView(errorState: $errorState)
        )
    }
}

extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                
                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
//        .navigationViewStyle(.stack)
    }
}
