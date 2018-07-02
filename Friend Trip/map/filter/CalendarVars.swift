//
//  CalendarVars.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 01/07/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation
let date = Date()
let calendar = Calendar.current

var day = calendar.component(.day, from: date)
var weekday = calendar.component(.weekday, from: date)
var month = calendar.component(.month, from: date)-1
var year = calendar.component(.year, from: date)

