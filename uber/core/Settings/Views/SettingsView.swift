//
//  SettingsView.swift
//  uber
//
//  Created by moji on 6/17/1402 AP.
//

import SwiftUI

struct SettingsView: View {
    let user :User
    @EnvironmentObject var viewModel : AuthViewModel
    init(user: User) {
        self.user = user
    }
    var body: some View {
        VStack{
            List{
                Section{
                    HStack{
                        Image("profile").resizable()
                            .clipShape(Circle())
                            .frame(width: 64, height: 64)
                        VStack(alignment: .leading, spacing:12){
                            Text(user.fullName).font(.system(size : 15,weight: .semibold))
                            Text(user.email).font(.system(size : 13,weight: .light))
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .imageScale(.small)
                            .font(.title3)
                            .foregroundColor(.gray)
                        
                    }
                }
                Section("Favorites"){
                    ForEach(SavedLocationViewModel.allCases  ){viewModel2 in
                        NavigationLink{
                          SavedLocationSearchView(  config: viewModel2)
                        }label: {
                            SavedLocationRowView(savedLocationViewModel: viewModel2 ,user: user)
                        }
                   
                    }
                }
                Section("Settings"){
                    SettingRowView(title:"Notifications", imageName: "bell.circle.fill", tintColor: Color.purple)
                    SettingRowView(title:"Payment Method", imageName: "creditcard.circle.fill", tintColor: Color.blue)
                }
                Section("Account"){
                    SettingRowView(title:"make Money Driving", imageName: "dollarsign.circle.fill", tintColor: Color.green)
                    SettingRowView(title:"sing out", imageName: "arrow.left.circle.fill", tintColor: Color.red).onTapGesture {
                        viewModel.singOut()
                    }
                }
            }
        }.navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingsView(user: dev.mockUser)
        }
    }
}
