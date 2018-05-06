//
//  StarbucksAnnotation.swift
//  CustomCalloutView
//
//  Created by Malek Trabelsi on 12/17/17.
//  Copyright © 2017 Medigarage Studios LTD. All rights reserved.
//

import MapKit

class StarbucksAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var phone: String!
    var name: String!
    var address: String!
    var image: UIImage!
    var trip: Trip
    
    init(coordinate: CLLocationCoordinate2D, trip: Trip) {
        self.coordinate = coordinate
        self.trip = trip
    }
}
