//
//  TripViewModel.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 25/03/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TripViewModel {

    let id: Int
    let nameTrip: String
    let localTrip: String
    let dataTrip: String
    let typeTrip: String
    let descriptionTrip: String
    let admName: String
    let picAdm: String
    var participantes: Int

    init(trip: Trip) {
        self.id = trip.id
        self.nameTrip = trip.nome
        self.localTrip = trip.local
        self.dataTrip = trip.data
        self.typeTrip = trip.tipoEvento
        self.admName = trip.userAdm.name ?? "Name"
        self.picAdm = trip.userAdm.picture?.data?.url ?? "placehoder"
        self.descriptionTrip = trip.description
        self.participantes = trip.numParticipantes
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

    func getParticipantes() -> String {
        return "\(participantes) participantes"
    }

    func addParticipante() {
        participantes += 1
        //realizar update para API com o novo user
    }

    func saveTrip() {
        let dao = TripsDAO(context: PersistenceService.context)
        dao.id = Int32(id)
        dao.nome = nameTrip
        dao.tipoEvento = typeTrip
        dao.data = dataTrip
        dao.participantes = Int16(id)
        PersistenceService.saveContext()
    }

    func isSaved() -> Bool {
        let fetchRequest: NSFetchRequest<TripsDAO> = TripsDAO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id=%@", "\(id)")
        if let result = try? PersistenceService.context.fetch(fetchRequest) {
            if result.count > 0 {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }

    func removeTrip() {
        let fetchRequest: NSFetchRequest<TripsDAO> = TripsDAO.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "id=%@", "\(id)")
        if let result = try? PersistenceService.context.fetch(fetchRequest) {
            for object in result {
                PersistenceService.context.delete(object)
            }
        }
    }

    func savedTrips() -> [TripsDAO] {
        let request: NSFetchRequest<TripsDAO> = TripsDAO.fetchRequest()

        do {
            let trip = try PersistenceService.context.fetch(request)
            return trip
        } catch {
            return [TripsDAO]()
        }
    }
}
