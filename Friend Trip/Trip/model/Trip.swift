//
//  Trip.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 18/03/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit

class Trip: NSObject {

    let nome: String
    let local: String
    let data: String
    let tipoEvento: String

    init(nome: String, local: String, data: String, tipoEvento: String) {
        self.nome = nome
        self.local = local
        self.data = data
        self.tipoEvento = tipoEvento
    }

    override var description: String {
        return "\(nome), \(local), \(data), \(tipoEvento)"
    }
}
