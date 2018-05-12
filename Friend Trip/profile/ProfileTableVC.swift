//
//  ProfileTableVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 27/02/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import Kingfisher
import FacebookLogin

class ProfileTableVC: UITableViewController {

    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var labelProfile: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var viewBackGround: UIView!
    @IBOutlet weak var btnLogout: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        getUserInfo()

        setGradientBackGround()
    }

    override func viewDidAppear(_ animated: Bool) {
        setupViews()
    }
    func getUserInfo() {

        indicatorView.startAnimating()
        
        DataManager().checkAccessData(completion: { (success, accessToken) in

            if let accessToken = accessToken{
                LoginFBRequest().getUserInfo(accessToken: accessToken){ result, error in
                    if let result = result{
                        guard let userFace = UserFace(JSON: result) else {
                            return
                        }

                        let userViewModel = ProfileViewModel(userFace: userFace)
                        let urlImage = URL(string: userViewModel.imageURL)
                        self.imageViewProfile.kf.setImage(with: urlImage)
                        self.imageViewProfile.clipsToBounds = true
                        self.imageViewProfile.layer.cornerRadius = self.imageViewProfile.bounds.height/2
                        self.labelProfile.text = userViewModel.nameProfile
                        self.labelEmail.text = userViewModel.emailProfile
                    }
                    self.indicatorView.stopAnimating()
                }
            }
        })
    }

    @IBAction func logout(_ sender: Any) {
        let alertSheet = UIAlertController(title: "", message: "Deseja deslogar?", preferredStyle: .actionSheet)
        alertSheet.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { action in
            LoginManager().logOut()
            self.dismiss(animated: true, completion: nil)
        }))
        alertSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        present(alertSheet, animated: true, completion: nil)
    }

    func setupViews() {
        indicatorView.hidesWhenStopped = true
    }

    func setGradientBackGround(){

        let colorTop = UIColor(named: "ColorOrangeGrandientTop")
        let colorBottom = UIColor(named: "ColorPinkGradientBottom")

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors =  [colorTop, colorBottom].map{$0?.cgColor}
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.2)
        gradientLayer.frame = tableView.bounds
        gradientLayer.frame.size.height = viewBackGround.frame.height

        viewBackGround.layer.addSublayer(gradientLayer)
        viewBackGround.bringSubview(toFront: imageViewProfile)
        viewBackGround.bringSubview(toFront: btnLogout)

    }

}

