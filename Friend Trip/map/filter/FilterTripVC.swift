//
//  FilterTripVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 01/07/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit

class FilterTripVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var calendarCollection: UICollectionView!

    let months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
    let daysOfMonth = ["Domingo","Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"]

    var days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var currentMonth = String()
    var numberOfEmptyBox = Int()
    var nextNumberOfEmptyBox = Int()
    var PreviusNumberOfEmptyBox = 0
    var direction = 0
    var positionIndex = 0
    var leapYearCounter = 2

    var firstDaySelected: Bool = false
    var firstSelectedIndex: IndexPath?
    var secondSelectedIndex: IndexPath?

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var tfFirstDay: UITextField!
    @IBOutlet weak var tfLastDay: UITextField!
    @IBOutlet weak var btnConfirm: UIButton!
    
    @IBAction func nextMonth(_ sender: Any) {
        switch currentMonth {
        case "Dezembro":
            month = 0
            year += 1
            direction = 1
            
            if leapYearCounter < 5 {
                leapYearCounter += 1
            }
            
            if leapYearCounter == 4 {
                days[1] = 29
            }
            
            if leapYearCounter == 5 {
                leapYearCounter = 1
                days[1] = 28
            }
            
            getStartDateDayPosition()
            updateMonth()
            monthLabel.text = "\(currentMonth)"
            calendarCollection.reloadData()
        default:
            direction = 1

            getStartDateDayPosition()
            
            month += 1
            updateMonth()
            
            monthLabel.text = "\(currentMonth)"
            print(currentMonth)
            calendarCollection.reloadData()
        }

    }
    
    @IBAction func backMonth(_ sender: Any) {
        switch currentMonth {
        case "Janeiro":
            month = 11
            year -= 1
            direction = -1
            
            if leapYearCounter > 0 {
                leapYearCounter -= 1
            }
            
            if leapYearCounter == 0 {
                days[1] = 29
                leapYearCounter = 4
            } else {
                days[1] = 28
            }
            
            getStartDateDayPosition()
            updateMonth()
            monthLabel.text = "\(currentMonth)"
            calendarCollection.reloadData()
        default:
            month -= 1
            direction = -1
            
            getStartDateDayPosition()
            updateMonth()
            monthLabel.text = "\(currentMonth)"
            calendarCollection.reloadData()
        }

    }
    
    func getStartDateDayPosition() {
        switch direction {
        case 0:
            switch day {
            case 1...7:
                numberOfEmptyBox = weekday - day
            case 8...14:
                numberOfEmptyBox = weekday - day - 7
            case 15...21:
                numberOfEmptyBox = weekday - day - 14
            case 22...28:
                numberOfEmptyBox = weekday - day - 21
            case 29...31:
                numberOfEmptyBox = weekday - day - 28
            default:
                break
            }
        case 1...:
            nextNumberOfEmptyBox = (positionIndex + days[month])%7
            positionIndex = nextNumberOfEmptyBox
            
        case -1:
            PreviusNumberOfEmptyBox = (7 - (days[month] - positionIndex)%7)
            if PreviusNumberOfEmptyBox == 7 {
                PreviusNumberOfEmptyBox = 0
            }
            positionIndex = PreviusNumberOfEmptyBox
            
        default:
            fatalError()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateMonth()
        monthLabel.text = currentMonth

        setGradientBackGround()

        let tapTextFieldOne = UITapGestureRecognizer(target: self, action: #selector(selectTextFieldOne))
        tfFirstDay.addGestureRecognizer(tapTextFieldOne)

        let tapTextFieldTwo = UITapGestureRecognizer(target: self, action: #selector(selectTextFieldTwo))
        tfLastDay.addGestureRecognizer(tapTextFieldTwo)

        btnConfirm.layer.cornerRadius = btnConfirm.bounds.height / 2
    }

    func updateMonth() {
        currentMonth = months[month]
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch direction {
        case 0:
            return days[month] + numberOfEmptyBox
        case 1...:
            return days[month] + nextNumberOfEmptyBox
        case -1:
            return days[month] + PreviusNumberOfEmptyBox
        default:
            fatalError()
        }
        return days[month]
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarView", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = UIColor.clear
        
        cell.dayDateLabel.textColor = UIColor.white
        
        if cell.isHidden {
            cell.isHidden = false
        }
        switch direction {
        case 0:
            cell.dayDateLabel.text = "\(indexPath.row + 1 - numberOfEmptyBox)"
        case 1:
            cell.dayDateLabel.text = "\(indexPath.row + 1 - nextNumberOfEmptyBox)"
        case -1:
            cell.dayDateLabel.text = "\(indexPath.row + 1 - PreviusNumberOfEmptyBox)"
        default:
            fatalError()
        }
        
        if Int(cell.dayDateLabel.text!)! < 1 {
            cell.isHidden = true
        }
        
        switch indexPath.row {
        case 0,6,7,13,14,20,21,27,28,35,36:
            if Int(cell.dayDateLabel.text!)! > 0 {
                cell.dayDateLabel.textColor = UIColor.lightText
            }
        default:
            break
        }
        
        if currentMonth == months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day {
            cell.dayDateLabel.textColor = UIColor.yellow
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell

        if !firstDaySelected {

            if let firstSel = firstSelectedIndex {
                let firstCell = collectionView.cellForItem(at: firstSel) as? DateCollectionViewCell
                firstCell?.backgroundColor = UIColor.clear
                firstCell?.dayDateLabel.textColor = UIColor.white

                if currentMonth == months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && firstSel.row + 1 == day {
                    firstCell?.backgroundColor = UIColor.clear
                    firstCell?.dayDateLabel.textColor = UIColor.yellow
                }
            }
            if let secondSel = secondSelectedIndex {
                let secondCell = collectionView.cellForItem(at: secondSel) as? DateCollectionViewCell
                secondCell?.backgroundColor = UIColor.clear
                secondCell?.dayDateLabel.textColor = UIColor.white

                if currentMonth == months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && secondSel.row + 1 == day {
                    secondCell?.backgroundColor = UIColor.clear
                    secondCell?.dayDateLabel.textColor = UIColor.yellow
                }
            }

            tfFirstDay.text = nil
            tfLastDay.text = nil
            if let txt = cell?.dayDateLabel.text {
                tfFirstDay.text = "\(txt)-\(months[month])"
            }
            firstDaySelected = true
            firstSelectedIndex = indexPath
        } else {
            secondSelectedIndex = indexPath
            tfLastDay.text = nil
            if let txt = cell?.dayDateLabel.text {
                tfLastDay.text = "\(txt)-\( months[month])"
            }
        }

        cell?.backgroundColor = UIColor(named: "WhiteClear")
        cell?.dayDateLabel.textColor = UIColor.darkGray
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell

        if indexPath == firstSelectedIndex {
            cell?.backgroundColor = UIColor(named: "WhiteClear")
            cell?.dayDateLabel.textColor = UIColor.darkGray
        } else {

            if !firstDaySelected {
                cell?.backgroundColor = UIColor.clear
                cell?.dayDateLabel.textColor = UIColor.white

                if currentMonth == months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day {
                    cell?.backgroundColor = UIColor.clear
                    cell?.dayDateLabel.textColor = UIColor.yellow
                }

            } else {

                if tfLastDay.text == nil || tfLastDay.text!.isEmpty {
                    cell?.backgroundColor = UIColor(named: "WhiteClear")
                    cell?.dayDateLabel.textColor = UIColor.darkGray
                } else {
                    if let second = secondSelectedIndex {
                        let secondCell = collectionView.cellForItem(at: second) as? DateCollectionViewCell
                        secondCell?.backgroundColor = UIColor.clear
                        secondCell?.dayDateLabel.textColor = UIColor.white

                        if currentMonth == months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day {
                            cell?.backgroundColor = UIColor.clear
                            cell?.dayDateLabel.textColor = UIColor.yellow
                        }
                    }
                }
            }
        }

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

    @objc func selectTextFieldOne() {
        firstDaySelected = false
    }

    @objc func selectTextFieldTwo() {
        firstDaySelected = true
    }

}

extension FilterTripVC: UITextFieldDelegate {

    @IBAction func dismissKeyboard() {
        view.endEditing(true)
        tfFirstDay.endEditing(true)
        tfLastDay.endEditing(true)
        tfFirstDay.resignFirstResponder()
        tfLastDay.resignFirstResponder()
    }

    func configKeyboardObserver() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.calendarCollection.addGestureRecognizer(tap)

//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:.UIKeyboardWillShow , object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:.UIKeyboardWillHide , object: nil)

        tfFirstDay.delegate = self
        tfLastDay.delegate = self
    }

//    @objc func keyboardWillShow(notification:NSNotification){
//        var userInfo = notification.userInfo!
//        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
//        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
//
//        var contentInset:UIEdgeInsets = self.view.contentInset
//        contentInset.bottom = keyboardFrame.size.height
//        view.contentInset = contentInset
//    }
//
//    @objc func keyboardWillHide(notification:NSNotification){
//        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
//        view.contentInset = contentInset
//    }
}









