//
//  WineViewController.swift
//  passData
//
//  Created by Marco Aurelio on 26/09/20.
//  Copyright © 2020 coda. All rights reserved.
//

import UIKit

class WineViewController: UIViewController {
    private var wineView: WineView?
    var pizzaDelegate: PizzaDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        wineView = WineView(frame: view.frame)
        view = wineView
        
        wineView?.pizzaDelegate = pizzaDelegate
    }
}
