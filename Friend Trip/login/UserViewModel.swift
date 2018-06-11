//
//  UserViewModel.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 06/04/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import CoreData

class UserViewModel: NSObject {

    let idFacebook: String
    let name: String
    let email: String
    let picUrl: String

    init(userFace: UserFace) {
        self.idFacebook = String(userFace.id ?? 0)
        self.name = userFace.name!
        self.email = userFace.email ?? " "
        self.picUrl = userFace.picture?.data?.url ?? " "
    }

    init(userAPIResponse: UserResponseModel) {
        self.idFacebook = userAPIResponse.id!
        self.name = userAPIResponse.name ?? " "
        self.email = userAPIResponse.email ?? " "
        self.picUrl = userAPIResponse.picture ?? " "
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
