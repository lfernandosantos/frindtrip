//
//  WellcomeVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 30/04/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import Kingfisher

class WellcomeVC: UIViewController, ProtocolView {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var hastagsTXF: UITextField!

    var userFace: UserFace?
    var viewOriginY: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()

        setGradientBackGround()

    }


    //todo: enviar hashtags
    override func viewDidLayoutSubviews() {
        confirmBtn.layer.cornerRadius = confirmBtn.bounds.height / 4
    }


    override func viewWillAppear(_ animated: Bool) {
        setupView()

        if let user = userFace {
            let userViewModel = ProfileViewModel(userFace: user)

            let urlImage = URL(string: userViewModel.imageURL)
            self.profileImg.kf.setImage(with: urlImage)
            profileImg.clipsToBounds = true
            profileImg.layer.cornerRadius = profileImg.bounds.height/2
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        profileImg.layer.cornerRadius = profileImg.bounds.width / 2
    }

    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func setupView() {

        viewOriginY = self.view.frame.origin.y

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    func showAlert(title: String, msg: String) {

    }

    func setGradientBackGround(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds

        let colorTop = UIColor(named: "ColorOrangeGrandientTop")
        let colorBottom = UIColor(named: "ColorPinkGradientBottom")

        gradientLayer.colors =  [colorTop, colorBottom].map{$0?.cgColor}
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.2)

        view.layer.insertSublayer(gradientLayer, at: 0)
        loadViewIfNeeded()
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == viewOriginY{
                self.view.frame.origin.y -= 100
            }
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != viewOriginY{
                self.view.frame.origin.y += 100
                loadViewIfNeeded()
            }

        }
    }
}
