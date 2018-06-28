//
//  NewTripVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 18/03/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import MapKit

class NewTripVC: UIViewController, ProtocolView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var nameTrip: UITextField!
    @IBOutlet weak var localTrip: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var categoria: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnSave: UIButton!

    var location: LocationModel?
    var mapDelegate: MapProtocol?
    let categoriaPickerView = UIPickerView()
    var viewOriginY: CGFloat?
    var evento: String?
    let tiposTripList = ["Beer", "Night", "Party", "Beach"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

        setGradientBackGround()
        btnSave.layer.cornerRadius = btnSave.bounds.height / 2
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

        descriptionTextView.layer.borderWidth = 0.8
        descriptionTextView.layer.borderColor = UIColor.white.cgColor
        descriptionTextView.layer.cornerRadius = 3
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapView" {
            if let mapLocationVC = segue.destination as? MapViewSetLocalVC {
                mapLocationVC.locationDelegate = self
                mapLocationVC.textSearchbar = localTrip.text
            }
        }
    }

    func configKeyboardObserver() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        view.addGestureRecognizer(tap)
        
        let tapLocation: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openScreenLocation))
        
        localTrip.addGestureRecognizer(tapLocation)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:.UIKeyboardWillShow , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:.UIKeyboardWillHide , object: nil)

        nameTrip.delegate = self
        dataTextField.delegate = self
        categoria.delegate = self
        localTrip.delegate = self
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dataTextField.text = dateFormatter.string(from: sender.date)
    }

    override func viewWillDisappear(_ animated: Bool) {
        removeGradientNavBar()
        //self.navigationController?.navigationBar.backgroundColor = .clear

    }

    override func viewWillAppear(_ animated: Bool) {
        viewOriginY = self.view.frame.origin.y
        setGradientBackgroundNavigationbar()
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
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

        print(data)

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
        if let location = location {
            let trip = Trip(id: 33, nome: nome, local: local, data: data, tipoEvento: tipoEvento, descriptionTrip: textDescription, lat: location.latitude, lon: location.longitude, userAdm: UserFace(JSON: jsonUser)!, status: "confirmed", numParticipantes: 1)

            mapDelegate?.addNewTrip(trip)
        } else {
            print("erro no lcation")
        }

        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func setFirstValueOnTextData() {
        if dataTextField.text == "" || dataTextField.text == nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
            dataTextField.text = dateFormatter.string(from: Date())
        }
    }

    @IBAction func setFirstValueOnTextCategoria() {
        if categoria.text == "" || categoria.text == nil {
            categoria.text = tiposTripList[0]
        }
    }
    
    @IBAction func openScreenLocation() {
        performSegue(withIdentifier: "mapView", sender: nil)

    }

    func setGradientBackGround(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds

        let colorTop = UIColor(named: "ColorPinkGradientBottom")
        let colorBottom = UIColor(named: "ColorOrangeGrandientTop")

        gradientLayer.colors =  [colorTop, colorBottom].map{$0?.cgColor}
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.7)

        view.layer.insertSublayer(gradientLayer, at: 0)
        loadViewIfNeeded()

    }

    func setGradientBackgroundNavigationbar(){
        let gradientLayer = CAGradientLayer()
        if let navbar = self.navigationController {
            gradientLayer.frame = navbar.toolbar.bounds

            let colorTop = UIColor(named: "ColorOrangeGrandientTop")
            let colorBottom = UIColor(named: "ColorPinkGradientBottom")

            gradientLayer.colors =  [colorTop, colorBottom].map{$0?.cgColor}
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.7, y: 0.0)

            navbar.navigationBar.layer.insertSublayer(gradientLayer, at: 0)
            navbar.navigationBar.tintColor = UIColor.white
            navbar.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            loadViewIfNeeded()
        }
    }

    func removeGradientNavBar() {
        if let navbar = self.navigationController {
            navbar.navigationBar.layer.sublayers?.remove(at: 0)
            
        }
    }
}

extension NewTripVC: TripProtocol {
    func setLocation(mkPlacemark: MKPlacemark) {

        location = LocationModel(nome: mkPlacemark.name, rua: mkPlacemark.thoroughfare, n: mkPlacemark.subThoroughfare, bairro: mkPlacemark.subLocality, cidade: mkPlacemark.locality, estado: mkPlacemark.administrativeArea, lat: mkPlacemark.coordinate.latitude, lon: mkPlacemark.coordinate.longitude)

        if let local = location{
            var address = ""
            if let rua = local.rua {
                address += rua

                if let numero = local.numero {
                    address +=  ", " + numero
                    if let bairro = local.bairro {
                        address += ", " + bairro
                    }
                }
            }
            localTrip.text = local.nome ?? "" + address
            
            localTrip.endEditing(true)
            
            dismissKeyboard()
           
        }
    }
}
