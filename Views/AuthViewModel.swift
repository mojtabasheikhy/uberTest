//
//  AuthViewModel.swift
//  uber
//
//  Created by moji on 6/15/1402 AP.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine

class AuthViewModel : ObservableObject{
    @Published var userSession : FirebaseAuth.User?
    @Published var currentUser : User?
    private let services  = userServices.shared
    private var cancelable = Set< AnyCancellable>()
    init(){
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func singIn(wihtEmail email : String , password :String){
        Auth.auth().signIn(withEmail: email, password: password){authDataResult, error in
            if error != nil {
                print("\(error)")
                return
            }else {
                //self.currentUser  = authDataResult.
                self.userSession = authDataResult?.user
            }
        }
    }
    
    func register(withEmail email :String , password : String,fullname:String,accountType : AccountType){
        guard let location = LocationManager.shared.userLocation else { return }
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            if error != nil {
                print("\(String(describing: error))")
                return
            }else {
                guard let firebaseUser = authDataResult?.user else {return}
                self.userSession = firebaseUser
                let user = User(fullName:fullname , email: email, uid: firebaseUser.uid,accountType: accountType, coordiante: GeoPoint(latitude: location.latitude, longitude: location.longitude))
                self.currentUser = user
                guard let encodeUser = try? Firestore.Encoder().encode(user) else { return }
                Firestore.firestore().collection(AppConstant.UserCollection).document(firebaseUser.uid).setData(encodeUser)
                print("success")
              
            }
        }
    }
    func singOut(){
        do{
            try Auth.auth().signOut()
            self.userSession = nil

        }catch let error{
            
        }
        
    }
    
    func fetchUser(){
        services.$user.sink(receiveValue: { user in
            self.currentUser = user}
        ).store(in: &cancelable)
      //  guard let userId = self.userSession?.uid else { return }
     //   Firestore.firestore().collection(AppConstant.UserCollection).document(userId).getDocument { snapShot, error in
      //      if error != nil {
      //          return
      //      }
       //     guard let dataUser = snapShot else {return}
      //      guard let user = try? dataUser.data(as: User.self) else { return}
            
       // }
    }
}
