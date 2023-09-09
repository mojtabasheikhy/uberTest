//
//  RegisterView.swift
//  uber
//
//  Created by DEVELOPER-09 on 6/13/1402 AP.
//

import SwiftUI

struct RegisterView: View {
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @Environment (\.dismiss) private var dismiss
    @EnvironmentObject var viewModel :AuthViewModel
    var body: some View {
       
        ZStack{
            Color(.black).ignoresSafeArea()
            VStack(alignment: .leading){
                Button{
                    dismiss()
                }label: {
                    Image(systemName: "arrow.left").resizable()
                        .frame(width: 25, height: 20)
                        .foregroundColor(.white)
                }.padding(.top , 45)
                Text("Creat new Acount")
                    .frame(width: 250)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .padding(.top , 45)
                    .padding(.horizontal , -30)
                CustomInputFiled(text: $name, Hint: "Enter Your Name", Title: "first Name").padding(.top , 30)
                CustomInputFiled(text: $email, Hint: "Enter Your Email", Title: "Email Address")
                CustomInputFiled(text: $password, Hint: "Enter Your Password", Title: "Password",isSecureField: true)
                Spacer()
                Button{
                    viewModel.register(withEmail: email, password: password,fullname: name)
                }label: {
                    Text("register")
                        .font(.system(size: 18 , weight: .bold))
                        .padding(10)
                        .frame(maxWidth: .infinity,alignment: .center).foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                
                
            }.padding(.horizontal)
            
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
