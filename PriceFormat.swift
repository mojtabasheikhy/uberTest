//
//  PriceForma.swift
//  uber
//
//  Created by DEVELOPER-09 on 6/12/1402 AP.
//

import Foundation

extension Double{
    private var currencyFormater : NumberFormatter {
        let formater = NumberFormatter()
        formater.numberStyle = .currency
        formater.maximumIntegerDigits = 2
        formater.minimumIntegerDigits = 2
        return formater
        
        
    }
    private var DistanceFormater : NumberFormatter {
        let formater = NumberFormatter()
        formater.numberStyle = .decimal
        formater.maximumIntegerDigits = 0
        formater.minimumIntegerDigits = 1
        return formater
        
        
    }
    func toCurrency() -> String {
        return currencyFormater.string(for:  self) ?? ""
    }
    func distanceInMilesString() -> String{
        DistanceFormater.string(for: self) ?? ""
    }
    
}
