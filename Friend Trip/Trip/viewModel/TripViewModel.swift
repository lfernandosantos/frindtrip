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
        self.descriptionTrip = trip.description
    }

    func getMothTrip() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"

        guard let date = dateFormatter.date(from: dataTrip) else {
            return "0"
        }

        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: date)
    }

    func getDayTrip() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"

        guard let date = dateFormatter.date(from: dataTrip) else {
            return "0"
        }

        let calendar = Calendar(identifier: .gregorian)
        let day = calendar.component(.day, from: date)

        return String(day)
    }
}
