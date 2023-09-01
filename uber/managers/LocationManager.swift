//
//  locationManager.swift
//  uber
//
//  Created by moji on 5/27/1402 AP.
//


import CoreLocation

class LocationManager : NSObject , ObservableObject{
    private let locationManager =  CLLocationManager()
    override init() {
        super.init() 
        locationManager.delegate = self
        locationManager.desiredAccuracy =   kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
 
   
}
extension LocationManager : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else {return}
        //print("hi")
        locationManager.stopUpdatingLocation()
    }
}
