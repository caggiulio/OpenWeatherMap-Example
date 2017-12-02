//
//  MapViewController.swift
//  weather_test
//
//  Created by nunzio giulio caggegi on 20/11/17.
//  Copyright © 2017 nunzio giulio caggegi. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let annotations = MKPointAnnotation()
    var coordinates = [CLLocationCoordinate2D]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        mapView.delegate = self
        addAnnotation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pinAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView?.canShowCallout = true
        }
        
        annotationView?.annotation = annotation
        return annotationView
        }
    
    func addAnnotation(){
        for coord in coordinates{
            let CLLCoordType = CLLocationCoordinate2D(latitude: coord.latitude,
                                                      longitude: coord.longitude)
            let annotations = MKPointAnnotation()
            annotations.coordinate = CLLCoordType
            mapView.addAnnotation(annotations)
        }
        mapView.showAnnotations(self.mapView.annotations, animated: true)
    }

}
