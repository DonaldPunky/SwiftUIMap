//
//  Data Structs.swift
//  
//
//  Created by Morris Richman on 3/20/22.
//

import Foundation
import SwiftUI
import MapKit

public struct Annotations: Identifiable, Equatable {
    public let id = UUID()
    public let title: String
    public let subtitle: String
    public let address: String
    public let glyphImage: String
    public let tintColor: Color
    public let markerTintColor: Color
    public let glyphTintColor: Color
    public let displayPriority: MKFeatureDisplayPriority
    
    init(title: String, subtitle: String, address: String, glyphImage: String, tintColor: Color, markerTintColor: Color, glyphTintColor: Color, displayPriority: MKFeatureDisplayPriority) {
        self.title = title
        self.subtitle = subtitle
        self.address = address
        self.glyphImage = glyphImage
        self.tintColor = tintColor
        self.markerTintColor = markerTintColor
        self.glyphTintColor = glyphTintColor
        self.displayPriority = displayPriority
    }
    
}
