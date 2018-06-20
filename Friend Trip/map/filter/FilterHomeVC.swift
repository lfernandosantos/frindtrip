//
//  FilterHomeVCViewController.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 16/04/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import MapKit

class FilterHomeVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    var categoria: String?
    var navColor: UIColor?
    var mapDelegate: MapProtocol?

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    let tiposTripList = [" ", GlobalConstants.Categories.BEER, GlobalConstants.Categories.ADVENTURE, GlobalConstants.Categories.PARTY, GlobalConstants.Categories.CLUB]

    override func viewDidLoad() {
        super.viewDidLoad()

        let geCoder = CLGeocoder()
        geCoder.geocodeAddressString("Rua nestor 40, Santo Elias, Mesquita, RJ") { placemarks, error in

            let placeMarks = placemarks
            let location = placemarks?.first?.location

            print(location)
            print(placemarks)

            let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.setFilter))
            self.navigationItem.setRightBarButton(barButton, animated: true)
            self.navColor = self.navigationController?.navigationBar.backgroundColor

        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "ColorTransparent")
        if let selectedItem = categoria{
            mapDelegate?.setCategory(category: selectedItem)
        } else {
            mapDelegate?.setCategory(category: " ")
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.navigationBar.backgroundColor = .clear
    }

    @IBAction func setFilter() {
        if let selectedItem = categoria{
            mapDelegate?.setCategory(category: selectedItem)
        } else {
            
        }
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tiposTripList.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoria = tiposTripList[row]
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tiposTripList[row]
    }

}
