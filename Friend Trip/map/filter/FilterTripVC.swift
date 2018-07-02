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
    let days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    var currentMonth = String()

    @IBOutlet weak var monthLabel: UILabel!


    @IBAction func nextMonth(_ sender: Any) {
        switch currentMonth {
        case "Dezembro":
            month = 0
            year += 1
            updateMonth()
            monthLabel.text = "\(currentMonth)"
            calendarCollection.reloadData()
        default:
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
            updateMonth()
            monthLabel.text = "\(currentMonth)"
            calendarCollection.reloadData()
        default:
            month -= 1
            updateMonth()
            monthLabel.text = "\(currentMonth)"
            calendarCollection.reloadData()
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
        return days[month]
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarView", for: indexPath) as! DateCollectionViewCell
        cell.dayDateLabel.text = "\(indexPath.row + 1)"
        return cell
    }

}
