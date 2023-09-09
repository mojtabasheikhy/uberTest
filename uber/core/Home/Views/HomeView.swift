//
//  HomeView.swift
//  uber
//
//  Created by moji on 5/27/1402 AP.
//

import SwiftUI

struct HomeView: View {
    
   
    @State private var mapViewState  = MapViewState.noInput
    @State private var showSideMenu  = false
    @EnvironmentObject var locationViewModel :LocationSearchViewModel
    @EnvironmentObject var authViewModel : AuthViewModel
    var body: some View {
        Group{
            if authViewModel.userSession == nil {
                LoginView()
            }
            else if let user = authViewModel.currentUser {
                NavigationStack{
                    ZStack{
                        if showSideMenu {
                            SideMenuView(user: user)
                        }
                        mapView
                            .offset(x: showSideMenu ? 316 :0)
                            .shadow(color:showSideMenu ? .black : .clear ,radius:showSideMenu ? 4 : 0)
                    }.onAppear{
                        showSideMenu = false
                    }
                  
                }
               
            }
        }
        
    }
}
extension HomeView {
    var mapView : some View {
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
                MenuActionButton(isShowSearchView: $mapViewState,isShowSideMenu:$showSideMenu)
                    .padding(.leading)
                    .padding(.top , 10)
                
            }
            if mapViewState == .locationSelected  || mapViewState == .PolyLineAdded {
                TripsView().transition(.move(edge: .bottom))
            }
        }
        .onReceive(LocationManager.shared.$userLocation) { locationManager in
            if locationManager != nil{
                locationViewModel.userLocation = locationManager
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AuthViewModel())
    }
}
