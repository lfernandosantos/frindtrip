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
    var selectedCategory: String? = nil

    var tripsList = [Trip]()

    override func viewWillAppear(_ animated: Bool) {
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()

        if let category = selectedCategory, !category.isEmpty, category != " " {
            fetchPinsWithFilter(category)
        } else {
            loadTripsOnMap(tripsList)
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
                                        "name": "Fernando Santos", "email": "fernandin222@hotmail.com", "id": "1571861286232650"]

        let jsonUse2: [String : Any] = ["picture":
            [ "data":
                [ "height": 200,
                  "is_silhouette": 0,
                  "url": "https://lookaside.facebook.com/platform/profilepic/?asid=1571861286232650&height=200&width=200&ext=1523583752&hash=AeQydwWTSzPh8O8K",
                  "width": 200 ]

            ],
                                        "name": "Fernando Santos 2", "email": "fernandin222@hotmail.com", "id": "1571861286232690"]

        tripsList.append(Trip(id: 1, nome: "Baladinha", local: "Barra Music", data: "10-06-2018 22:17", tipoEvento: GlobalConstants.Categories.PARTY, descriptionTrip: "eerarareresedes", lat: -22.767654, lon: -43.426178, userAdm: UserFace(JSON: jsonUser)!, status: "", numParticipantes: 5))
        tripsList.append( Trip(id: 2, nome: "HappyHour", local: "Bar da Devassa", data: "29-07-2018 19:00", tipoEvento: GlobalConstants.Categories.BEER, descriptionTrip: "Happyhour geek. \nVoltado para galera de geek, ques gosta de jogos, tecnologia e bebeerrrr.",lat:-22.902425, lon: -43.177246, userAdm: UserFace(JSON: jsonUser)!,status: "", numParticipantes: 14))
        tripsList.append(Trip(id: 3, nome: "Trilha Floresta da Tijuca", local: "Parque Nacional da Tijuca", data: "10-09-2018 07:10", tipoEvento: GlobalConstants.Categories.ADVENTURE, descriptionTrip: "Pra quem curte uma vibe mais aventureira. \nEstamos com um guia e planejamos fazer as trilhas: Pico da Tijuca e Cachoeira das Almas.\nVenha preparado para tirar muitas fotos porque a galera é #bemBlogueira haha.",lat: -22.949411, lon: -43.287397, userAdm: UserFace(JSON: jsonUser)!,status: "confirmed", numParticipantes: 10))
        tripsList.append(Trip(id: 4, nome: "Volei em Copa", local: "Posto 5, Copacabana", data: "10-06-2018 20:15", tipoEvento: GlobalConstants.Categories.CLUB, descriptionTrip: "Vai rolar um volei na praia de copa, todos estão convidados.\nTemos rede e bola!!", lat: -22.977596, lon: -43.188895, userAdm: UserFace(JSON: jsonUser)!,status: "", numParticipantes: 23))
        tripsList.append(Trip(id: 5, nome: "Passeio no Louvre", local: "Museu do Louvre, Paris", data: "05-07-2018 09:30", tipoEvento: GlobalConstants.Categories.CULT, descriptionTrip: "Estou viajando sozinho por paris e gostaria de cia para me acompanhar durante o passeio. Alguém que goste de arte e de conversar sobre. E uma ajuda para tirar fotos também sempre é bem vinda.",lat: 48.86065, lon: 2.337569, userAdm: UserFace(JSON: jsonUse2)!,status: "", numParticipantes: 22))
        tripsList.append(Trip(id: 6, nome: "Viagem", local: "Arraial", data: "10-06-2018 22:17", tipoEvento: GlobalConstants.Categories.BEER, descriptionTrip: "eerarareresedes",lat: -22.766546, lon: -43.426178, userAdm: UserFace(JSON: jsonUse2)!,status: "", numParticipantes: 1))

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
            calloutView.img.image = UIImageCategory.getIconCategory(starbucksAnnotation.trip.tipoEvento)
            calloutView.img.contentMode = .scaleAspectFit
            calloutView.layer.cornerRadius = 8

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

    func fetchPinsWithFilter(_ category: String) {
        var tripWithCategory = [Trip]()
        for t in tripsList {
            if t.tipoEvento == category {
                tripWithCategory.append(t)
            }
        }
        loadTripsOnMap(tripWithCategory)
    }

    func addNewTrip(_ trip: Trip) {
        tripsList.append(trip)
        loadTripsOnMap(tripsList)
    }
}
