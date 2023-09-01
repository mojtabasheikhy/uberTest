//
//  LocationSearchViewModel.swift
//  uber
//
//  Created by moji on 6/3/1402 AP.
//

import Foundation
import MapKit

class LocationSearchViewModel : NSObject , ObservableObject{
    
    @Published var result = [MKLocalSearchCompletion]()
    @Published var selectionLocation : CLLocationCoordinate2D?
    private let searchCompelete = MKLocalSearchCompleter()
    var querySearch : String = ""{
        didSet{
            searchCompelete.queryFragment = querySearch
        }
    }
    override init() {
        super.init()
        searchCompelete.delegate = self
        searchCompelete.queryFragment = querySearch
    }
    func SelectionLocation(_ location :MKLocalSearchCompletion) {
        
        locationSearch(forlocalSearchCompletion: location) { response, error in
            if let error = error{
                
                return
            }
            guard let  item = response?.mapItems.first else {return}
            let coordinate = item.placemark.coordinate
            print("sd \(coordinate)")
            self.selectionLocation = coordinate
        }
    }
    func locationSearch(forlocalSearchCompletion locationSearch : MKLocalSearchCompletion ,completion2 :@escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery=locationSearch.title.appending(locationSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion2)
        
    }
}
extension LocationSearchViewModel :     MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.result = completer.results
    }
}
