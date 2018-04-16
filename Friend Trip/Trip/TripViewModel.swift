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
    let descriptionTrip: String
    let admName: String
    let picAdm: String

    init(trip: Trip) {
        self.nameTrip = trip.nome
        self.localTrip = trip.local
        self.dataTrip = trip.data
        self.typeTrip = trip.tipoEvento

        self.admName = trip.userAdm.name ?? "Name"
        self.picAdm = trip.userAdm.picture?.data?.url ?? "placehoder"
        
        self.descriptionTrip = "hiuhobui wekmrgoier mgioperm rpgoeri wmpogemr opbmwro bmoirenwbp iorw pwwrporow  oirwmboip neon wokmrgoier mgioperm rpgoeri wmpogemr opbmwro bmoirenwbp iorw pwwrporow  oirwmboip neon wokmrgoier mgioperm rpgoeri wmpogemr opbmwro bmoirenwbp iorw pwwrporow  oirwmboip neon wokmrgoier mgioperm rpgoeri wmpogemr opbmwro bmoirenwbp iorw pwwrporow  oirwmboip neon wori nrwoin hui uuubibibiu niobibib"
    }

    func getMothTrip() -> String {
        return "Maio"
    }

    func getDayTrip() -> String {
        return "22"
    }
}
