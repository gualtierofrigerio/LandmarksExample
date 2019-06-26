//
//  MapViewDelegate.swift
//  Landmarks
//
//  Created by Gualtiero Frigerio on 26/06/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import MapKit

class MapAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let identifier = "MapAnnotationIdentifier"
    var title: String?
    
    init(coordinate:CLLocationCoordinate2D, title:String) {
        self.coordinate = coordinate
        self.title = title
    }
}

class MapViewDelegate : NSObject, MKMapViewDelegate {
    
    var coordinator:Coordinator?
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MapAnnotation else {
            return nil // only support custom annotation class
        }
        let identifier = annotation.identifier
        var annotationView:MKPinAnnotationView?
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            annotationView = dequeuedView
        }
        else {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        annotationView?.canShowCallout = true
        let button = UIButton(type: .detailDisclosure)
        annotationView?.rightCalloutAccessoryView = button
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let title = view.annotation?.title as? String else {return}
        coordinator?.selectAnnotationWithTitle(title)
    }
}
