//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by Gualtiero Frigerio on 17/06/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import SwiftUI

struct LandmarkDetail : View {
    
    var landmark:Landmark
    @State private var showMap = false
    @State private var showURLModal = false
    @EnvironmentObject var coordinator:Coordinator
    var model:Model {
        return coordinator.model
    }
    
    var body: some View {
        VStack {
            Text(landmark.name)
                .font(.title)
            Text(landmark.park)
                .font(.caption)
            ImageUtility.getImage(name: landmark.imageName)
            if self.coordinator.openLinksInSafari {
                Button(action: {
                    self.coordinator.openLinkInSafari(urlString:self.landmark.url)
                }) {
                    Text("Show on wikipedia")
                }
            }
            else {
                PresentationButton(destination: self.coordinator.openLink(urlString: landmark.url)) {
                    Text("Show on wikipedia")
                }
            }
            Button(action: {
                self.model.toggleFavorite(id: self.landmark.id)
            }) {
                Text("toggle favorite")
            }.padding()
            Toggle(isOn:$showMap) {
                Text("Show map")
            }
            if self.showMap {
                MapView(coordinate: landmark.locationCoordinate)
            }
            Spacer()
        }
    }
}

#if DEBUG
struct LandmarkDetail_Previews : PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: DataSource.defaultLandmarks[0])
    }
}
#endif
