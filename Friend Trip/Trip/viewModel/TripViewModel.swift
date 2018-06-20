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
    let adm: UserFace
    let picAdm: String
    let status: String
    var participantes: Int

    init(trip: Trip) {
        self.id = trip.id
        self.nameTrip = trip.nome
        self.localTrip = trip.local
        self.dataTrip = trip.data
        self.typeTrip = trip.tipoEvento
        self.adm = trip.userAdm
        self.picAdm = trip.userAdm.getProfilePic()
        self.descriptionTrip = trip.description
        self.status = trip.status
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

    func getHourTrip() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"

        guard let date = dateFormatter.date(from: dataTrip) else {
            return "0"
        }

        let calendar = Calendar(identifier: .gregorian)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)

        return "\(hour):\(minute)"
    }

    func setStatus(_ status: String) {
        updateStatus(status)

    }
    
    func getImgTrip() -> UIImage? {
        return UIImageCategory.getImgCategory(typeTrip)
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
        dao.idUser = adm.id ?? ""
        dao.nome = nameTrip
        dao.tipoEvento = typeTrip
        dao.data = dataTrip
        dao.participantes = Int16(id)
        dao.status = status
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

    func isConfirmed() -> Bool {
        let fetchRequest: NSFetchRequest<TripsDAO> = TripsDAO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id=%@", "\(id)")
        if let result = try? PersistenceService.context.fetch(fetchRequest) {

            if result[0].status == "confirmed" {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }

    func updateStatus(_ status: String) {
        let fetchRequest: NSFetchRequest<TripsDAO> = TripsDAO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id=%@", "\(id)")
        if let result = try? PersistenceService.context.fetch(fetchRequest) {

            for r in result {
                r.status = status
            }

            PersistenceService.saveContext()
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

    static func savedTrips() -> [TripsDAO] {
        let request: NSFetchRequest<TripsDAO> = TripsDAO.fetchRequest()

        do {
            let trip = try PersistenceService.context.fetch(request)
            return trip
        } catch {
            return [TripsDAO]()
        }
    }
}
