//
//  SideMenuView.swift
//  uber
//
//  Created by moji on 6/17/1402 AP.
//

import SwiftUI

struct SideMenuView: View {
    private let user :User
    init(user: User) {
        self.user = user
    }
    var body: some View {
        
    NavigationStack {
        VStack(spacing: 40){
                VStack(alignment: .leading,  spacing: 25    ){
                    HStack{
                        Image("profile").resizable()
                            .clipShape(Circle())
                            .frame(width: 64, height: 64)
                        VStack(alignment: .leading, spacing:12){
                            Text(user.fullName).font(.system(size : 15,weight: .semibold))
                            Text(user.email).font(.system(size : 13,weight: .light))
                        }
                        
                    }
                    VStack(alignment: .leading , spacing: 20){
                        Text("Do more with your account ?")
                            .font(.footnote)
                            
                            .fontWeight(.semibold)
                        
                        HStack(){
                            Image(systemName: "dollarsign.square")
                                .font(.title2)
                                .imageScale(.medium)
                            Text("Make money Driving").font(.system(size: 16,weight: .semibold))
                        }
                    }
                    Divider().frame(width: 294 ,height: 1)
                        .foregroundColor(Color(.separator))
                        .shadow(color: .black,radius: 4)
                }
                .frame(maxWidth: .infinity , alignment: .leading).padding(.horizontal)
               
                VStack{
                    ForEach(SideMenuOptionViewModel.allCases){option in
                        NavigationLink(value: option){
                            SideMenuOptionView(viewModel: option).padding()
                        }
                    }
                }.navigationDestination(for:SideMenuOptionViewModel.self){ viewModel in
                    switch viewModel {
                   
                    case .trips:
                        Text("Trips")
                    case .wallet:
                        Text("wallet")
                    case .settings :
                        SettingsView(user: user)
                    case .messages:
                        Text("message")
                    }
                   
                }
                Spacer()
             
            }
            
            .padding(.top , 32)
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(user: dev.mockUser)
    }
}
