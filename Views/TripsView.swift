//
//  TripsView.swift
//  uber
//
//  Created by moji on 6/15/1402 AP.
//

import SwiftUI

struct TripsView: View {
    @State var selectedRideType : RideType = .uber
    @EnvironmentObject var locationSearchViewModel : LocationSearchViewModel
    var body: some View {
            VStack{
                Capsule()
                    .foregroundColor(Color.gray)
                    .frame(width: 45 , height: 5)
                    .padding(.vertical)
                HStack{
                    VStack{
                        Circle()
                            .fill(Color(.systemGray3))
                            .frame(width: 8  ,height: 8)

                        Rectangle()
                            .fill(Color(.systemGray3))
                            .frame(width: 1  ,height: 20)
                        Rectangle()
                            .fill(.black)
                            .frame(width: 8  ,height: 8)
                    }
                    VStack(alignment: .leading, spacing: 24){
                        HStack{
                            Text("").font(.system(size: 16,weight: .semibold)).foregroundColor(Color.gray)
                            Spacer()
                            Text(locationSearchViewModel.pickUpTime ?? "").font(.system(size: 14)).foregroundColor(Color.gray)
                        }.padding(.bottom , 10)

                        HStack{
                            Text(locationSearchViewModel.selectedUberLocation?.title ?? "").font(.system(size: 16,weight: .bold))
                            Spacer()
                            Text(locationSearchViewModel.dropOffTime ?? "").font(.system(size: 14)).foregroundColor(Color.gray)
                        }


                    }.padding(.leading , 8)


                }.padding()
                Divider()
                Text("suggest For Ride")
                    .padding()
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity , alignment: .leading)

                ScrollView(.horizontal){
                    HStack(spacing: 12){
                        ForEach (RideType.allCases ,id: \.self){rideType in
                            VStack(alignment: .center,spacing:12){
                                Image(rideType.imageName).resizable()
                                    .scaledToFit().frame(width: 50 , height: 50)
                                Text(rideType.description)
                                    .font(.system(size: 16 , weight: .bold))
                                    .frame(maxWidth: .infinity , alignment: .center)
                                    .foregroundColor(rideType == selectedRideType ? .white : Color.uiColor(.TextPrimary))
                                Text(locationSearchViewModel.computePrice(type: rideType).toCurrency())
                                    .font(.system(size: 13)).foregroundColor(rideType == selectedRideType ? .white : Color.uiColor(.TextPrimary))
                                    .frame(maxWidth: .infinity , alignment: .center).padding(.bottom , 15).padding(.top , 2)
                            }
                            .scaleEffect(rideType == selectedRideType ? 1.2 : 1.0)
                                .frame(width: 112 , height: 140)
                                .background(rideType == selectedRideType ? Color.blue : Color.uiColor(.SecondaryBackground))
                                .cornerRadius(15)

                                .onTapGesture {
                                    withAnimation(.spring()){
                                        selectedRideType = rideType
                                    }
                                }

                        }
                    }
                }
                .padding(.horizontal)
                Divider()
                HStack(){
                    Text("visa")
                        .padding(7)
                        .background(.blue)
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .cornerRadius(10)
                        .padding(10)

                    Text("****12321")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity)
                .background(Color(.systemGroupedBackground)).cornerRadius(10)
                .padding(.horizontal )

                Button{}label: {
                    Text("Confirm Request")
                        .padding()
                        .frame(width: UIScreen.main.bounds.width-32 , height: 52)
                        .background(.blue)

                        .foregroundColor(Color.white)
                        .cornerRadius(8)
                }  .padding(.bottom , 15)
            }

            .background(Color.uiColor(.Background))

            .cornerRadius(15)
        }
}

struct TripsView_Previews: PreviewProvider {
    static var previews: some View {
        TripsView()
    }
}
