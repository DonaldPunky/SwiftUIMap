import Foundation
import MapKit
import SwiftUI
import CoreLocation
#if os(iOS) || os(tvOS) || os(watchOS)// || os(macOS)

struct rawExistingAnnotationMap: UIViewRepresentable {
    var zoom: Double
    var address: String
    var points: [Annotations]
    var modifierMap: MKMapView
    var selected: (_ Title: String, _ Subtitle: String, _ Address: String, _ Cluster: Bool) -> Void
    var deselected: () -> Void
    
//    var annotationSelected: MKAnnotationView
    func updateUIView(_ mapView: MKMapView, context: Context) {
            let span = MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom)
            var chicagoCoordinate = CLLocationCoordinate2D()
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(address) { (placemarks, error) in
                guard
                    let placemarks = placemarks,
                    let location = placemarks.first?.location
                else {
                    // handle no location found
                    return
                }

                // Use your location
                chicagoCoordinate.latitude = location.coordinate.latitude
                chicagoCoordinate.longitude = location.coordinate.longitude
                let region = MKCoordinateRegion(center: chicagoCoordinate, span: span)
                mapView.setRegion(region, animated: true)
            }
        }
    
        func makeUIView(context: Context) -> MKMapView {

            let myMap = modifierMap
            for point in points {

                let geoCoder = CLGeocoder()
                geoCoder.geocodeAddressString(point.address) { (placemarks, error) in
                    guard
                        let placemarks = placemarks,
                        let location = placemarks.first?.location
                    else {
                        // handle no location found
                        return
                    }

                    // Use your location
                    let annotation = MKPointAnnotation()
                    annotation.coordinate.latitude = location.coordinate.latitude
                    annotation.coordinate.longitude = location.coordinate.longitude
                    annotation.title = point.title
                    annotation.subtitle = point.subtitle
                    myMap.addAnnotation(annotation)
                }
            }
            if myMap.delegate == nil {
                myMap.delegate = context.coordinator
            }
            return myMap
        }

    func makeCoordinator() -> rawExistingAnnotationMapCoordinator {
        return rawExistingAnnotationMapCoordinator(self, points: points) { title, subtitle, address, cluster  in
//            print("tapped passed back, annotation = \(annotation)")
            selected(title, subtitle, address, cluster)
        } deselected: {
            deselected()
        }
    }

    class rawExistingAnnotationMapCoordinator: NSObject, MKMapViewDelegate {
        var entireMapViewController: rawExistingAnnotationMap
        var points: [Annotations]
        var selected: (_ Title: String, _ Subtitle: String, _ Address: String, _ Cluster: Bool) -> Void
        var deselected: () -> Void
        init(_ control: rawExistingAnnotationMap, points: [Annotations], selected: @escaping (_ Title: String, _ Subtitle: String, _ Address: String, _ Cluster: Bool) -> Void, deselected: @escaping () -> Void) {
            self.entireMapViewController = control
            self.points = points
            self.selected = selected
            self.deselected = deselected
        }
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: String(describing: annotation.title))
            if points != [] {
                let annotationDetails = points.first { annotate in
                    annotate.title == annotationView.annotation?.title
                }
                if annotationDetails!.glyphImage != UIImage() {
                    annotationView.glyphImage = annotationDetails!.glyphImage
                }
                annotationView.glyphTintColor = annotationDetails!.glyphTintColor
                annotationView.markerTintColor = annotationDetails!.markerTintColor
//                annotationView.tintColor = annotationDetails!.tintColor
                annotationView.displayPriority = annotationDetails!.displayPriority
                annotationView.clusteringIdentifier = "test"
                let removeElement = points.firstIndex(of: annotationDetails!)
                points.remove(at: removeElement!)
            }
            return annotationView
        }
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            let coordinates = view.annotation!.coordinate
            let annotationCluster = view.annotation as? MKClusterAnnotation
            if mapView.selectedAnnotations.count > 0 {
                //                mapView.deselectAnnotation(view as? MKAnnotation, animated: true)
            }
            //            if points != [] {
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)) { placemarks, error in
                if error == nil {
                    let title: String = (view.annotation?.title!!)!
                    let subtitle: String = (view.annotation?.subtitle!!)!
                    let placemark = placemarks!.first
                    let location = String(describing: placemark!.location)
                    if let cluster = annotationCluster {
                        //*** Need array list of annotation inside cluster here ***
                        let arrayList = cluster.memberAnnotations
                        print("cluster list = \(arrayList)")
                        // If you want the map to display the cluster members
                        if arrayList.count > 1 {
                            self.entireMapViewController.selected(title, subtitle, location, true)
                        }else {
                            self.entireMapViewController.selected(title, subtitle, location, false)
                        }
                    }else {
                        self.entireMapViewController.selected(title, subtitle, location, false)
                    }
                    //            }else {
                    //                print("no annotation")
                    //            }
                }else {
                    print("error, \(String(describing: error))")
                }
            }
        }
        func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
            deselected()
        }
    }
}

//struct existingAnnotationMapProxy: View {
//    var body: some View {
//        
//    }
//}
#endif
