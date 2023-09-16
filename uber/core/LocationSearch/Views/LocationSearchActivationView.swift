//
//  LocationSearchActivationView.swift
//  uber
//
//  Created by moji on 6/3/1402 AP.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack{
            Rectangle().fill(Color.black)
                .frame(width:8, height: 8).padding(.horizontal)
            Text("کجا میری ؟ ")
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width-64 , height: 50)
        	.background(Rectangle().fill(Color.white).shadow(
                color: Color.black ,  radius: 20))
    }
}

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView()
    }
}
