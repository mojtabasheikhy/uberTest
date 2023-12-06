//
//  GeoPoint.swift
//  uber
//
//  Created by developer09 on 12/6/23.
//

import Firebase
import CoreLocation

extension GeoPoint{
    func toCoordinate()->CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
