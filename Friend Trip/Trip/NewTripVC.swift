//
//  NewTripVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 18/03/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit

class NewTripVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTrip: UITextField!
    @IBOutlet weak var localTrip: UITextField!
    @IBOutlet weak var dataTrip: UIDatePicker!
    @IBOutlet weak var tipoTrip: UIPickerView!
    @IBOutlet weak var btnSalvarTrip: UIButton!
    @IBOutlet weak var txfDescription: UITextField!
    

    var evento: String?
    let tiposTripList = ["Beer", "Night", "Party", "Beach"]

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

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:.UIKeyboardWillShow , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:.UIKeyboardWillHide , object: nil)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @objc func keyboardWillShow(notification:NSNotification){

        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 30
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
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

        guard let description = txfDescription.text else {
            print("descrição em branco")
            return
        }

        let jsonUser: [String : Any] = ["picture":
            [ "data":
                [ "height": 200,
                  "is_silhouette": 0,
                  "url": "https://lookaside.facebook.com/platform/profilepic/?asid=1571861286232650&height=200&width=200&ext=1522876279&hash=AeQOe6O7qufeR2Rl",
                  "width": 200 ]

            ],
                                        "name": "Fernando Santos", "email": "fernandin222@hotmail.com", "id": 1571861286232650]
        let trip = Trip(nome: nome, local: local, data: " ", tipoEvento: tipoEvento, descriptionTrip: description, lat: -22.767654, lon: -43.426178, userAdm: UserFace(JSON: jsonUser)!)
    }
    

}
