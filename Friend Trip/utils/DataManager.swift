//
//  DataManager.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 27/02/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import FacebookCore

class DataManager: NSObject {

    func checkAccessData( completion:(Bool, AccessToken?) -> Void){
        if let accessToken = AccessToken.current {
            completion(true, accessToken)
        }else{
            completion(false, nil)
            print("sem login")
        }
    }

}
