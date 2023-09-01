//
//  LocationSearchResultCellView.swift
//  uber
//
//  Created by moji on 6/3/1402 AP.
//

import SwiftUI

struct LocationSearchResultCellView: View {
    let title : String
    let subTitle :String
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.gray)
                .frame(width: 40 , height: 40)
            VStack (alignment: .leading, spacing: 4 ){
                Text(title).font(.body)
                Text(subTitle)
                    .foregroundColor(.gray)
                    .font(.system(size: 15))
                Divider()
            }
            .padding(.leading, 5)
            .padding(.vertical, 5)
        } .padding(.leading)
    }
}

struct LocationSearchResultCellView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCellView(title: "sd", subTitle: "sad")
    }
}
