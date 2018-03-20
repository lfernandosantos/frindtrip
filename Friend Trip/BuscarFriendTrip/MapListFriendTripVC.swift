//
//  MapListFriendTripVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 27/01/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import MapKit

class MapListFriendTripVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var addTrip: UIButton!
    @IBOutlet weak var mapView: MKMapView!



    @IBAction func closeView(_ sender: Any) {
        print("Close")
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        self.mapView.delegate = self

        addTrip.layer.cornerRadius = addTrip.frame.width/2

        addTrip.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        addTrip.layer.masksToBounds = false
        addTrip.layer.shadowOpacity = 0.6
        addTrip.layer.shadowColor = UIColor.black.cgColor

        let trips: [CLLocation] = [CLLocation.init(latitude: -22.767654, longitude: -43.426178),
                                   CLLocation.init(latitude: -22.767654, longitude: -43.426000),
                                   CLLocation.init(latitude: -22.764696, longitude: -43.424816),
                                   CLLocation.init(latitude: -22.767000, longitude: -42.426178),
                                   CLLocation.init(latitude: -22.766942, longitude: -43.423743),
                                   CLLocation.init(latitude: -22.767644, longitude: -43.426178),
                                   CLLocation.init(latitude: -22.766546, longitude: -43.427187)
        ]

        for trip in trips{

            let point = StarbucksAnnotation(coordinate: trip.coordinate)
            point.image = UIImage(named: "icon_type")
            point.name = "Programar Até Morrer"
            point.address = "Casa do Fernando - 27/01/2018 20:30"
            point.phone = "Mesquita"

            self.mapView.addAnnotation(point)

        }
        let initialLocation = CLLocation(latitude: -22.767654, longitude: -43.426178)

        centralizar(coordenadas: initialLocation.coordinate)

        mapView.bringSubview(toFront: addTrip)



    }


    func getRoundShadowButton(button: UIButton) -> CALayer {
        let layer = CALayer()
        layer.cornerRadius = button.frame.width/2
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.masksToBounds = false
        layer.shadowOpacity = 0.6
        layer.shadowColor = UIColor.black.cgColor
        return layer
    }

    func setGradientStatusBar(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = statusView.bounds

        let colorTop = UIColor(red: 255.0/255.0, green: 136.0/255.0, blue: 0/255.0, alpha: 1.0 )
        let colorBottom = UIColor(red: 147.0/255.0, green: 54.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        gradientLayer.colors =  [colorTop, colorBottom].map{$0.cgColor}
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        statusView.layer.addSublayer(gradientLayer)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    override func viewDidLayoutSubviews() {
        setGradientStatusBar()
        statusView.bringSubview(toFront:mapView )

        mapView.layer.masksToBounds = true
        mapView.layer.cornerRadius = 5
    }
    func centralizar(coordenadas: CLLocationCoordinate2D){

        let area = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let regiao:MKCoordinateRegion = MKCoordinateRegionMake(coordenadas, area)
        mapView?.setRegion(regiao, animated: true)
        print("Localização \(coordenadas)")
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

        // or for swift 2 +

        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){

        let starbucksAnnotation = view.annotation as! StarbucksAnnotation
        let views = Bundle.main.loadNibNamed("CustomCalloutV", owner: nil, options: nil)
        let calloutView = views?[0] as! CustomCalloutView
        calloutView.starbucksName.text = starbucksAnnotation.name
        calloutView.starbucksAddress.text = starbucksAnnotation.address
        calloutView.starbucksPhone.text = starbucksAnnotation.phone
        calloutView.starbucksImage.image = starbucksAnnotation.image

        let gestureSwift2AndHigher = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        calloutView.addGestureRecognizer(gestureSwift2AndHigher)


        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)


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
}
