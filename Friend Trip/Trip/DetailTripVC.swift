//
//  DetailTripVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 01/04/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import Kingfisher

class DetailTripVC: UIViewController {

    @IBOutlet weak var imgTrip: UIImageView!
    @IBOutlet weak var lblTitleTrip: UILabel!
    @IBOutlet weak var lblLocalTrip: UILabel!
    @IBOutlet weak var lblTypeTrip: UILabel!
    @IBOutlet weak var lblMonthTrip: UILabel!
    @IBOutlet weak var lblDayTrip: UILabel!
    @IBOutlet weak var lvlTotalConfirm: UIView!
    @IBOutlet weak var imgFavoriteTrip: UIImageView!
    @IBOutlet weak var lblDescriptionTrip: UITextView!

    @IBOutlet weak var lblNameAdmin: UILabel!
    @IBOutlet weak var imgProfileAdm: UIImageView!
    @IBOutlet weak var btnConfirm: UIButton!

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    var tripViewModel: TripViewModel!
    @IBOutlet weak var constraintTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapFavorite = UITapGestureRecognizer(target: self, action: #selector(setFavoriteTrip(tapGestureRecognizer:)))
        imgFavoriteTrip.addGestureRecognizer(tapFavorite)
        imgFavoriteTrip.isUserInteractionEnabled = true

        lblTitleTrip.text = tripViewModel.nameTrip
        lblTypeTrip.text = tripViewModel.typeTrip
        lblLocalTrip.text = tripViewModel.localTrip
        lblDayTrip.text = tripViewModel.getDayTrip()
        lblMonthTrip.text = tripViewModel.getMothTrip()
        lblDescriptionTrip.text = tripViewModel.descriptionTrip

        lblNameAdmin.text = tripViewModel.admName
//tratar imagem e inserir view model do user na trip
        let urlImg = URL(string: tripViewModel.picAdm)
        imgProfileAdm.kf.setImage(with: urlImg!)
        print(tripViewModel.picAdm)

         btnConfirm.layer.cornerRadius = 6
        // Do any additional setup after loading the view.
        if let nav = navigationController?.navigationBar.bounds.height {
            constraintTop.constant -= nav
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func setFavoriteTrip(tapGestureRecognizer: UITapGestureRecognizer) {
        if imgFavoriteTrip.isHighlighted {
            imgFavoriteTrip.isHighlighted = false
        } else {
            imgFavoriteTrip.isHighlighted = true
        }
    }

    @IBAction func confirmTrip(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
