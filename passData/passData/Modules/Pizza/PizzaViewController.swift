//
//  PizzaViewController.swift
//  passData
//
//  Created by Marco Aurelio on 26/09/20.
//  Copyright © 2020 coda. All rights reserved.
//

import UIKit

class PizzaViewController: UIViewController {
    private var pizzaView: PizzaView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        pizzaView = PizzaView(frame: view.frame)
        view = pizzaView
    }
}
