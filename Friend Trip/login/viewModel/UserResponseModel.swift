//
//  UserRequestModel.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 03/04/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import ObjectMapper

class UserResponseModel: NSObject, Mappable {

    var id: String?
    var name: String?
    var email:String?
    var picture: String?


    init?(user: UserFace){
        self.name = user.name
        self.email = user.email
        self.picture = user.picture?.data?.url
    }

    required init?(map: Map) {}

    func mapping(map: Map){
        id <- map["_id"]
        name <- map["nome"]
        email <- map["email"]
        picture <- map["foto"]
    }
}
