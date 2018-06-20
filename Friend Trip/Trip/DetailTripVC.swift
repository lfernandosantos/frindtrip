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
    @IBOutlet weak var imgFavoriteTrip: UIImageView!
    @IBOutlet weak var lblDescriptionTrip: UITextView!
    @IBOutlet weak var lblParticipantes: UILabel!
    @IBOutlet weak var lblNameAdmin: UILabel!
    @IBOutlet weak var imgProfileAdm: UIImageView!
    @IBOutlet weak var btnConfirm: UIButton!

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    var tripViewModel: TripViewModel!
    @IBOutlet weak var constraintTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let nav = navigationController?.navigationBar.bounds.height {
            constraintTop.constant -= nav
        }

        setUp()
    }

    func setUp() {
        let tapFavorite = UITapGestureRecognizer(target: self, action: #selector(setFavoriteTrip(tapGestureRecognizer:)))
        imgFavoriteTrip.addGestureRecognizer(tapFavorite)
        imgFavoriteTrip.isUserInteractionEnabled = true

        if tripViewModel.isSaved() {
            imgFavoriteTrip.isHighlighted = true
        }

        setViews()
    }

    func setViews() {
        lblTitleTrip.text = tripViewModel.nameTrip
        lblTypeTrip.text = tripViewModel.typeTrip
        lblLocalTrip.text = tripViewModel.localTrip
        lblDayTrip.text = tripViewModel.getDayTrip()
        lblMonthTrip.text = tripViewModel.getMothTrip()
        lblDescriptionTrip.text = tripViewModel.descriptionTrip
        lblParticipantes.text = tripViewModel.getParticipantes()
        lblNameAdmin.text = tripViewModel.adm.name
        imgTrip.image = tripViewModel.getImgTrip()

        //tratar imagem e inserir view model do user na trip
        let urlImg = URL(string: tripViewModel.picAdm)
        imgProfileAdm.kf.setImage(with: urlImg!)

        btnConfirm.layer.cornerRadius = 6

        statusButton()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func setFavoriteTrip(tapGestureRecognizer: UITapGestureRecognizer) {
        if imgFavoriteTrip.isHighlighted {
            imgFavoriteTrip.isHighlighted = false
            tripViewModel.removeTrip()
        } else {
            imgFavoriteTrip.isHighlighted = true
            tripViewModel.saveTrip()
        }
    }

    func statusButton () {
        if tripViewModel.isConfirmed() {
        btnConfirm.backgroundColor = UIColor.red
        btnConfirm.setTitle("Remover", for: .normal)
        }
    }
    @IBAction func confirmTrip(_ sender: Any) {
        if tripViewModel.isConfirmed() {
            tripViewModel.setStatus(" ")
            navigationController?.popViewController(animated: true)
        } else {
            tripViewModel.setStatus("confirmed")
            navigationController?.popViewController(animated: true)
        }

    }
}
