//
//  SavedLocationRowView.swift
//  uber
//
//  Created by moji on 6/17/1402 AP.
//

import SwiftUI

struct SavedLocationRowView: View {
    let imageName: String
    let title : String
    let subTitle : String
    var body: some View {
        HStack(alignment: .center){
            Image(systemName: imageName)
                .foregroundColor(Color(.systemBlue))
                .font(.title)
                
            VStack(alignment: .leading, spacing: 4){
                Text(title).font(.system(size : 15,weight: .semibold))
                Text(subTitle).font(.system(size : 13,weight: .light)).foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .imageScale(.small)
                .font(.title3)
                .foregroundColor(.gray)
        }
    }
}

struct SavedLocationRowView_Previews: PreviewProvider {
    static var previews: some View {
        SavedLocationRowView(imageName:"house" , title: "t", subTitle: "string")
    }
}
