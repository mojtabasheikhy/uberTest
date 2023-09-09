//
//  LoginView.swift
//  uber
//
//  Created by DEVELOPER-09 on 6/13/1402 AP.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var authViewModel : AuthViewModel
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack{
                ZStack(alignment: .top){
                    Color(.black).ignoresSafeArea()
                    VStack{
                        VStack{
                            
                            Image("uberIcon").resizable().frame(width: 100 ,height: 100)
                            Text("UBER").foregroundColor(.white).font(.system(size: 25, weight: .bold))
                            
                            
                        }
                        
                        CustomInputFiled(text: $email, Hint: "m.s.fardad@gmail.com", Title: "Your Email")
                            .padding()
                            .padding(.top , 20)
                        
                        CustomInputFiled(text: $password, Hint: "Enter your password", Title: "Your password" , isSecureField: true)
                            .padding()
                            .padding(.top , 20)
                        
                        Button{}label: {
                            Text("forgot Your Password")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(Color.white)
                        }.frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing , 15)
                        
                        HStack(alignment: .center, spacing: 12){
                            Rectangle().foregroundColor(.white)
                            
                                .frame(width: 50 , height: 0.7)
                            Text("sign in With social").foregroundColor(.white)
                            Rectangle().foregroundColor(.white).frame(width:50 , height: 0.7)
                        }.padding(.top , 45)
                        
                        HStack(spacing: 12){
                            Button{}label: {
                                Image("google")
                                    .resizable()
                                    .frame(width: 20 , height: 20)
                                    .padding()
                                    .background(Circle().foregroundColor(.secondary))
                            }
                            Button{}label: {
                                Image("facebook")
                                    .resizable()
                                    .frame(width: 20 , height: 20)
                                    .padding()
                                    .background(Circle().foregroundColor(.secondary))
                            }
                            
                            
                        }.padding(.top , 8)
                        
                        Spacer()
                      
                        
                        Button{
                            authViewModel.singIn(wihtEmail: email, password: password)
                            
                        }label: {
                            HStack{
                                Text("sing In").foregroundColor(.black)
                                Image(systemName:"arrow.right").foregroundColor(.black)
                                
                            }.frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                            
                                .cornerRadius(8)
                            
                        }.padding(.top,10)
                        
                        HStack{
                            Text("Dont Have an account?").foregroundColor(.white)
                            NavigationLink{
                                RegisterView().navigationBarBackButtonHidden()
                            }label: {
                                Text("register")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        
                    }
                }
            }
        } else {
            NavigationView{
                LoginViewBody
            }
        }
        
    }
    var  LoginViewBody  :some View{
        ZStack(alignment: .top){
            Color(.black).ignoresSafeArea()
            VStack{
                VStack{
                    
                    Image("uberIcon").resizable().frame(width: 100 ,height: 100)
                    Text("UBER").foregroundColor(.white).font(.system(size: 25, weight: .bold))
                    
                    
                }
                
                CustomInputFiled(text: $email, Hint: "m.s.fardad@gmail.com", Title: "Your Email")
                    .padding()
                    .padding(.top , 20)
                
                CustomInputFiled(text: $password, Hint: "Enter your password", Title: "Your password" , isSecureField: true)
                    .padding()
                    .padding(.top , 20)
                
                Button{}label: {
                    Text("forgot Your Password")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(Color.white)
                }.frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing , 15)
                
                HStack(alignment: .center, spacing: 12){
                    Rectangle().foregroundColor(.white)
                    
                        .frame(width: 50 , height: 0.7)
                    Text("sign in With social").foregroundColor(.white)
                    Rectangle().foregroundColor(.white).frame(width:50 , height: 0.7)
                }.padding(.top , 45)
                
                HStack(spacing: 12){
                    Button{}label: {
                        Image("google")
                            .resizable()
                            .frame(width: 20 , height: 20)
                            .padding()
                            .background(Circle().foregroundColor(.secondary))
                    }
                    Button{}label: {
                        Image("facebook")
                            .resizable()
                            .frame(width: 20 , height: 20)
                            .padding()
                            .background(Circle().foregroundColor(.secondary))
                    }
                    
                    
                }.padding(.top , 8)
                
                Spacer()
                Button{}label: {
                    HStack{
                        Text("sing In").foregroundColor(.black)
                        Image(systemName:"arrow.right").foregroundColor(.black)
                        
                    }.frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                    
                        .cornerRadius(8)
                    
                }.padding(.top,10)
                
                HStack{
                    Text("Dont Have an account?").foregroundColor(.white)
                    Button{}label: {
                        Text("register")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
