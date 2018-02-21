//
//  HomeViewController.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 25/12/2017.
//  Copyright © 2017 LFSantos. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {


    @IBOutlet weak var imageViewIcons: UIImageView!
    @IBOutlet weak var btnFriendTrip: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()


        btnFriendTrip.layer.cornerRadius = btnFriendTrip.frame.height/5

        // Do any additional setup after loading the view.
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backHere(){

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
