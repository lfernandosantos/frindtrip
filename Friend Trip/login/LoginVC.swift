//
//  ViewController.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 17/12/2017.
//  Copyright © 2017 LFSantos. All rights reserved.
//

import UIKit
import FacebookLogin

class LoginVC: UIViewController {

    @IBOutlet var loginFBbtn: LoginButton!
    var loginVM: LoginPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginVM = LoginPresenter(viewLogin: self)
        loginFBbtn = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends, .userPhotos ])
        loginFBbtn.delegate = loginVM
    }

    override func viewDidAppear(_ animated: Bool) {
        loginVM?.checkAlreadyLogin()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let homeVC: HomeVC = segue.destination as? HomeVC{
            homeVC.user = sender as? UserFace
        }
    }
    
    func showAlert(title: String, msg: String){
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

