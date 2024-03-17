//
//  AuthViewModel.swift
//  musial-mobile
//
//  Created by Danil Perednja on 28.03.2024.
//

import Foundation

class AuthViewModel: ObservableObject
{
    private let successLoginMessage = "You have successfully logged in."
    @Published var showLogin = false
    @Published var showRegister = false
    @Published var showReset = false
    @Published var isSuccessAuth = false
    @Published var errorState: ErrorState = .None
    @Published var loginCounter = 0
    @Published var jwt = ""
    
    init() {
        if (UserDefaults.standard.bool(forKey: "isAuth")) {
            isSuccessAuth = true
        }
    }

    
    private func validatePassword(password: String) -> Bool {
        let control = #"(?=.{8,})(?=.*[0-9a-zA-Z])(?=.*[!#$%&? "])"#
        if password.range(of: control, options: .regularExpression) != nil {
            print("true!")
            return true
        }
        print("false!")
        return false
        //        return true
    }
    

    // Server post request // for signin, signup and reset password
    func postRequest(endpoint: String, body: [String: Any], callback: @escaping (String) -> Void, _ requestType: String = "POST") {
        self.jwt = ""
        let url = URL(string: "http://127.0.0.1:3000/api/v1/\(endpoint)")!
        var request = URLRequest(url: url)
        request.httpMethod = requestType
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("No data received from server")
                return
            }
            
            do {
                let authResponse = try JSONDecoder().decode(RegLogResponse.self, from: data)
//                if authResponse.id < 0 {
//                    DispatchQueue.main.async {
//                        self.errorState = .Error(message: authResponse.token)
//                    }
//                    return
//                } else {
                    // token received
                    self.errorState = .Success(message: "Successful.")
                    UserDefaults.standard.setValue(authResponse.jwt, forKey: "jwt")
                    self.isSuccessAuth = true
                    self.jwt = authResponse.jwt
                    callback(self.jwt)
//                }
            } catch {
                print(error)
            }
        }.resume()
    }
}

