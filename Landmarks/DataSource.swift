//
//  DataSource.swift
//  Landmarks
//
//  Created by Gualtiero Frigerio on 17/06/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import SwiftUI

class DataSource {
    class var defaultLandmarks:[Landmark] {
        return loadJSON("landmarkData.json") ?? []
    }
    
    class func loadJSON<T:Decodable>(_ path:String) -> T? {
        guard let fullPath = Bundle.main.url(forResource: path, withExtension: nil) else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: fullPath) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        guard let jsonData = try? decoder.decode(T.self, from: data) else {
            return nil
        }
        
        return jsonData
    }
}

class ImageUtility {
    class var defaultImage:Image {
        return Image("defaultImage")
    }
    
    class func getImage(name:String) -> Image {
        guard let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil) else {
                return Image(systemName: "error")
        }
        return Image(image, scale: 1, label: Text(verbatim: name))
    }
}
