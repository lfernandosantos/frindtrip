//
//  MapViewSetLocalVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 23/05/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import MapKit

class MapViewSetLocalVC: UIViewController, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    var searchBarController: UISearchController? = nil
    var selectedSearchLocation: MKPlacemark? = nil
    var locationDelegate: TripProtocol?
    var textSearchbar: String?

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setSearchBar()
        self.mapView.delegate = self
        
        configLocationManager()

        navigationController?.navigationItem.backBarButtonItem?.title = " "
    }

    @IBAction func chosePlace(_ sender: Any) {
        if let mkPlacemark = selectedSearchLocation {
            locationDelegate?.setLocation(mkPlacemark: mkPlacemark)
        }
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }

}

extension MapViewSetLocalVC: CLLocationManagerDelegate {
    
    func configLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }
    
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

    func setMKPlacemark(mkPlacemark: MKPlacemark) {
        self.selectedSearchLocation = mkPlacemark
        let annotation = MKPointAnnotation()
        annotation.coordinate = mkPlacemark.coordinate

        if let name = mkPlacemark.name {
            searchBarController?.searchBar.text = "\(name), \(parseAddress(selectedItem: mkPlacemark))"
        } else {
            searchBarController?.searchBar.text = parseAddress(selectedItem: mkPlacemark)
        }

        mapView.addAnnotation(annotation)
    }
    
    func setSearchBar() {
        
        let searchTableVC = storyboard?.instantiateViewController(withIdentifier: "SearchBarTableVC") as? SearchBarTableVC
        searchTableVC?.handleMapSearchDelegate = self
        searchTableVC?.mapView = self.mapView
        
        searchBarController = UISearchController(searchResultsController: searchTableVC)
        searchBarController?.searchResultsUpdater = searchTableVC
        
        let searchBar = searchBarController?.searchBar
        
        searchBar?.sizeToFit()
        searchBar?.placeholder = "Digite local"
        searchBar?.tintColor = UIColor.red
        searchBar!.isUserInteractionEnabled = true

        if textSearchbar != "" {
            searchBar?.text = textSearchbar
        }
        //searchBar?.backgroundColor = UIColor(named: "ColorTransparent")

        navigationItem.searchController = searchBarController

        searchBarController!.searchBar.isUserInteractionEnabled = true
        searchBarController?.hidesNavigationBarDuringPresentation = false
        searchBarController?.dimsBackgroundDuringPresentation = true
        
        definesPresentationContext = true
    }

    func parseAddress(selectedItem: MKPlacemark) -> String {
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil ) ? " " : " "
        let coma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil ) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? "," : " "

        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " ": " "
        let addressLine = String(format: "%@%@%@%@%@%@%@", selectedItem.subThoroughfare ?? "", firstSpace, selectedItem.thoroughfare ?? "",
                                 coma, selectedItem.locality ?? "", secondSpace, selectedItem.administrativeArea ?? "")
        return addressLine
    }
}


