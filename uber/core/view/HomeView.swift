//
//  HomeView.swift
//  uber
//
//  Created by moji on 5/27/1402 AP.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showSearchView = false
    var body: some View {
        ZStack(alignment: .top ){
            UberMapViewRepresantable()
                .ignoresSafeArea()
            
            if showSearchView {
                LocationSearchView(ShowLocationSearchView: $showSearchView)
            }else {
                LocationSearchActivationView().padding(.top , 72)
                    .onTapGesture {
                        withAnimation(.spring()){
                            showSearchView.toggle() 
                        }
                    }
            }
            MenuActionButton(isShowSearchView: $showSearchView)
                .padding(.leading)
                .padding(.top , 10)
           
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
