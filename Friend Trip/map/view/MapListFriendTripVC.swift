//
//  MapListFriendTripVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 27/01/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapListFriendTripVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var addTrip: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var filterBtn: UIButton!
    let locationManager = CLLocationManager()

    var searchBarController: UISearchController? = nil
    var selectedSearchLocation: MKPlacemark? = nil
    var selectedTrip: Trip!
    var selectedCategory: String?

    var tripsList = [Trip]()

    override func viewWillAppear(_ animated: Bool) {
        if let category = selectedCategory {
            fetchPinsWithFilter()
        }
    }

    @IBAction func closeView(_ sender: Any) {
        print("Close")
        self.dismiss(animated: true, completion: nil)
    }

    func setupViews() {

        setCircularButton(addTrip)
        setCircularButton(filterBtn)

    }

    func setCircularButton(_ button: UIButton) {
        button.layer.cornerRadius = button.frame.width/2
        button.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        button.layer.masksToBounds = false
        button.layer.shadowOpacity = 0.6
        button.layer.shadowColor = UIColor.black.cgColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()

        setSearchBar()

        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem

        self.mapView.delegate = self

        fetchData()

    }

    func fetchData() {

        let jsonUser: [String : Any] = ["picture":
            [ "data":
                [ "height": 200,
                  "is_silhouette": 0,
                  "url": "https://lookaside.facebook.com/platform/profilepic/?asid=1571861286232650&height=200&width=200&ext=1523583752&hash=AeQydwWTSzPh8O8K",
                  "width": 200 ]

            ],
                                        "name": "Fernando Santos", "email": "fernandin222@hotmail.com", "id": 1571861286232650]



        tripsList.append(Trip(nome: "Baladinha tipo são Jorge", local: "1140", data: "66 - jamais - 6666", tipoEvento: "Morrer", descriptionTrip: "eerarareresedes", lat: -22.767654, lon: -43.426178, userAdm: UserFace(JSON: jsonUser)!))
        tripsList.append( Trip(nome: "Carol ta LOCONA VIADO", local: "UP Trun, Barra da Tijuca", data: "23 - Abril - 2018", tipoEvento: "Night", descriptionTrip: "eerarareresedes",lat: -22.767654, lon: -43.426000, userAdm: UserFace(JSON: jsonUser)!))
        tripsList.append(Trip(nome: "Niver do Fernando", local: "Arraial", data: "28 - Maio - 2018", tipoEvento: "Beach", descriptionTrip: "eerarareresedes",lat: -22.764696, lon: -43.424816, userAdm: UserFace(JSON: jsonUser)!))
        tripsList.append(Trip(nome: "Caminhada no bosque", local: "Matinho da esquina, Floresta da Tijuca", data: "11 - Setembro - 2019", tipoEvento: "Matagal", descriptionTrip: "eerarareresedes", lat: -22.767000, lon: -42.426178, userAdm: UserFace(JSON: jsonUser)!))
        tripsList.append(Trip(nome: "Viagem5", local: "Local", data: "Data", tipoEvento: "Beer", descriptionTrip: "eerarareresedes",lat: -22.767644, lon: -43.423743, userAdm: UserFace(JSON: jsonUser)!))
        tripsList.append(Trip(nome: "Viagem6", local: "Local", data: "Data", tipoEvento: "Beer", descriptionTrip: "eerarareresedes",lat: -22.766546, lon: -43.426178, userAdm: UserFace(JSON: jsonUser)!))

        loadTripsOnMap(tripsList)
    }

    func loadTripsOnMap(_ trips: [Trip]) {

        mapView.removeAnnotations(mapView.annotations)

        for trip in trips{

            let coordinate = CLLocation(latitude: trip.lat, longitude: trip.lon)
            let point = StarbucksAnnotation(coordinate: coordinate.coordinate, trip: trip)
            point.image = UIImage(named: trip.tipoEvento)
            point.name = trip.nome
            point.address = trip.local
            point.phone = trip.data

            self.mapView.addAnnotation(point)
        }
    }
}

typealias MapViewDelegate = MapListFriendTripVC
extension MapViewDelegate
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }else{
            annotationView?.annotation = annotation
        }
        let icon = UIImage(named: "pin")

        annotationView?.image = icon

        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){

        if let starbucksAnnotation = view.annotation as? StarbucksAnnotation {
            let views = Bundle.main.loadNibNamed("CustomCallOutView", owner: nil, options: nil)
            let calloutView = views?[0] as! CustomCallOutClass

            calloutView.title.text = starbucksAnnotation.name
            calloutView.subTitle.text = starbucksAnnotation.address
            calloutView.tipeTrip.text = starbucksAnnotation.trip.tipoEvento
            calloutView.data.text = starbucksAnnotation.trip.data
            calloutView.img.image = starbucksAnnotation.image
            calloutView.img.contentMode = .scaleAspectFit

            let gestureSwift2AndHigher = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
            calloutView.addGestureRecognizer(gestureSwift2AndHigher)

            selectedTrip = starbucksAnnotation.trip

            calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
            view.addSubview(calloutView)
            mapView.setCenter((view.annotation?.coordinate)!, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }

    @objc func someAction(_ sender:UITapGestureRecognizer){
        performSegue(withIdentifier: "clickcallout", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailTripVC {
            detailVC.tripViewModel = TripViewModel(trip: selectedTrip)

        }
        if let filterVC = segue.destination as? FilterHomeVC {
            filterVC.mapDelegate = self
        }

        if let newTripVC = segue.destination as? NewTripVC {
            newTripVC.mapDelegate = self
        }
    }
}
extension MapListFriendTripVC: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        mapView.showsUserLocation = true

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

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {

        //fazer requisição mandando nova localização
        print(mapView.centerCoordinate)
    }
}

extension MapListFriendTripVC: HandleMapSearch {

    func dropZoomIn(coordinate: CLLocationCoordinate2D) {
        let area = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let regiao:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, area)
        mapView?.setRegion(regiao, animated: true)
    }

    func setMKPlacemark(mkPlacemark: MKPlacemark) {
        
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

extension MapListFriendTripVC: MapProtocol {
    func setCategory(category: String) {
        selectedCategory = category
    }

    func fetchPinsWithFilter() {
        print("----")
        print(selectedCategory)
    }

    func addNewTrip(_ trip: Trip) {
        tripsList.append(trip)
        loadTripsOnMap(tripsList)
    }
}
