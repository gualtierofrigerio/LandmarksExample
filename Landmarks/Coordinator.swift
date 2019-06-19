//
//  Coordinator.swift
//  Landmarks
//
//  Created by Gualtiero Frigerio on 19/06/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

class Coordinator : BindableObject {
    var didChange = PassthroughSubject<Void, Never>()
    var model = Model()
    var openLinksInSafari = false
    
    init() {
        _ = model.subject.sink(receiveValue: { _ in
            self.didChange.send()
        })
    }
    
    func selectLandmarkFromList(landmark:Landmark) -> some View {
        LandmarkDetail(landmark: landmark)
    }
    
    func openLink(urlString:String) -> some View {
        WebView(urlString: urlString)
    }
    
    func openLinkInSafari(urlString:String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}
