//
//  DataPicture.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 25/12/2017.
//  Copyright © 2017 LFSantos. All rights reserved.
//

import UIKit
import ObjectMapper

class DataPicture: NSObject, Mappable {

    var height: Int?
    var width: Int?
    var isSilhouette: Bool?
    var url: String?

    required init?(map: Map) {}

    func mapping(map: Map){
        height <- map["height"]
        width <- map["width"]
        isSilhouette <-  map["is_silhouette"]
        url <- map["url"]
    }
}
