//
//  User.swift
//  uber
//
//  Created by moji on 6/15/1402 AP.
//

import Foundation
import Firebase
    
enum AccountType : Int ,Codable {
    case passenger
    case driver
}
struct User :Codable{
    let fullName : String
    let email : String
    let uid : String
    var homeLocation : SavedLocation?
    var accountType : AccountType
    var coordiante : GeoPoint
    var workLocation : SavedLocation?
}
