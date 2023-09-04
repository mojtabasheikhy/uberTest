//
//  Color.swift
//  uber
//
//  Created by DEVELOPER-09 on 6/13/1402 AP.
//

import Foundation
import SwiftUI
enum AssetsColor : String
{
    case SecondaryBackground
    case Background
    case TextPrimary


}
extension Color {
    static func uiColor(_ name: AssetsColor) -> Color
     
    {
          return Color(name.rawValue)
    
    }
}
