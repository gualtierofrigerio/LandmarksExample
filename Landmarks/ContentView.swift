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
            NavigationButton(destination: self.coordinator.selectLandmarkFromList(landmark: landmark)) {
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
            .navigationBarTitle(Text("Landmarks"))
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
