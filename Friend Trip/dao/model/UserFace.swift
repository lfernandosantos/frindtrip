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
    var name: String?
    var email:String?
    var picture: UserPicture?

    required init?(map: Map) {}

    func mapping(map: Map){
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        picture <- map["picture"]
    }

    func getProfilePic() -> String {
        guard let id = id else {
          return ""
        }
        print(id)
        let urlPic: String = "\(FaceConstants.urlGraph)\(id)\(FaceConstants.endPointPicLarge)"
        return urlPic
    }
   
}
