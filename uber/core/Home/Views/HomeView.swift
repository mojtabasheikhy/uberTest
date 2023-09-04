//
//  HomeView.swift
//  uber
//
//  Created by moji on 5/27/1402 AP.
//

import SwiftUI

struct HomeView: View {
    
   
    @State private var mapViewState  = MapViewState.noInput
    @EnvironmentObject var locationViewModel :LocationSearchViewModel
    var body: some View {
        ZStack(alignment: .bottom){
            ZStack(alignment: .top ){
                UberMapViewRepresantable(mapState: $mapViewState)
                    .ignoresSafeArea()
                
                if mapViewState == .searchingForLocation {
                    LocationSearchView(ShowLocationSearchView: $mapViewState)
                }else if mapViewState == .noInput {
                    LocationSearchActivationView().padding(.top , 72)
                        .onTapGesture {
                            withAnimation(.spring()){
                                mapViewState = MapViewState.searchingForLocation
                            }
                        }
                }
                MenuActionButton(isShowSearchView: $mapViewState)
                    .padding(.leading)
                    .padding(.top , 10)
               
            }
            if mapViewState == .locationSelected  || mapViewState == .PolyLineAdded {
                TripsView().transition(.move(edge: .bottom))
            }
        }.onReceive(LocationManager.shared.$userLocation) { locationManager in
            if locationManager != nil{
                locationViewModel.userLocation = locationManager
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
