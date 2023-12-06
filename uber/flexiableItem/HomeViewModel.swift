//
//  HomeViewModel.swift
//  uber
//
//  Created by moji on 6/24/1402 AP.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine
import MapKit

class HomeViewModel : NSObject, ObservableObject {
    @Published var drivers = [User]()
    private let service = userServices.shared
    var currentUser : User?
    private var cancelable = Set<AnyCancellable>()
    
    @Published var result = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation : UberLocation?
    @Published var pickUpTime :String?
    @Published var dropOffTime :String?
    @Published var trips : Trips?
    private let searchCompelete = MKLocalSearchCompleter()
    var querySearch : String = ""{
        didSet{
            searchCompelete.queryFragment = querySearch
        }
    }
 
    var userLocation : CLLocationCoordinate2D?
    
    override init(){
        super.init()
        fetchUser()
        searchCompelete.delegate = self
        searchCompelete.queryFragment = querySearch
    }
    
    func getPlaceMark(forlocation location : CLLocation, completion:@escaping(CLPlacemark? ,Error?) -> Void){
        CLGeocoder().reverseGeocodeLocation(location) { placeMarket, error in
            if let error = error {
                completion(nil , error)
                return
            }
            guard let placeMarket = placeMarket?.first else {return}
            completion(placeMarket , nil)
        }
    }
    func fetchUser(){
        service.$user.sink{user in
            guard let userGuard = user else {return}
          //  self.currentUser =  user!
            self.currentUser = user!
            if user?.accountType == .passenger {
                self.fetchDriver()
            }else {
            
                self.fetchTrips()
            }
            
            
            
        }.store(in: &cancelable)
       
        
        //userServices.fetchUser { user in
        //    guard user.accountType == .passenger else { return }
       //     self.fetchDriver()
      //  }
        
    }
    
}
extension HomeViewModel {
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
extension HomeViewModel : MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.result = completer.results
    }
}
extension HomeViewModel {
    
    
    func fetchDriver(){
        Firestore.firestore().collection(AppConstant.UserCollection)
            .whereField(AppConstant.accountType,isEqualTo: AppConstant.Driver)
            .getDocuments { snappShot, _ in
                guard let document = snappShot?.documents else {return}
                let drivers  = document.compactMap( {try? $0.data(as : User.self)} )
                self.drivers  = drivers
                print("\(drivers)")
                
            }
    
    }
    func fetchTrips(){
        guard let currentUser = currentUser  , currentUser.accountType == .driver else {return}
        Firestore.firestore().collection(AppConstant.tripsCollection).whereField("driverUid",isEqualTo: currentUser.uid).getDocuments { querySnapshot, error in
           
            guard let documents  = querySnapshot?.documents ,let doc = documents.first else { return }
       
            guard let trip = try? doc.data(as : Trips.self) else { return }
            self.trips = trip
            self.getDestinationRoute(from: trip.driverLocation.toCoordinate(), to: trip.pickUpLocation.toCoordinate()) { mKRoute in
                self.trips?.travelTimeToPassenger = Int(mKRoute.expectedTravelTime/60)
                self.trips?.distanceToPassenger = mKRoute.distance
            }
                
        }
    }
}

extension HomeViewModel {
    func requestTrip(){
     
        guard let driver = drivers.first else {return}
        guard let user = currentUser else {return}
        guard let dropOffLocation  = selectedUberLocation else {return}
        let dropOffGeoLocaitonGeo = GeoPoint(latitude: dropOffLocation.coordiante.latitude, longitude: dropOffLocation.coordiante.longitude)
        let userLocation = CLLocation(latitude: currentUser!.coordiante.latitude, longitude:  currentUser!.coordiante.longitude)
        getPlaceMark(forlocation: userLocation) { CLPlacemark, error in
            guard let CLPlacemark = CLPlacemark else {return}
            let tripCost = self.computePrice(type: .uberXl)
            let trip = Trips(
                id: NSUUID().uuidString,
                passengerUid: self.currentUser!.uid,
                driverUid: driver.uid,
                passnegerName: self.currentUser!.fullName,
                driverName: driver.fullName,
                passengerLocation: self.currentUser!.coordiante,
                driverLocation: driver.coordiante,
                pickUpLocationName: CLPlacemark.name ?? "current location",
                dropoffLocationName: dropOffLocation.title,
                pickUpLocation: self.currentUser!.coordiante,
                dropOffLocation:dropOffGeoLocaitonGeo ,	
                pickUpLocationAddress: "hi2", 
                tripsCost: tripCost)
            
               guard let encodeTrip = try? Firestore.Encoder().encode(trip) else { return }
               Firestore.firestore().collection(AppConstant.tripsCollection).document().setData(encodeTrip) {error in
                print("Trips")
               }
        
        }
    }
        
}
