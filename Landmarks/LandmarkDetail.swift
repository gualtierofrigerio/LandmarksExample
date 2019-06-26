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
        NavigationView {
            VStack {
                Group {
                    Text(landmark.name)
                        .font(.largeTitle)
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
                        Button(action: {
                            self.showURLModal.toggle()
                        }) {
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
                }
                if self.showMap {
                    MapView(landmarks: [self.landmark], delegate: coordinator.mapViewDelegate)
                }
            }
        }
            .edgesIgnoringSafeArea(.top)
            .presentation(getLinkModal())
    }
    
    func getLinkModal() -> Modal? {
        if self.showURLModal {
            return Modal(WebView(urlString: self.landmark.url), onDismiss: {
                self.showURLModal = false
            })
        }
        return nil
    }
}

#if DEBUG
struct LandmarkDetail_Previews : PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: DataSource.defaultLandmarks[0])
    }
}
#endif
