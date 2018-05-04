//
//  ProtocolView.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 30/04/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation

protocol ProtocolView {
    func setupView()
    func keyboardWillShow(notification: NSNotification)
    func keyboardWillHide(notification: NSNotification)
    func dismissKeyboard()
}
