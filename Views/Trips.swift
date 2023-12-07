//
//  Trips.swift
//  uber
//
//  Created by developer09 on 12/5/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

enum tripsState : Int , Codable {
    case requested
    case rejected
    case accepted
}

struct Trips  : Identifiable , Codable {
    @DocumentID var  tripId :String?
    let passengerUid :String
    let driverUid :String
    let passnegerName :String
    let driverName : String
    let passengerLocation : GeoPoint
    let driverLocation : GeoPoint
    let pickUpLocationName : String
    let dropoffLocationName :String
    let pickUpLocation : GeoPoint
    let dropOffLocation : GeoPoint
    let pickUpLocationAddress : String
    let tripsCost : Double
    var distanceToPassenger : Double = 0.0
    var travelTimeToPassenger : Int = 0
    var tripState :tripsState
    var id :String{
        return tripId ?? ""
    }
}
