//
//  ProfileViewModel.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 11/03/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileViewModel {

    let nameProfile: String
    let emailProfile: String
    let imageURL: String

    init(userFace: UserFace) {

        var stringName = ""
        if let first = userFace.firstName {
            stringName += first
        }
        if let last = userFace.lastName {
            stringName += " \(last)"
        }
        self.nameProfile = stringName
        self.emailProfile = userFace.email ?? " "
        self.imageURL = userFace.picture?.data?.url ?? " "
    }

    func getImage () -> UIImageView{
        let urlImage = URL(string: "https://beebom-redkapmedia.netdna-ssl.com/wp-content/uploads/2016/01/Reverse-Image-Search-Engines-Apps-And-Its-Uses-2016.jpg")
        let image = UIImageView()
        image.kf.setImage(with: urlImage)
        return image
    }
}
