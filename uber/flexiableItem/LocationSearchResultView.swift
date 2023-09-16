//
//  LocationSearchResultView.swift
//  uber
//
//  Created by moji on 6/24/1402 AP.
//

import SwiftUI

struct LocationSearchResultView: View {
    @StateObject var viewModel :LocationSearchViewModel
    @State var config : locationResultViewConfig
    var body: some View {
        ScrollView{
            VStack{
                ForEach(viewModel.result   ,id: \.self){ result  in
                    LocationSearchResultCellView(title: result.title, subTitle: result.subtitle).onTapGesture {
                        withAnimation(.spring()){
                            viewModel.SelectionLocation(result,config: config)
                        }
                    }
                }
            }
        }
    }
}

