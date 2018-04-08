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
    var spinnerView = UIView()
    let loadIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginVM = LoginPresenter(viewLogin: self)
        loginFBbtn = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends, .userPhotos ])
        loginFBbtn.delegate = loginVM

    }

    override func viewWillAppear(_ animated: Bool) {
        setupLoading()
    }

    override func viewDidAppear(_ animated: Bool) {
        startIndicator()
        loginVM?.checkAlreadyLogin()
    }

    func setupLoading() {
        spinnerView = UIView(frame: view.bounds)
        spinnerView.backgroundColor = UIColor(named: "ColorDisable")
        loadIndicator.center = spinnerView.center
        loadIndicator.hidesWhenStopped = true
        loadIndicator.activityIndicatorViewStyle = .whiteLarge
        loadIndicator.startAnimating()
        spinnerView.addSubview(loadIndicator)
    }

    func startIndicator() {
        view.addSubview(spinnerView)
    }

    func stopIndicator() {
        loadIndicator.stopAnimating()
        spinnerView.removeFromSuperview()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        stopIndicator()
        if let homeVC: HomeVC = segue.destination as? HomeVC{
            homeVC.user = sender as? UserFace
        }
    }
    
    func showAlert(title: String, msg: String){
        stopIndicator()
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

