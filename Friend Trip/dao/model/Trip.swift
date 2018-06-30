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

    let id: Int
    let nome: String
    let local: String
    let data: String
    let tipoEvento: String
    let descriptionTrip: String
    let lat: CLLocationDegrees
    let lon: CLLocationDegrees
    let userAdm: UserFace
    let status: String
    let numParticipantes: Int

    let jsonUser: [String : Any] = ["picture":
        [ "data":
            [ "height": 200,
              "is_silhouette": 0,
              "url": "https://lookaside.facebook.com/platform/profilepic/?asid=1571861286232650&height=200&width=200&ext=1523583752&hash=AeQydwWTSzPh8O8K",
              "width": 200 ]

        ],
                                    "name": "Fernando Santos", "email": "fernandin222@hotmail.com", "id": "1571861286232650"]


    init(id: Int, nome: String, local: String, data: String, tipoEvento: String, descriptionTrip: String, lat: CLLocationDegrees, lon: CLLocationDegrees, userAdm: UserFace, status: String, numParticipantes: Int) {
        self.id = id
        self.nome = nome
        self.local = local
        self.data = data
        self.tipoEvento = tipoEvento
        self.descriptionTrip = descriptionTrip
        self.lat = lat
        self.lon = lon
        self.userAdm = userAdm
        self.status = status
        self.numParticipantes = numParticipantes
    }

    init(tripDao: TripsDAO) {
        self.id = Int(tripDao.id)
        self.nome = tripDao.nome ?? ""
        self.local = tripDao.local ?? ""
        self.data = tripDao.data ?? ""
        self.tipoEvento = tripDao.tipoEvento ?? ""
        self.descriptionTrip = tripDao.descriptionTrip ?? ""
        self.lat = -33333
        self.lon = -44444
        self.userAdm = UserFace(JSON: jsonUser)!
        self.status = tripDao.status ?? ""
        self.numParticipantes = Int(tripDao.participantes)
    }

    override var description: String {
        return descriptionTrip
    }
}
