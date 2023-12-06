//
//  userServices.swift
//  uber
//
//  Created by developer09 on 12/4/23.
//

import Foundation
import Firebase

class userServices : ObservableObject {
    static let  shared = userServices()
    @Published var user : User?
    init() {
        fetchUser()
    }
    func fetchUser(){
        guard let userId = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection(AppConstant.UserCollection).document(userId).getDocument { snapShot, error in
            if error != nil {
                return
            }
            guard let dataUser = snapShot else {return}
            guard let user = try? dataUser.data(as: User.self) else { return}
            self.user = user
            
        }
    }
    
}
