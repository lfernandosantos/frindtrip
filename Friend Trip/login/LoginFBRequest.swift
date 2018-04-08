//
//  LoginFBRequest.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 27/02/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class LoginFBRequest: NSObject {

    func getUserInfo(accessToken: AccessToken, completion: @escaping (_ :[String:Any]?, _ : Error?) -> Void) {
        let parameters = ["fields": "id, name, email, first_name, last_name, picture.type(large)"]
        GraphRequest(graphPath: "me", parameters: parameters, accessToken: accessToken, httpMethod: .GET, apiVersion: .defaultVersion).start{ httpResponse, graphResult in

            switch graphResult {
            case .failed(let error):
                completion(nil, error)
            case .success(let graphResponse):
                completion(graphResponse.dictionaryValue, nil)
            }
        }
    }
}
