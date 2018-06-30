//
//  TableViewCell.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 11/06/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit

class CustomSavedTVCell: UITableViewCell {

    @IBOutlet weak var imgCategoria: UIImageView!
    @IBOutlet weak var lblNomeTrip: UILabel!
    @IBOutlet weak var lblDataTrip: UILabel!
    @IBOutlet weak var btnConfirmar: UIButton!
    @IBOutlet weak var lblDayTrip: UILabel!
    @IBOutlet weak var lblMonthTrip: UILabel!
    @IBOutlet weak var btnSaveTrip: UIButton!

    weak var cellDelegate: CellButtonProtocol?

    @IBAction func buttonPressed(_ sender: UIButton) {
        cellDelegate?.didTapButtonCell(sender.tag)
    }

    @IBAction func buttonSavedPressed(_ sender: UIButton) {
        cellDelegate?.didTapSavedButtonCell(sender.tag)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
