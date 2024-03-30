//
//  UserProfileCV.swift
//  musial-mobile
//
//  Created by Danil Perednja on 30.03.2024.
//

import SwiftUI

struct UserProfileCV: View {
    
    @StateObject var viewModel = UserModel()
    
    var body: some View {
        VStack(spacing: 20){
            Section {
                ChangableAvatarView(viewModel: viewModel)
            }.frame(width: 136, height: 136, alignment: .center).padding(.top, 50)
            Form {
                List{
                    
                    Section {
                        HStack(spacing: 12){
                            Image("NameIcon")
                            VStack(alignment: .leading, spacing: 2){
                                Text("Имя").foregroundStyle(Color.gray).font(.footnote)
                                TextField("Name", text: $viewModel.name, prompt: Text("Имя")).frame(alignment: .center).font(.subheadline)
                            }
                        }
                    }
                    
                    Section{
                        HStack(spacing: 12){
                            Image("NicknameIcon")
                            VStack(alignment: .leading, spacing: 2){
                                Text("Ник").foregroundStyle(Color.gray).font(.footnote)
                                TextField("Nickname", text: $viewModel.nickname, prompt: Text("Nickname")).frame(alignment: .center).font(.subheadline)
                            }
                        }
                    }
                    
                    Section {
                        HStack(spacing: 12){
                            Image("EmailIcon")
                            VStack(alignment: .leading, spacing: 2){
                                Text("Почта").foregroundStyle(Color.gray).font(.footnote)
                                TextField("Email", text: $viewModel.email, prompt: Text("Email name")).frame(alignment: .center).font(.subheadline)
                            }
                        }
                    }
                }.listSectionSpacing(.compact)
                
                List{
                }.listSectionSpacing(.compact)
            }.scrollContentBackground(.hidden)
                .padding().onAppear{
                    restore(viewModel: viewModel)
                }
            
            HStack(alignment: .center, spacing: 12){
                
                PrimaryButton(text: "сохранить") {
                    viewModel.saveInUserDefaults()
                }
            }.padding().padding(.bottom, 52)
        }.background(Constants.Colors.modalGreyColor)
    }
    
    @MainActor
    func restore(viewModel: UserModel) {
        let data = UserDefaults.standard.data(forKey: "Avatar") ?? UIImage(named: "Warning")!.jpegData(compressionQuality: 1)!
        let image = UIImage(data: data)!
        viewModel.setImageStateSuccess(image: Image(uiImage: image))
//        let df = DateFormatter()
//        df.dateFormat = "dd/MM/yyyy HH:mm"
//        var birthdayString = df.string(from: viewModel.birthday)
        
        for key in viewModel.keyValues {
            switch key {
                case "Name": viewModel.name = UserDefaults.standard.string(forKey: key) ?? ""
                case "Email": viewModel.email = UserDefaults.standard.string(forKey: key) ?? ""
                case "Nickname": viewModel.nickname = UserDefaults.standard.string(forKey: key) ?? ""
                case "TG": viewModel.tg = UserDefaults.standard.string(forKey: key) ?? ""
                //case "Birthday": viewModel.birthday = UserDefaults.standard.object(forKey: key) as! Date

            default: print("Unknown value")

            }
        }
    }
}
