//
//  SavedLocationViewModel.swift
//  uber
//
//  Created by moji on 6/23/1402 AP.
//

import Foundation
enum SavedLocationViewModel : Int , CaseIterable , Identifiable {
    case Home
    case Work
    
    var title   :String{
        switch self {
        case .Home : return "Home"
        case .Work : return "Work"
                
        }
    }
    var Subtitle   :String{
        switch self {
        case .Home : return "Add home"
        case .Work : return "Add work"
                
        }
    }
    var ImageName : String {
        switch self {
           case .Home : return "house.circle.fill"
           case .Work : return "archivebox.circle.fill"
       }
    }
    var dataBasekey : String {
        switch self {
           case .Home : return AppConstant.UserHomeLocation
           case .Work : return AppConstant.UserWorkLocation
       }
    }
    var id :Int {
        return self.rawValue
    }
    
    func subtilte(user :User)->String{
        switch self{
        case .Home :
            if let homeLocation = user.homeLocation{
                return homeLocation.title
            }else {
                return "add Home"
            }
        case .Work :
            if let workLocation = user.workLocation{
                return workLocation.title
            }else {
                return  "add Work"
            }
        }
    }
}
