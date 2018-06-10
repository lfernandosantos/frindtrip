//
//  Trips+CoreDataProperties.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 09/06/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//
//

import Foundation
import CoreData


extension TripsDAO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TripsDAO> {
        return NSFetchRequest<TripsDAO>(entityName: "Trips")
    }

    @NSManaged public var data: String?
    @NSManaged public var id: Int32
    @NSManaged public var nome: String?
    @NSManaged public var participantes: Int16
    @NSManaged public var tipoEvento: String?

}