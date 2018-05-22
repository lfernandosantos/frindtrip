//
//  NewTripVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 18/03/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit

class NewTripVC: UIViewController, ProtocolView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {


    @IBOutlet weak var nameTrip: UITextField!
    @IBOutlet weak var localTrip: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var categoria: UITextField!

    @IBOutlet weak var scrollView: UIScrollView!

    let categoriaPickerView = UIPickerView()
    var viewOriginY: CGFloat?
    var evento: String?
    let tiposTripList = ["Beer", "Night", "Party", "Beach"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    func setupView() {

        configKeyboardObserver()

        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "ColorTransparent")
        self.navigationItem.backBarButtonItem?.title = " "

        //set picker view ao invés do keyboard
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .dateAndTime
        dataTextField.inputView = datePickerView

        categoria.inputView = categoriaPickerView

        datePickerView.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        datePickerView.addTarget(self, action: #selector(setFirstValueOnTextData), for: .editingDidBegin)

        categoria.addTarget(self, action: #selector(setFirstValueOnTextCategoria), for: .editingDidBegin)
    }

    func configKeyboardObserver() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:.UIKeyboardWillShow , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:.UIKeyboardWillHide , object: nil)

        nameTrip.delegate = self
        localTrip.delegate = self
        dataTextField.delegate = self
        categoria.delegate = self
        categoriaPickerView.delegate = self
        descriptionTextView.delegate = self
    }

    @IBAction func dismissKeyboard() {
        view.endEditing(true)
        nameTrip.endEditing(true)
        localTrip.endEditing(true)
        dataTextField.resignFirstResponder()
        categoria.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
    }

    func showAlert(title: String, msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }


    @IBAction func handleDatePicker(sender: UIDatePicker) {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMM/yyyy hh:mm"
        dataTextField.text = dateFormatter.string(from: sender.date)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.backgroundColor = .clear
    }

    override func viewWillAppear(_ animated: Bool) {

        viewOriginY = self.view.frame.origin.y
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
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return false
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.endEditing(true)
            return false
        }
        return true
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tiposTripList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoria.text = tiposTripList[row]

    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tiposTripList.count
    }

    @IBAction func salvarTrip(_ sender: Any) {

        guard let nome = nameTrip.text, let local = localTrip.text, let data = dataTextField.text, let tipoEvento = categoria.text, let textDescription = descriptionTextView.text else {
            print("Algum dado do formulário em branco")
            showAlert(title: "", msg: "Preencha todos os campos da Trip! \n=]")
            return
        }


        if nome.isEmpty || local.isEmpty || data.isEmpty || tipoEvento.isEmpty || textDescription.isEmpty {
            showAlert(title: "", msg: "Preencha todos os campos da Trip! \n=]")
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
