//
//  DriverAnnotation.swift
//  uber
//
//  Created by developer09 on 12/4/23.
//

import Foundation
import Firebase
import MapKit

class DriverAnnotation : NSObject , MKAnnotation{
    var coordinate :CLLocationCoordinate2D
    let userId : String
    
    init(user : User) {
        self.coordinate = CLLocationCoordinate2D(latitude: user.coordiante.latitude, longitude: user.coordiante.longitude)
        self.userId = user.uid
    }
}
