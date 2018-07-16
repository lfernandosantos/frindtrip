//
//  GlobalConstants.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 17/06/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation

struct GlobalConstants {

    struct Categories {
        static let BEER = "Beer"
        static let ADVENTURE = "Adventure"
        static let CLUB = "Club"
        static let PARTY = "Party"
        static let CULT = "Cult"
    }

    struct SegueIdentifier {
        static let CONFIRMED_TRIPS = "confirmedTrips"
        static let SAVED_TRIPS = "savedTrips"
        static let MY_TRIPS = "myTrips"
        enum TypeTripsList {
            case CONFIRMED
            case SAVED
            case MYTRIP
        }
    }

    let dateHoraFormat = "MM-dd-yyyy HH:mm"
}
