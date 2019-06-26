//
//  LandmarksMap.swift
//  Landmarks
//
//  Created by Gualtiero Frigerio on 25/06/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import CoreLocation
import SwiftUI

struct LandmarksMap : View {
    
    @EnvironmentObject var coordinator:Coordinator
    
    var landmarks:[Landmark]
    var coordinates:[CLLocationCoordinate2D] {
        return landmarks.map({$0.locationCoordinate})
    }
    
    var body: some View {
        MapView(landmarks: landmarks, delegate: coordinator.mapViewDelegate)
    }
}

#if DEBUG
struct LandmarksMap_Previews : PreviewProvider {
    static var previews: some View {
        LandmarksMap(landmarks: DataSource.defaultLandmarks)
    }
}
#endif
