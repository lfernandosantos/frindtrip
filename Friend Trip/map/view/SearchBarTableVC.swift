//
//  SearchBarTableVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 06/05/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import MapKit

class SearchBarTableVC: UITableViewController {

    var machingItems: [MKMapItem] = []
    var mapView: MKMapView?
    var handleMapSearchDelegate: HandleMapSearch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return machingItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = machingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = machingItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropZoomIn(coordinate: selectedItem.coordinate)
        handleMapSearchDelegate?.setMKPlacemark(mkPlacemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }
}

extension SearchBarTableVC {

    func parseAddress(selectedItem: MKPlacemark) -> String {
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil ) ? " " : " "
        let coma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil ) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? "," : " "

        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " ": " "
        let addressLine = String(format: "%@%@%@%@%@%@%@", selectedItem.subThoroughfare ?? "", firstSpace, selectedItem.thoroughfare ?? "",
                                 coma, selectedItem.locality ?? "", secondSpace, selectedItem.administrativeArea ?? "")
        return addressLine
    }
}

extension SearchBarTableVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView, let searchBarText = searchController.searchBar.text else {
            print("Erro no mapa, search")
            return
        }

        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region

        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {response, error in
            guard let response = response else {
                print("erro response: \(error)")
                return
            }
            self.machingItems = response.mapItems
            self.tableView.reloadData()
        })
    }
}
