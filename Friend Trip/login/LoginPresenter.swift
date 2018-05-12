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

class LoginPresenter: NSObject, LoginButtonDelegate {

    var viewLogin: LoginVC

    init(viewLogin: LoginVC) {
        self.viewLogin = viewLogin
    }

    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .success(let garanted, let declined, let token):
            self.makeLoginFB(accessToken: token)
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

    func makeLoginFB(accessToken: AccessToken) {
        LoginFBRequest().getUserInfo(accessToken: accessToken){ result, error in

            if let result = result{
                if let userFace = UserFace(JSON: result) {
                    //verifica se usuário possui nome email e foto
                    if userFace.name == nil || userFace.picture?.data?.url == nil || userFace.email == nil {
                        self.viewLogin.showAlert(title: "Erro", msg: "Não foi possível caputar todos seus dados do Facebook. \nVocê precisa ter nome, email e foto de perfil para logar!")
                    } else {
                        self.loginAPI(user: userFace)
                    }
                } else {
                    self.viewLogin.showAlert(title: "Erro ao logar", msg: "Não foi possível logar com o Facebook. \nVerifique seus dados!")
                }
            } else {
                self.viewLogin.showAlert(title: "Erro ao logar", msg: "Não foi possível logar com o Facebook. \nVerifique seus dados!")
            }
        }
    }

    func loginAPI(user: UserFace) {
        let userRequest = UserViewModel(userFace: user)
        APIUser(user: userRequest).createNewUser { success, response, error in
            if success {
                self.viewLogin.performSegue(withIdentifier: "wellcome", sender: user)
            } else {
                self.viewLogin.showAlert(title: "Ops", msg: "Problemas ao conectar com o servidor!\nVerifique sua conexão e tente novamente!")
            }
        }
    }

    func checkAlreadyLogin() {
        if let accessToken = AccessToken.current {
            makeLoginFB(accessToken: accessToken)
        }else{
            viewLogin.stopIndicator()
            print("sem login")
        }
    }
}
