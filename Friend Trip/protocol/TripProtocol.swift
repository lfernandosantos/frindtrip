//
//  TripProtocol.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 31/05/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation
import MapKit

protocol TripProtocol {
    func setLocation(mkPlacemark: MKPlacemark)
}
protocol TripMapLocation {
    var locationDelegate: TripProtocol {get}
}
