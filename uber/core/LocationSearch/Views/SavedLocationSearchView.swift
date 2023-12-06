//
//  SavedLocationSearchViewModel.swift
//  uber
//
//  Created by moji on 6/23/1402 AP.
//

import SwiftUI
enum locationResultViewConfig{
    case ride
    case saveLocation(SavedLocationViewModel)
}
struct SavedLocationSearchView: View {
    @State var SearchText = ""
    @StateObject var viewModel  = HomeViewModel()
    let config : SavedLocationViewModel
    var body: some View {
        VStack{
            
              TextField("Search for Location ...", text: $viewModel.querySearch)
                    .frame(height: 35)
                    .padding(.leading)
                    .background(Color(.systemGray5))
                
                    .cornerRadius(10)
                    .padding(.trailing)
          
            Spacer()
            LocationSearchResultView(viewModel: viewModel,config: locationResultViewConfig.saveLocation(config))
                
        }.navigationTitle(config.Subtitle)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct SavedLocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SavedLocationSearchView(config: SavedLocationViewModel.Home)
        }
    }
}
