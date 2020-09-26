//
//  PizzaDelegate.swift
//  passData
//
//  Created by Marco Aurelio on 26/09/20.
//  Copyright © 2020 coda. All rights reserved.
//

import Foundation

protocol PizzaDelegate {
    func onPizzaReady(type: String) -> String
}
