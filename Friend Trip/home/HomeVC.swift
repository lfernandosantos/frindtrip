//
//  HomeViewController.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 25/12/2017.
//  Copyright © 2017 LFSantos. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin


class HomeVC: UIViewController {

    @IBOutlet weak var imageViewIcons: UIImageView!
    @IBOutlet weak var btnFriendTrip: UIButton!
    var user: UserFace?


    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        btnFriendTrip.layer.cornerRadius = btnFriendTrip.frame.height/5

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backHere(){

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mapVC = segue.destination as? MapListFriendTripVC {
            
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
