//
//  LocationSearchView.swift
//  uber
//
//  Created by moji on 6/3/1402 AP.
//

import SwiftUI

struct LocationSearchView: View {
    @State private  var  startLocation = ""
    @Binding var ShowLocationSearchView    :Bool
    @EnvironmentObject private var viewModel :LocationSearchViewModel
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
            ScrollView{
                VStack{
                    ForEach(viewModel.result   ,id: \.self){ result  in
                        
                        LocationSearchResultCellView(title: result.title, subTitle: result.subtitle).onTapGesture {
                            viewModel.SelectionLocation(result)
                            ShowLocationSearchView.toggle()
                        }
                    }
                }
            }
            
        }	.background(Color.white)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(ShowLocationSearchView: .constant(false))
    }
}
