//
//  FaceUser.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 25/12/2017.
//  Copyright © 2017 LFSantos. All rights reserved.
//

import UIKit
import ObjectMapper

class UserFace: NSObject, Mappable {

    var id: String?
    var firstName: String?
    var lastName: String?
    var email:String?
    var picture: UserPicture?

    required init?(map: Map) {}

    func mapping(map: Map){
        id <- map["id"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        email <- map["email"]
        picture <- map["picture"]
    }
   
}
