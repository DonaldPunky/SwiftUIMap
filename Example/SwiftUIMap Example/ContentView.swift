//
//  ContentView.swift
//  SwiftUIMap Example
//
//  Created by Morris Richman on 3/20/22.
//

import SwiftUI
import SwiftUIMap
import MapKit

struct ContentView: View {
    var body: some View {
        ExistingAnnotationMap(zoom: 0.2, address: "Seattle, Wa", points: [
            Annotations(title: "Townhall", subtitle: "Newly Remodeled", address: "1119 8th Ave, Seattle, WA, 98101, United States", glyphImage: UIImage(systemName: "building.columns")!, tintColor: .orange, markerTintColor: .orange, glyphTintColor: .white, displayPriority: .required),
            Annotations(title: "Space Needle", subtitle: "", address: "400 Broad St Seattle, WA 98109, United States", glyphImage: UIImage(), tintColor: .red, markerTintColor: .red, glyphTintColor: .white, displayPriority: .required),
            Annotations(title: "Pike Place Market", subtitle: "", address: "85 Pike St Seattle, WA  98101, United States", glyphImage: UIImage(systemName: "shopping_basket")!, tintColor: .red, markerTintColor: .red, glyphTintColor: .white, displayPriority: .required)
        ], pointsOfInterestFilter: .excludingAll) { Title, Subtitle, Address, Cluster  in
            print("tapped \(Address)")
        } deselected: {
            print("deselected annotation")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
