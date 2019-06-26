//
//  Model.swift
//  Landmarks
//
//  Created by Gualtiero Frigerio on 19/06/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import Combine
import Foundation

class Model {
    
    var subject = PassthroughSubject<Void, Never>()
    
    private var landmarks = DataSource.defaultLandmarks
    var allLandmarks:[Landmark] {
        return landmarks
    }
    var favoritesLandmarks:[Landmark] {
        return landmarks.filter({$0.isFavorite == true})
    }
    var otherLandmarks:[Landmark] {
        return landmarks.filter({$0.isFavorite == false})
    }
    
    func getLandmark(withName name:String) -> Landmark? {
        for landmark in landmarks {
            if landmark.name == name {
                return landmark
            }
        }
        return nil
    }
    
    func toggleFavorite(id:Int) {
        if let index = getIndexOfItem(withId: id) {
            landmarks[index].isFavorite.toggle()
            subject.send()
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
