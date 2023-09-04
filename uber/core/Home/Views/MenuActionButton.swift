//
//  MenuActionButton.swift
//  uber
//
//  Created by moji on 6/3/1402 AP.
//

import SwiftUI

struct MenuActionButton: View {
    @EnvironmentObject var locationSearchViewModel : LocationSearchViewModel
    @Binding var isShowSearchView :MapViewState
    var body: some View {
       Button{
           withAnimation(.spring()){
                actionForState(isShowSearchView)
              }
            }label: {
                Image(systemName: imageNameForState(isShowSearchView))
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                    .background(.white)
                    .clipShape(Circle())
                    .shadow( color: .black , radius: 5 )
            }.frame(maxWidth: .infinity , alignment: .leading)
        }
    func actionForState(_ state:MapViewState){
        switch state{
        case .noInput :
            print("searching For Location")
            
        case .searchingForLocation:
            isShowSearchView = .noInput
            print("searching For Location")
            
        case .locationSelected  , .PolyLineAdded:
            isShowSearchView = .noInput
            locationSearchViewModel.selectedUberLocation = nil
      }
    }
    
    func imageNameForState(_ state:MapViewState)->String{
       switch state{
        case .noInput :
            return "line.3.horizontal"
            
       case .searchingForLocation,.locationSelected , .PolyLineAdded:
           return "arrow.left"
           
       default :
           return "arrow.left"
        
      }
    }
    
}

struct MenuActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuActionButton(isShowSearchView: .constant(MapViewState.searchingForLocation) )
    }
}
