//
//  HandleMapSearch.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 06/05/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation
import MapKit

protocol HandleMapSearch {
    func dropZoomIn(coordinate: CLLocationCoordinate2D)
    func setMKPlacemark(mkPlacemark: MKPlacemark)
}
