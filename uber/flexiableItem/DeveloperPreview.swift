//
//  DeveloperPreview.swift
//  uber
//
//  Created by moji on 6/24/1402 AP.
//

import Foundation
import SwiftUI
import Firebase

extension PreviewProvider{
    static var dev : DeveloperPreView{
        return DeveloperPreView.shared
    }
}
class DeveloperPreView{
    static var shared = DeveloperPreView()
    var mockUser = User(fullName: "mojtaba",
                        email: "m.s.fardad@gmail.com",
                        uid: "123456",
                        accountType: AccountType.driver, coordiante: GeoPoint(latitude: 37.38, longitude: -122.05))
}
