//
//  HomeViewModel.swift
//  uber
//
//  Created by moji on 6/24/1402 AP.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class HomeViewModel : ObservableObject {
    @Published var drivers = [User]()
    init(){
        fetchDriver()
    }
    func fetchDriver(){
        Firestore.firestore().collection(AppConstant.UserCollection)
            .whereField(AppConstant.accountType,isEqualTo: AppConstant.Driver)
            .getDocuments { snappShot, _ in
                guard let document = snappShot?.documents else {return}
                let drivers  = document.compactMap( {try? $0.data(as : User.self)} )
                self.drivers  = drivers
                print("\(drivers)")
                
            }
    }
    
}
