//
//  ListTripsTVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 10/06/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit

class ListTripsTVC: UITableViewController {

    var tripList = [TripsDAO] ()
    var typeList: GlobalConstants.SegueIdentifier.TypeTripsList = .SAVED
    @IBOutlet var userVM: UserViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        switch typeList {
        case .SAVED:
            tripList = UserViewModel.savedTrips()
        case .MYTRIP:
            self.tripList = userVM.myTrips()
            self.tableView.reloadData()
        case .CONFIRMED:
            self.tripList = UserViewModel.confirmedTrips()
        }
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripList.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! CustomSavedTVCell
        cell.lblNomeTrip.text = tripList[indexPath.row].nome
        cell.lblDataTrip.text = tripList[indexPath.row].data
        cell.btnConfirmar.layer.cornerRadius = 20
        cell.btnConfirmar.layer.borderWidth = 2
        cell.btnConfirmar.layer.borderColor = UIColor.orange.cgColor
        if let category = tripList[indexPath.row].tipoEvento {
            cell.imgCategoria.image = getImgCategory(category)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = tripList[indexPath.row]
        performSegue(withIdentifier: "tripDetails", sender: item)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailTripVC {
            if let tripDao = sender as? TripsDAO {
                let trip = Trip(tripDao: tripDao)
                detailVC.tripViewModel = TripViewModel(trip: trip)
            }

        }
    }
    func getImgCategory(_ category: String) -> UIImage? {

        if category == "Beer" {
            return UIImage(named: ConstantsNamedImages.categoryBeer)
        }
        if category == "Adventure" {
            return UIImage(named: ConstantsNamedImages.categoryAdventure)
        }
        if category == "Beach" {
            return UIImage(named: ConstantsNamedImages.categoryBeach)
        }
        if category == "Party" {
            return UIImage(named: ConstantsNamedImages.categoryParty)
        } else {
            return UIImage(named: ConstantsNamedImages.categoryAdventure)
        }
    }
}
