//
//  SavedLocationRowView.swift
//  uber
//
//  Created by moji on 6/17/1402 AP.
//

import SwiftUI

struct SavedLocationRowView: View {
    var savedLocationViewModel : SavedLocationViewModel
    let user :User
    var body: some View {
        HStack(alignment: .center){
            Image(systemName: savedLocationViewModel.ImageName)
                .foregroundColor(Color(.systemBlue))
                .font(.title)
                
            VStack(alignment: .leading, spacing: 4){
                Text(savedLocationViewModel.title).font(.system(size : 15,weight: .semibold))
                Text(savedLocationViewModel.subtilte(user: user)).font(.system(size : 13,weight: .light)).foregroundColor(.gray)
            }
            Spacer()
           
        }
    }
}
