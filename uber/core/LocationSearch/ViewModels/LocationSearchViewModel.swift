//
//  LocationSearchViewModel.swift
//  uber
//
//  Created by moji on 6/3/1402 AP.
//

import Foundation
import MapKit
import Firebase

class LocationSearchViewModel : NSObject , ObservableObject{
    
    @Published var result = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation : UberLocation?
    @Published var pickUpTime :String?
    @Published var dropOffTime :String?
    
    var userLocation : CLLocationCoordinate2D? 
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
    func SelectionLocation(_ location :MKLocalSearchCompletion,config : locationResultViewConfig) {
        locationSearch(forlocalSearchCompletion: location) { response, error in
            if error != nil{
                print("Map ERROR IS  \(error!)")
                return
            }
            guard let  item = response?.mapItems.first else {return}
            let coordinate = item.placemark.coordinate
            switch config{
            case .ride:
                self.selectedUberLocation  = UberLocation (title: location.title , coordiante: coordinate)
            case .saveLocation(let viewModel):
                guard let userID = Auth.auth().currentUser?.uid else {return}
                let savedLocation =
                SavedLocation(title: location.title, address: location.subtitle,
                              coordinator: GeoPoint(latitude: coordinate.latitude, longitude: coordinate.longitude))
              
                guard let encodedLocation = try? Firestore.Encoder().encode(savedLocation) else { return }
             
                
                Firestore.firestore().collection(AppConstant.UserCollection).document(userID).updateData(
                    [viewModel.dataBasekey : encodedLocation])
            }
            
        }
    }
    func locationSearch(forlocalSearchCompletion locationSearch : MKLocalSearchCompletion ,completion2 :@escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery=locationSearch.title.appending(locationSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion2)
        
    }
    func computePrice(type rideType : RideType)->Double{
        guard let locationSelected = selectedUberLocation else { return 0.0}
        guard let userLocation = userLocation else { return 0.0 }
        let userLocationCurrent = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let destionatioLocation  = CLLocation(latitude: locationSelected.coordiante.latitude, longitude: locationSelected.coordiante.longitude)
        let tripDistance = userLocationCurrent.distance(from: destionatioLocation)
        return rideType.computePrice(for:tripDistance)
    }
    func getDestinationRoute(from userLocation:CLLocationCoordinate2D , to  destination
                            : CLLocationCoordinate2D ,completion : @escaping (MKRoute)->Void){
        let userPlaceMark = MKPlacemark(coordinate: userLocation)
        let DestinationPlaceMark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark:  userPlaceMark )
        request.destination = MKMapItem(placemark: DestinationPlaceMark)
        let directions = MKDirections(request: request)
        directions.calculate { response , error in
            if error != nil {
                print("Map ERROR IS  \(error!)")
                return
            }
            guard let route = response?.routes.first else {return}
            self.configurationPickUpAndDropOffTimes(with: route.expectedTravelTime)
            completion(route)
        }
        
        
    }
    func  configurationPickUpAndDropOffTimes(with ExpectedTravelTime : Double){
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        pickUpTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + ExpectedTravelTime)
    }
}
extension LocationSearchViewModel :     MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.result = completer.results
    }
}
