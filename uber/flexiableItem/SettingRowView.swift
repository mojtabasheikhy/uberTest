//
//  SettingRowView.swift
//  uber
//
//  Created by moji on 6/17/1402 AP.
//

import SwiftUI

struct SettingRowView: View {
    let title :String
    let imageName : String
    let tintColor : Color
    
    var body: some View {
        HStack(alignment: .center){
            Image(systemName: imageName)
                .foregroundColor(tintColor)
                .font(.title)
                
            
            Text(title).font(.system(size : 15))
            
            Spacer()
           
        }.padding(2)
    }
}

struct SettingRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRowView(title: "Home", imageName: "archivebox.circle.fill", tintColor: Color.black)
    }
}
