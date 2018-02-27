//
//  LoginVM.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 26/02/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class LoginVM: NSObject, LoginButtonDelegate {

    var viewLogin: LoginVC

    init(viewLogin: LoginVC) {
        self.viewLogin = viewLogin
    }

    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .success(let garanted, let declined, let token):
            self.makeLogin(accessToken: token)
        case .failed(let error):
            self.viewLogin.showAlert(title: "", msg: "Erro ao realizar login. \nTente novamente!")
            print(error)
        case .cancelled:
            print("cancelou")
            self.viewLogin.showAlert(title: "", msg: "Login cancelado!")
        }
        print("did complete")
    }

    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("logout")
    }

    func makeLogin(accessToken: AccessToken){
        LoginFBRequest().getUserInfo(accessToken: accessToken){ result, error in
            if let result = result{
                let userFace = UserFace(JSON: result)
                self.viewLogin.performSegue(withIdentifier: "goHome", sender: userFace)
            }
        }
    }

    func checkAlreadyLogin(){
        if let accessToken = AccessToken.current {
            makeLogin(accessToken: accessToken)
        }else{
            print("sem login")
        }
    }

}
