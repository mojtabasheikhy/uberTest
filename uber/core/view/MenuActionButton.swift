//
//  MenuActionButton.swift
//  uber
//
//  Created by moji on 6/3/1402 AP.
//

import SwiftUI

struct MenuActionButton: View {
    @Binding var isShowSearchView :Bool
    var body: some View {
       Button{
           withAnimation(.spring()){
                isShowSearchView.toggle()
              }
            }label: {
                Image(systemName: !isShowSearchView ?  "line.3.horizontal" : "arrow.left")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                    .background(.white)
                    .clipShape(Circle())
                    .shadow( color: .black , radius: 5 )
            }.frame(maxWidth: .infinity , alignment: .leading)
        }
    
}

struct MenuActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuActionButton(isShowSearchView: .constant(true) )
    }
}
