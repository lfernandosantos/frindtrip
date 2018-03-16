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

class HomeViewController: UIViewController {

    @IBOutlet weak var imageViewIcons: UIImageView!
    @IBOutlet weak var btnFriendTrip: UIButton!
    var user: UserFace?


    override func viewDidLoad() {
        super.viewDidLoad()

        btnFriendTrip.layer.cornerRadius = btnFriendTrip.frame.height/5

        print(user?.toJSONString())
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backHere(){

    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
