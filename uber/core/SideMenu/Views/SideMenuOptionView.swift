//
//  SideMenuOptionView.swift
//  uber
//
//  Created by moji on 6/17/1402 AP.
//

import SwiftUI

struct SideMenuOptionView: View {
    let viewModel : SideMenuOptionViewModel
    var body: some View {
        HStack{
            Image(systemName:  viewModel.imageName).font(.title2).imageScale(.medium)
            Text(viewModel.title).font(.system(size: 16 , weight: .semibold))
            Spacer()
        }.foregroundColor(Color.uiColor(.TextPrimary))
    }
}

struct SideMenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionView(viewModel: .trips)
    }
}
