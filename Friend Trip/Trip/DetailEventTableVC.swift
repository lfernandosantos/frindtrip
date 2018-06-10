//
//  DetailEventVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 04/02/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit

class DetailEventTableVC: UITableViewController {


    @IBOutlet weak var imgSaveEvent: UIImageView!
    @IBOutlet weak var lblDayTrip: UILabel!
    @IBOutlet weak var lblMonthTrip: UILabel!
    @IBOutlet weak var lblLocalTrip: UILabel!
    @IBOutlet weak var lblTypeTrip: UILabel!
    @IBOutlet weak var lblTitleTrip: UILabel!
    @IBOutlet weak var lblCreatorTrip: UILabel!
    @IBOutlet weak var imgCreatorTrip: UIImageView!
    @IBOutlet weak var lblDescriptionTrip: UILabel!
    @IBOutlet weak var lblFollowersTrip: UILabel!

    var tripViewModel: TripViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        lblTypeTrip.text = tripViewModel.typeTrip
        lblLocalTrip.text = tripViewModel.localTrip
        lblDayTrip.text = tripViewModel.getDayTrip()
        lblMonthTrip.text = tripViewModel.getMothTrip()
        lblDescriptionTrip.text = tripViewModel.descriptionTrip
        lblTitleTrip.text = tripViewModel.nameTrip

    }

    @objc func saveEvent(tapGestureRecognizer: UITapGestureRecognizer){
        if imgSaveEvent.isHighlighted {
            imgSaveEvent.isHighlighted = false
            
        } else {
            imgSaveEvent.isHighlighted = true
        }
    }

    override func viewDidLayoutSubviews() {
        if let rect = self.navigationController?.navigationBar.frame {
            let statusHeight = UIApplication.shared.statusBarFrame.height
            let y = rect.size.height + statusHeight
            self.tableView.contentInset = UIEdgeInsetsMake(-y, 0, 0, 0)
        }
    }
}
