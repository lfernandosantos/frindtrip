//
//  APIUser.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 03/04/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import Alamofire

class APIUser {
    let url = URL(string: "https://evening-taiga-94123.herokuapp.com/users/")!
    let user: UserViewModel
    func getParameters() -> Parameters {

        let parameters: Parameters = [
            "nome": user.name,
            "email": user.email,
            "foto": user.picUrl
        ]

        return parameters
    }

    init(user: UserViewModel) {
        self.user = user
    }

    func createNewUser(completion:@escaping (Bool, [String: Any]?, Error?) -> Void) {

        let parameters = getParameters()

        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { response in

            switch response.result {
            case .success:
                if let response = response.result.value as? [String: Any] {
                    completion(true, response, nil)
                } else {
                    completion(false, nil, nil)
                }
                break
            case.failure(let error):
                completion(false, nil, error)
                break
            }
        }
    }
}
