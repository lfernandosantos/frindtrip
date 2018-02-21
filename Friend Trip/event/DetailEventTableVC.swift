//
//  DetailEventVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 04/02/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import ParallaxHeader
import SnapKit

class DetailEventTableVC: UITableViewController {

    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()


            //self.tableView.contentInset = UIEdgeInsetsMake(-100,0,0,0)

//        if let imageView = Bundle.main.loadNibNamed("HeaderDetailV", owner: self, options: nil)?.first as? HeaderDetailsClass{
//            imageView.background.image = UIImage(named: "ImageBack")
//            imageView.contentMode = .scaleAspectFill
//
//            imageView.blurView.alpha = 1.0
//            tableView.parallaxHeader.view = imageView
//            tableView.parallaxHeader.height = 250
//            tableView.parallaxHeader.minimumHeight = 50
//            tableView.parallaxHeader.mode = .bottomFill
//            tableView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallax in
//                parallax.view.blurView.alpha = 0.4 - parallax.progress
//
//            }
//
//            let roundIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//
//            roundIcon.image = UIImage(named: "ImageBack")
//            roundIcon.layer.borderColor = UIColor.white.cgColor
//            roundIcon.layer.borderWidth = 2
//            roundIcon.layer.cornerRadius = roundIcon.frame.width / 2
//            //roundIcon.clipsToBounds = true
//
//            imageView.blurView.blurContentView?.addSubview(roundIcon)
//
//            roundIcon.snp.makeConstraints{ make in
//                make.width.height.equalTo(100)
//            }
//        }
    }

    override func viewDidLayoutSubviews() {
        if let rect = self.navigationController?.navigationBar.frame {
            let statusHeight = UIApplication.shared.statusBarFrame.height
            let y = rect.size.height + statusHeight
            self.tableView.contentInset = UIEdgeInsetsMake(-y, 0, 0, 0)
        }
    }
}
