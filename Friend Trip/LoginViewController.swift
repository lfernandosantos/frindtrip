//
//  ViewController.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 17/12/2017.
//  Copyright © 2017 LFSantos. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class LoginViewController: UIViewController, LoginButtonDelegate {


    @IBOutlet weak var viewBtnFace: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        var loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends, .userPhotos ])

        viewBtnFace.layer.cornerRadius = 6
        loginButton.center = view.center
        loginButton.delegate = self
        loginButton.frame = viewBtnFace.frame
        view.addSubview(loginButton)
    
        loginButton.layer.cornerRadius = 10


    }

    override func viewDidAppear(_ animated: Bool) {
        if let accessToken = AccessToken.current {
            makeLogin(accessToken: accessToken)
        }else{
            print("sem login")
        }
    }

    override func viewWillAppear(_ animated: Bool) {


    }

    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .success(let garanted, let declined, let token):
            makeLogin(accessToken: token)
        default:
            print("default")
        }
        print("did complete")
    }

    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("logout")
    }

    func makeLogin(accessToken: AccessToken){
        getUserInfo(accessToken: accessToken){ result, error in

            if let result = result{
                let userFace = UserFace(JSON: result)

                print(userFace?.id)
                print(userFace?.email)
                print(userFace?.picture?.data?.isSilhouette)

                self.performSegue(withIdentifier: "goHome", sender: nil)

            }
        }
        print("access: \(accessToken) fim")

    }



    func getUserInfo(accessToken : AccessToken, completion: @escaping (_ :[String:Any]?, _ : Error?) -> Void){
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        GraphRequest(graphPath: "me", parameters: parameters, accessToken: accessToken, httpMethod: .GET, apiVersion: .defaultVersion).start{ httpResponse, graphResult in
            print(httpResponse?.statusCode)

            switch graphResult {
            case .failed(let error):
                completion(nil, error)
            case .success(let graphResponse):
                completion(graphResponse.dictionaryValue, nil)
            }

        }

//        let request = GraphRequest(graphPath: "me", parameters: parameters)
//
//        request.start{ response, result in
//            switch result {
//            case .failed(let error):
//                completion(nil, error)
//            case .success(let graphResponse):
//                completion(graphResponse.dictionaryValue, nil)
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

