//
//  TripViewModel.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 25/03/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation
import UIKit
class TripViewModel {

    let nameTrip: String
    let localTrip: String
    let dataTrip: String
    let typeTrip: String

    init(trip: Trip) {
        self.nameTrip = trip.nome
        self.localTrip = trip.local
        self.dataTrip = trip.data
        self.typeTrip = trip.tipoEvento
    }
}
