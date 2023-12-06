//
//  UberLocation.swift
//  uber
//
//  Created by DEVELOPER-09 on 6/12/1402 AP.
//

import CoreLocation

struct UberLocation :Identifiable  {
    let id = NSUUID().uuidString
    var  title : String
    var  coordiante : CLLocationCoordinate2D
}
