//
//  TripAnnotation.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 28/01/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import MapKit

class TripAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String!
    var subtitle: String!
    var img: UIImage!
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }


}
