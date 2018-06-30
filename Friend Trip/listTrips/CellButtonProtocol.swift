//
//  CellButtonProtocol.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 19/06/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation
import UIKit

protocol CellButtonProtocol: class {
    func didTapButtonCell(_ tag: Int)
    func didTapSavedButtonCell(_ tag: Int)
}
