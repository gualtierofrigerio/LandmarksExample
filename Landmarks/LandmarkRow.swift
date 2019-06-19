//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by Gualtiero Frigerio on 17/06/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import SwiftUI

/*
struct ResizableImage : ViewModifier {
    func body(content: Content) -> some View {
        content
            .resizable()
            .frame(maxWidth:200, maxHeight:200)
    }
}
*/

struct LandmarkRow : View {
    
    var landmark:Landmark
    
    var body: some View {
        HStack {
            ImageUtility.getImage(name: landmark.imageName)
                .resizable()
                .frame(maxWidth:200, maxHeight:200)
            
            Text(landmark.name)
            Spacer()
            Group {
                if landmark.isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
                else {
                    Image(systemName: "star")
                }
            }
        }
    }
}

#if DEBUG
struct LandmarkRow_Previews : PreviewProvider {
    static var previews: some View {
        LandmarkRow(landmark: DataSource.defaultLandmarks[0])
    }
}
#endif
