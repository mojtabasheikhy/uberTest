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
    
    var mockTrips =
    Trips(id: "HI", passengerUid: "HI", driverUid: "HI", passnegerName: "HI", driverName: "HI",
          passengerLocation: .init(latitude: 37, longitude: 47),
          driverLocation: .init(latitude: 37, longitude: 47),
          pickUpLocationName: "HI",
          dropoffLocationName: "HI",
          pickUpLocation: .init(latitude: 37, longitude: 47),
          dropOffLocation: .init(latitude: 37, longitude: 47),
          pickUpLocationAddress: "HI", tripsCost: 24, distanceToPassenger: 10 , travelTimeToPassenger: 10)
}
