//
//  WineView.swift
//  passData
//
//  Created by Marco Aurelio on 26/09/20.
//  Copyright © 2020 coda. All rights reserved.
//

import UIKit

class WineView: UIView {
    
    var pizzaDelegate: PizzaDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        loadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewBody = UIView()
    
    private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.bounces = false
        return scroll
    }()
    
    private var wineImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = UIView.ContentMode.scaleAspectFill
        image.debugLayoutFormat()
        return image
    }()
    
    private var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.medium)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.debugLayoutFormat()
        return label
    }()
    
    private var pizzaTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Insert the flavor of the Pizza"
        textField.font = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.light)
        return textField
    }()
    
    private var updateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Order", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(updateOrder), for: .touchUpInside)
        button.debugLayoutFormat()
        return button
    }()
    
    private var statusOrderMessage: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.medium)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.debugLayoutFormat()
        return label
    }()
    
    private func setupView() {
        backgroundColor = .white
        
        viewBody.addSubviews([
            wineImage,
            title,
            pizzaTextField,
            updateButton,
            statusOrderMessage
        ])
        scrollView.addSubviews([viewBody])
        
        addSubviews([scrollView])
        
        setupAnchors()
    }
    
    private func setupAnchors() {
        scrollView
            .edgeToSuperView()
        
        viewBody
            .topToSuperview()
            .bottomToSuperview()
            .centerX(of: self)
            .widthEqual(of: scrollView)
        
        wineImage
            .topToSuperview(margin: 0)
            .leadingToSuperview(margin: 0)
            .trailingToSuperview(margin: 0)
            .height(250)
        
        title
            .topToBottom(of: wineImage, margin: 8)
            .leadingToSuperview(margin: 16)
            .trailingToSuperview(margin: 16)
        
        pizzaTextField
            .topToBottom(of: title, margin: 8)
            .leadingToSuperview(margin: 16)
            .trailingToSuperview(margin: 16)
            .height(30)
        
        updateButton
            .topToBottom(of: pizzaTextField, margin: 8)
            .leadingToSuperview(margin: 16)
            .trailingToSuperview(margin: 16)
        
        statusOrderMessage
            .topToBottom(of: updateButton, margin: 8)
            .leadingToSuperview(margin: 16)
            .trailingToSuperview(margin: 16)
            .bottomToSuperview(margin: 10, relation: .greaterThanOrEqual)
    }
    
    func loadData() {
        wineImage.loadImageWith(url: "https://res.klook.com/images/fl_lossy.progressive,q_65/c_fill,w_1200,h_630,f_auto/w_80,x_15,y_15,g_south_west,l_klook_water/activities/bhljtpbxidjnjgijta5q/Yarra%20Valley%20Wine%20Tour%20from%20Melbourne.jpg")
        title.text = "PAYS DE VAUCLUSE 2017 \nChoose a Pizza to go along with the Wine: "
        statusOrderMessage.text = "Order Status: "
    }
    
    @objc func updateOrder() {
        let statusOrder = pizzaDelegate?.onPizzaReady(type: pizzaTextField.text ?? "") ?? ""
        statusOrderMessage.text = "Order Status: \(statusOrder)"
    }
}
