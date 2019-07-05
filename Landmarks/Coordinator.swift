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
    var mapViewDelegate = MapViewDelegate()
    
    init() {
        _ = model.subject.sink(receiveValue: { _ in
            self.didChange.send()
        })
        mapViewDelegate.coordinator = self
    }
    
    func selectLandmarkFromList(landmark:Landmark) -> some View {
        LandmarkDetail(landmark: landmark).environmentObject(self)
    }
    
    func openLink(urlString:String) -> some View {
        WebView(urlString: urlString)
    }
    
    func openLinkInSafari(urlString:String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    func selectAnnotationWithTitle(_ title:String) {
        guard let landmark = model.getLandmark(withName: title) else {return}
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {return}
        let landmarkDetail = LandmarkDetail(landmark: landmark)
        let hosting = UIHostingController(rootView: landmarkDetail.environmentObject(self))
        rootViewController.present(hosting, animated: true, completion: nil)
    }
}
