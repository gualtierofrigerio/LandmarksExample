//
//  ContentView.swift
//  Landmarks
//
//  Created by Gualtiero Frigerio on 17/06/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import SwiftUI

struct LandmarkListItem : View {
    @EnvironmentObject var coordinator:Coordinator
    var landmarks:[Landmark]
    
    var body : some View {
        ForEach(landmarks.identified(by: \.id)) { landmark in
            NavigationLink(destination: self.coordinator.selectLandmarkFromList(landmark: landmark)) {
                LandmarkRow(landmark:landmark)
                }.frame(maxHeight:200)
        }
    }
}

struct ContentView : View {
    
    @EnvironmentObject var coordinator:Coordinator
    var model: Model {
        return coordinator.model
    }
    
    var body: some View {
        NavigationView {
            TabbedView {
                List {
                    if model.favoritesLandmarks.count > 0 {
                        Section(header:Text("Favorites")){
                            LandmarkListItem(landmarks:model.favoritesLandmarks)
                        }
                    }
                    if model.otherLandmarks.count > 0 {
                        Section(header:Text("Others")){
                            LandmarkListItem(landmarks:model.otherLandmarks)
                        }
                    }
                }
                    .tabItemLabel(Text("List"))
                    .tag(1)
                LandmarksMap(landmarks: model.allLandmarks)
                    .tabItemLabel(Text("Map"))
                    .tag(2)
            }.navigationBarTitle(Text("Landmarks"))
        }.onAppear() {
            print("on appear")
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Coordinator())
    }
}
#endif
