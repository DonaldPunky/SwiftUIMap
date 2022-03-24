# SwiftUIMap

<img src="https://github.com/Mcrich23/SwiftUIMap/blob/92f1b2a4040ccdd7eead54acdbaaada4da0b697d/README%20Images/Map.png" width="100" height="100">

SwiftUIMap is the best UIKit wrapper for MapKit!

Currently, we only support set annotations, but are working on a mutatable map.

## Installation
### **Swift Package Manager**

The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the swift compiler. It is in early development, but SwiftUIMap does support its use on supported platforms.

Once you have your Swift package set up, adding SwiftUIMap as a dependency is as easy as adding it to the dependencies value of your Package.swift.

```
dependencies: [
    .package(url: "https://github.com/Mcrich23/SwiftUIMap.git", .upToNextMajor(from: "1.0.0"))
]
```

## Usage

Note: To use SwiftUIMap, you need to import MapKit

### **ExistingAnnotationMap**

```
ExistingAnnotationMap(zoom: 0.4, address: "Seattle, Wa", points: [Annotations(title: "Townhall", subtitle: "Newly Remodeled", address: "1119 8th Ave, Seattle, WA, 98101, United States", glyphImage: "", tintColor: .red, markerTintColor: .red, glyphTintColor: .white, displayPriority: .required)], pointsOfInterestFilter: .excludingAll) { Title, Subtitle, Address, Cluster  in
        print("tapped \(Address)")
    } deselected: {
        print("deselected annotation")
}
```
