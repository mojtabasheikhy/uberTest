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
    let locationManager = LocationManager.shared
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    @Binding var mapState : MapViewState
    func makeUIView(context: Context) -> some UIView {
        map.delegate = context.coordinator
        map.isRotateEnabled = false
        map.showsUserLocation = true
        map.userTrackingMode = .follow
        return map
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        switch mapState{
        case MapViewState.noInput:
            context.coordinator.clearMapView()
            break
        case MapViewState.locationSelected:
            if  let selectedLocation = locationViewModel.selectedUberLocation{
                context.coordinator.addAndSelectAnnotaion(withCoordinate: selectedLocation.coordiante)
                context.coordinator.configurationPolyLine(withDestinationCoordinate: selectedLocation.coordiante)
            }
            break
        case MapViewState.searchingForLocation:
            break
        
       case MapViewState.PolyLineAdded:
        break
        }
        
        if mapState == MapViewState.noInput {
        
        }
    }
    func makeCoordinator() -> mapCoordinator {
        return mapCoordinator(parent: self)
    }
}
extension UberMapViewRepresantable {
    class mapCoordinator : NSObject , MKMapViewDelegate{
        let parent : UberMapViewRepresantable
        var userLocation : CLLocationCoordinate2D?
        var currentRegion :MKCoordinateRegion?
        
        init(parent  : UberMapViewRepresantable) {
            self.parent = parent
            super.init()
        }
      
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocation = userLocation.coordinate
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            self.currentRegion = region
            mapView.setRegion(region, animated: true)
        }
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 5
            return polyline
        }
        func addAndSelectAnnotaion(withCoordinate coordinate:CLLocationCoordinate2D){
            parent.map.removeAnnotations(parent.map.annotations)
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.map.addAnnotation(anno)
            parent.map.selectAnnotation(anno, animated: true)
            parent.map.showAnnotations(parent.map.annotations, animated: true)
        }
    

        func configurationPolyLine(withDestinationCoordinate coordinate :CLLocationCoordinate2D){
            guard let userLocation = self.userLocation else {return}
            parent.locationViewModel.getDestinationRoute(from: userLocation
                                , to: coordinate) { route in
                self.parent.map.addOverlay(route.polyline)
                self.parent.mapState = .PolyLineAdded
                let rect = self.parent.map.mapRectThatFits(route.polyline.boundingMapRect,edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                self.parent.map.setRegion(MKCoordinateRegion(rect), animated: true)
            }
           
        }
        
       
        
        func clearMapView(){
            parent.map.removeOverlays(parent.map.overlays)
            parent.map.removeAnnotations(parent.map.annotations)
            if currentRegion != nil {
                parent.map.setRegion(currentRegion!, animated: true)
            }
        }
    }
}
