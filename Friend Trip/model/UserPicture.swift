//
//  UserPicture.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 25/12/2017.
//  Copyright © 2017 LFSantos. All rights reserved.
//

import UIKit
import ObjectMapper

class UserPicture: NSObject, Mappable {

    var data: DataPicture?

    required init?(map: Map) {}

    func mapping(map: Map){
        data <- map["data"]
    }
}
