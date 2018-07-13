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

    @IBOutlet weak var monthLabel: UILabel!


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
        currentMonth = months[month]
        monthLabel.text = currentMonth

        print(currentMonth)
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
        
        cell.dayDateLabel.textColor = UIColor.black
        
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
                cell.dayDateLabel.textColor = UIColor.lightGray
            }
        default:
            break
        }
        
        if currentMonth == months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day {
            cell.backgroundColor = UIColor.red
        }
        return cell
    }

}









