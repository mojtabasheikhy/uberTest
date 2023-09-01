//
//  uberMapViewRepsable.swift
//  uber
//
//  Created by moji on 5/27/1402 AP.
//

import Foundation
import SwiftUI
import MapKit


struct UberMapViewRepresantable : UIViewRepresentable {
    
    
    
    let map  = MKMapView()
    let locationManager = LocationManager()
    @EnvironmentObject var LocationViewModel : LocationSearchViewModel
    func makeUIView(context: Context) -> some UIView {
        map.delegate = context.coordinator
        map.isRotateEnabled = false
        map.showsUserLocation = true
        map.userTrackingMode = .follow
        return map
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if  let selectedLocation = LocationViewModel.selectionLocation{
            print("Hi \(selectedLocation)")
        }
    }
    func makeCoordinator() -> mapCoordinator {
        return mapCoordinator(parent: self)
    }
}
extension UberMapViewRepresantable {
    class mapCoordinator : NSObject , MKMapViewDelegate{
        let parent : UberMapViewRepresantable
        init(parent  : UberMapViewRepresantable) {
            self.parent = parent
            super.init()
        }
      
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            mapView.setRegion(region, animated: true)
        }
    }
}
