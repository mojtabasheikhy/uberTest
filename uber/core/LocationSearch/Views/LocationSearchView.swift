//
//  LocationSearchView.swift
//  uber
//
//  Created by moji on 6/3/1402 AP.
//

import SwiftUI

struct LocationSearchView: View {
    @State private  var  startLocation = ""
 
    @EnvironmentObject private var viewModel :HomeViewModel
    var body: some View {
        VStack{
            //header View
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6  ,height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1  ,height: 20)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6  ,height: 6)
                }
                VStack{
                        TextField("مختصات فعلی"  , text: $startLocation)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    TextField("مقصد"         , text: $viewModel.querySearch).frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                }
            }
            .padding(.top , 74)
            .padding(.horizontal)
            Divider().padding(.vertical)
            
            //Footer View
            LocationSearchResultView(viewModel: viewModel,config: locationResultViewConfig.ride)
            
        }	.background(Color.uiColor(.Background))
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}

