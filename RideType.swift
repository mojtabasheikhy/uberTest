//
//  RideType.swift
//  uber
//
//  Created by DEVELOPER-09 on 6/12/1402 AP.
//

import Foundation

enum RideType :Int, CaseIterable , Identifiable{
case uber
case black
case uberXl
    
    var id: Int{return rawValue}
    
    var description :String{
        switch self{
        case .uber : return "uber"
        case .black : return "black"
        case .uberXl : return "uberx"
        }
    }
    var imageName  : String{
        switch self{
        case .uber : return "uber"
        case .black : return "black"
        case .uberXl : return "uberx"
        }
    }
    var cost : String{
        switch self{
        case .uber : return "250"
        case .black : return "650"
        case .uberXl : return "800"
        }
    }
    
    var baseFare :Double {
        switch self{
        case .uber : return 5
        case .black : return 20
        case .uberXl : return 50
        }
    }
    func computePrice(for distanceInMeter : Double ) -> Double{
        let distanceMiles = distanceInMeter / 1600
        switch self{
        case .uber : return distanceMiles * 1.6 + baseFare
        case .black : return distanceMiles * 1.6 + baseFare
        case .uberXl : return distanceMiles * 1.6 + baseFare
        }
        
        
    }
    
}
