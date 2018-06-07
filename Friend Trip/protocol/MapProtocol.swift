//
//  MapProtocol.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 12/05/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation

protocol MapProtocol {
    func setCategory(category: String)
    func addNewTrip(_ trip: Trip)
}
