//
//  CustomInputView.swift
//  uber
//
//  Created by DEVELOPER-09 on 6/13/1402 AP.
//

import SwiftUI

struct CustomInputFiled: View {
    @Binding var text : String
    let Hint : String
    let Title : String
    var isSecureField = false
    var body: some View {
        VStack(alignment: .leading ,spacing: 12){
            Text(Title)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.white).font(.system(size: 15, weight: .bold))
            if isSecureField {
                SecureField(Hint,text: $text).foregroundColor(.white)}
            else {
                TextField(Hint,text: $text).foregroundColor(.white)
            }
            Rectangle().foregroundColor(.gray).frame(maxWidth: .infinity, maxHeight: 0.7)
        }
    }
}

struct CustomInputView_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputFiled(text: .constant("HI") , Hint: "Title"  , Title: "hint")
    }
}
