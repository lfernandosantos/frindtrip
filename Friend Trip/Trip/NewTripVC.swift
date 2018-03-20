//
//  NewTripVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 18/03/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit

class NewTripVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var nameTrip: UITextField!
    @IBOutlet weak var localTrip: UITextField!
    @IBOutlet weak var dataTrip: UIDatePicker!
    @IBOutlet weak var tipoTrip: UIPickerView!
    @IBOutlet weak var btnSalvarTrip: UIButton!
    var evento: String?
    let tiposTripList = ["Beer", "Night", "Tour", "Party", "Club"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hiddenKeyboard))
        dataTrip.addGestureRecognizer(tap)
        view.addGestureRecognizer(tap)

        nameTrip.delegate = self
        localTrip.delegate = self

        dataTrip.setValue(UIColor.orange, forKey: "textColor")
        tipoTrip.setValue(UIColor.orange, forKey: "textColor")

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hiddenKeyboard()
        return false
    }

    @objc func hiddenKeyboard(){
        self.view.endEditing(true)
        nameTrip.endEditing(true)
        localTrip.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tiposTripList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        evento = tiposTripList[row]
        print(tiposTripList[row])
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tiposTripList.count
    }

    
    @IBAction func salvarTrip(_ sender: Any) {

        guard let nome = nameTrip.text else {
            print("nome em branco")
            return
        }
        guard let local = localTrip.text else {
            print("local em branco")
            return
        }
        let data = dataTrip.debugDescription

        guard let tipoEvento = evento else {
            print("evento em branco")
            return
        }

        print(data)

        let trip = Trip(nome: nome, local: local, data: " ", tipoEvento: tipoEvento)
        print(trip.description)
    }

}
