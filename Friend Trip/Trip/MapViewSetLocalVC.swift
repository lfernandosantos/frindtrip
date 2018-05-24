//
//  MapViewSetLocalVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 23/05/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewSetLocalVC: UIViewController, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    var searchBarController: UISearchController? = nil
    var selectedSearchLocation: MKPlacemark? = nil

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setSearchBar()
        // Do any additional setup after loading the view.
    }



}


extension MapViewSetLocalVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        
        if let coordenadas = locations.first?.coordinate {
            dropZoomIn(coordinate: coordenadas)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
}

extension MapViewSetLocalVC: HandleMapSearch {
    
    func dropZoomIn(coordinate: CLLocationCoordinate2D) {
        let area = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let regiao:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, area)
        mapView?.setRegion(regiao, animated: true)
    }
    
    func setSearchBar() {
        
        let searchTableVC = storyboard?.instantiateViewController(withIdentifier: "SearchBarTableVC") as? SearchBarTableVC
        searchTableVC?.handleMapSearchDelegate = self
        searchTableVC?.mapView = self.mapView
        
        searchBarController = UISearchController(searchResultsController: searchTableVC)
        searchBarController?.searchResultsUpdater = searchTableVC
        
        let searchBar = searchBarController?.searchBar
        
        searchBar?.sizeToFit()
        searchBar?.placeholder = "Outro local?"
        searchBar?.tintColor = UIColor.red
        searchBar?.backgroundColor = UIColor(named: "ColorTransparent")
        
        navigationItem.titleView = searchBarController?.searchBar
        
        searchBarController?.hidesNavigationBarDuringPresentation = false
        searchBarController?.dimsBackgroundDuringPresentation = true
        
        definesPresentationContext = true
        
    }
}
