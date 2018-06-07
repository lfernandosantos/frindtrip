//
//  LocationModel.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 31/05/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import MapKit
class LocationModel: NSObject {

    var nome: String?
    var rua: String?
    var numero: String?
    var bairro: String?
    var cidade: String?
    var estado: String?

    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees

    init(nome: String?, rua: String?, n: String?, bairro: String?, cidade: String?, estado: String?, lat: CLLocationDegrees, lon: CLLocationDegrees) {
        self.nome = nome
        self.rua = rua
        self.numero = n
        self.bairro = bairro
        self.cidade = cidade
        self.estado = estado
        self.latitude = lat
        self.longitude = lon
    }

}
