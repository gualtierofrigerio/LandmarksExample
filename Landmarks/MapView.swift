//
//  MapView.swift
//  Landmarks
//
//  Created by Gualtiero Frigerio on 17/06/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import CoreLocation
import MapKit
import SwiftUI

struct MapView : UIViewRepresentable {
    
    var landmarks:[Landmark]
    var annotations:[MapAnnotation] {
        landmarks.map {MapAnnotation(coordinate:$0.locationCoordinate, title:$0.name)}
    }
    var delegate:MapViewDelegate
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = delegate
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
        if landmarks.count == 1 {
            let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
            let region = MKCoordinateRegion(center: landmarks[0].locationCoordinate, span: span)
            view.setRegion(region, animated: true)
            view.addAnnotation(annotations[0])
        }
        else {
            view.showAnnotations(annotations, animated: true)
        }
    }
}

#if DEBUG
struct MapView_Previews : PreviewProvider {
    static var previews: some View {
        MapView(landmarks: DataSource.defaultLandmarks, delegate: MapViewDelegate())
    }
}
#endif
