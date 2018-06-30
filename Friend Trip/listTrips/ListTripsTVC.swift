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

    }

    override func viewWillAppear(_ animated: Bool) {
        switch typeList {
        case .SAVED:
            navigationItem.title = "Trips Salvas"
            tripList = UserViewModel.savedTrips()
            self.tableView.reloadData()
        case .MYTRIP:
            navigationItem.title = "Minhas Trips"
            self.tripList = userVM.myTrips()
            self.tableView.reloadData()
        case .CONFIRMED:
            navigationItem.title = "Trips Confirmadas"
            self.tripList = UserViewModel.confirmedTrips()
            self.tableView.reloadData()
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
        let trip = Trip(tripDao: tripList[indexPath.row])
        let tripVM = TripViewModel(trip: trip)

        cell.lblNomeTrip.text = tripVM.nameTrip
        cell.lblDataTrip.text = tripVM.getHourTrip()
        cell.lblDayTrip.text = tripVM.getDayTrip()
        cell.lblMonthTrip.text = tripVM.getMothTrip()
        cell.cellDelegate = self
        cell.tag = indexPath.row
        cell.btnConfirmar.tag = indexPath.row
        cell.btnSaveTrip.tag = indexPath.row

        if let category = tripList[indexPath.row].tipoEvento {
            cell.imgCategoria.image = UIImageCategory.getImgCategory(category) 
        }

        if tripVM.isConfirmed() {
            cell.btnConfirmar.isEnabled = false
            cell.btnConfirmar.setTitle("Confirmado", for: .normal)
        }

        if tripVM.isSaved() {
            cell.btnSaveTrip.isEnabled = false
            cell.btnSaveTrip.setTitle("Salvo", for: .normal)
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
}

extension ListTripsTVC: CellButtonProtocol {
    func didTapButtonCell(_ tag: Int) {
        let trip = Trip(tripDao: tripList[tag])
        let tripVM = TripViewModel(trip: trip)
        tripVM.setStatus("confirmed")
        tableView.reloadData()
    }

    func didTapSavedButtonCell(_ tag: Int) {
        let trip = Trip(tripDao: tripList[tag])
        let tripVM = TripViewModel(trip: trip)
        tripVM.saveTrip()
        tableView.reloadData()
    }
}






