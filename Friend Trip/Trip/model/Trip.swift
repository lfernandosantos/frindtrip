//
//  Trip.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 18/03/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import MapKit

class Trip: NSObject {

    let nome: String
    let local: String
    let data: String
    let tipoEvento: String
    let descriptionTrip: String
    let lat: CLLocationDegrees
    let lon: CLLocationDegrees
    let userAdm: UserFace

    init(nome: String, local: String, data: String, tipoEvento: String, descriptionTrip: String, lat: CLLocationDegrees, lon: CLLocationDegrees, userAdm: UserFace) {
        self.nome = nome
        self.local = local
        self.data = data
        self.tipoEvento = tipoEvento
        self.descriptionTrip = descriptionTrip
        self.lat = lat
        self.lon = lon
        self.userAdm = userAdm
    }

    override var description: String {
        return "\(nome), \(local), \(data), \(tipoEvento), \(lat), \(lon)"
    }
}
