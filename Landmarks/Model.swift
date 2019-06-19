//
//  Model.swift
//  Landmarks
//
//  Created by Gualtiero Frigerio on 19/06/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

class Model : BindableObject {
    
    var didChange = PassthroughSubject<Void, Never>()
    
    private var landmarks = DataSource.defaultLandmarks
    var favoritesLandmarks:[Landmark] {
        return landmarks.filter({$0.isFavorite == true})
    }
    var otherLandmarks:[Landmark] {
        return landmarks.filter({$0.isFavorite == false})
    }
    
    func toggleFavorite(id:Int) {
        if let index = getIndexOfItem(withId: id) {
            landmarks[index].isFavorite.toggle()
            didChange.send()
        }
    }
}

extension Model {
    private func getIndexOfItem(withId id:Int) -> Int? {
        for i in 0..<landmarks.count {
            if landmarks[i].id == id {
                return i
            }
        }
        return nil
    }
}
