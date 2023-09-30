//
//  MapViewController.swift
//  ListaCidade
//
//  Created by Cátia Souza on 24/09/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var maps: MKMapView!
    lazy var location = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        maps.showsUserLocation = true
        maps.userTrackingMode = .follow
        maps.delegate = self
        requestAuthorization()
    }
    
    func requestAuthorization() {
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.requestWhenInUseAuthorization()
    }

}
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 7.0
        renderer.strokeColor = .blue
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: view.annotation!.coordinate))
        
        let direcao = MKDirections(request: request)
        direcao.calculate { response, error in
            if error == nil {
                guard let response = response,
                      let route = response.routes.first
                else {return}
                
                for step in route.steps {
                    print("Em", step.distance, "metros", step.instructions)
                }
                self.maps.removeOverlays(self.maps.overlays)
                self.maps.addOverlay(route.polyline, level: .aboveRoads)
            }
            
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBar.text
        request.region = maps.region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if error == nil {
                guard let response = response else {return}
                self.maps.removeAnnotation(self.maps.annotations as! MKAnnotation)
                for item in response.mapItems {
                    let anotation = MKPointAnnotation()
                    anotation.coordinate = item.placemark.coordinate
                    anotation.title = item.name
                    anotation.subtitle = item.url?.absoluteString
                    self.maps.addAnnotation(anotation)
                }
                self.maps.showAnnotations(self.maps.annotations, animated: true)
            }
        }
    }
    
}
extension MapViewController: UISearchBarDelegate {
    
}
