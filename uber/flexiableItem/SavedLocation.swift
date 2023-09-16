//
//  SavedLocation.swift
//  uber
//
//  Created by moji on 6/24/1402 AP.
//

import Firebase

struct SavedLocation:Codable {
    let title : String
    let address : String
    let coordinator : GeoPoint
 
}
