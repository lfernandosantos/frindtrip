//
//  UserRequestModel.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 03/04/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import ObjectMapper

class UserRequestModel: NSObject, Mappable {

    var id: String?
    var name: String?
    var email:String?
    var picture: UserPicture?

    required init?(map: Map) {}

    func mapping(map: Map){
        id <- map["_id"]
        name <- map["nome"]
        email <- map["email"]
        picture <- map["foto"]
    }
}
