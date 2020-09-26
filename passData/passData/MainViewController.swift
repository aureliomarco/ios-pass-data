//
//  ViewController.swift
//  passData
//
//  Created by Marco Aurelio on 26/09/20.
//  Copyright © 2020 coda. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, PizzaDelegate {
    func onPizzaReady(type: String) -> String {
        return "The Pizza of \(type) is coming"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func goToPizzaPage(_ sender: Any) {
        let pizzaVC = PizzaViewController()
        present(pizzaVC, animated: true, completion: nil)
    }
    
    @IBAction func goToWine(_ sender: Any) {
        let wineVC = WineViewController()
        wineVC.pizzaDelegate = self
        present(wineVC, animated: true, completion: nil)
    }
}
