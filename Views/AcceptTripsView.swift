//
//  AcceptTripsView.swift
//  uber
//
//  Created by developer09 on 12/4/23.
//

import SwiftUI
import MapKit

struct AcceptTripsView: View {
    @State var region : MKCoordinateRegion
    @EnvironmentObject var homeViewModel : HomeViewModel
    let trips : Trips
    let annotionItem : UberLocation
    init(trip : Trips) {
        self.trips = trip
        let center = CLLocationCoordinate2D(
            latitude:trip.pickUpLocation.latitude ,
            longitude: trip.pickUpLocation.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        self.region = MKCoordinateRegion(center: center, span: span)
        self.annotionItem =
        UberLocation(title: trip.pickUpLocationName, coordiante: trip.pickUpLocation.toCoordinate())
    }
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(.gray)
                .frame(width: 48, height: 8).padding(.top , 8)
            HStack{
                Text("would you like to pickup this passenger ?")
                    .font(.headline)
                    .fontWeight(.semibold).lineLimit(2)
                    .multilineTextAlignment(.leading).frame(height: 44)
                    .padding(.horizontal)
                
                Button {
                    
                } label: {
                    VStack{
                        Text("\(trips.travelTimeToPassenger)").bold()
                        Text("min").bold()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                }

            }
            VStack{
                HStack{
                    Image("profile1")
                        .resizable()
                        .frame(width:  100 ,height:  100)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        
                        Text(trips.passnegerName).fontWeight(.bold)
                        HStack(){
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                            Text("4.7")
                                .foregroundColor(.gray)
                                .font(.footnote)
                        }
                    }
               
                   
                    VStack{
                        Text("Earning")
                        Text(trips.tripsCost.toCurrency()).font(.system(size: 24, weight: .bold))
                    }
                }
                Divider()
            }.padding(.horizontal)
            VStack{
                HStack{
                    VStack(alignment: .leading) {
                        
                        Text(trips.pickUpLocationName)
                            .font(.headline)
                        Text(trips.pickUpLocationAddress)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                    }
                    Spacer()
                    VStack{
                        Text(trips.distanceToPassenger.distanceInMilesString())
                        Text("mile")
                            .foregroundColor(.gray)
                            .font(.footnote)
                    }
                        
                }.padding(.horizontal)
            }
            Map(coordinateRegion: $region, annotationItems: [annotionItem] ){ item in
                MapMarker(coordinate:item.coordiante)
                
              }
                .frame(height: 220)
                .cornerRadius(15)
                .shadow(color: .gray, radius: 15)
                .padding(.horizontal)
            HStack{
                Button(action: {
                    homeViewModel.rejectTrips()
                }, label: {
                    Text("Reject")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: (UIScreen.main.bounds.width/2)-32, height: 56)
                        .background(Color(.systemRed))
                        .cornerRadius(10)
                })
                Spacer()
                
                Button(action: {
                    homeViewModel.acceptTrips()
                }, label: {
                    Text("Accept")  
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: (UIScreen.main.bounds.width/2)-32, height: 56)
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                })
            }
            .padding(.top, 20)
            .padding(.bottom , 20 )
            .padding(.horizontal)
        }
        .background(Color.uiColor(.Background))
            
            .cornerRadius(15)
    }
}

#Preview {
    AcceptTripsView(trip: DeveloperPreView.shared.mockTrips)
}
