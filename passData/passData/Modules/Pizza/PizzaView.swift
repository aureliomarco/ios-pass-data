//
//  PizzaView.swift
//  passData
//
//  Created by Marco Aurelio on 26/09/20.
//  Copyright © 2020 coda. All rights reserved.
//

import UIKit

class PizzaView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
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
    
    private var pizzaImage: UIImageView = {
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
    
    private func setupView() {
        backgroundColor = .white
        
        viewBody.addSubviews([pizzaImage,
                              title])
        scrollView.addSubviews([viewBody])
        
        addSubviews([scrollView])
        
        setupAnchors()
        fetchData()
    }
    
    private func setupAnchors() {
        scrollView
            .edgeToSuperView()
        
        viewBody
            .topToSuperview()
            .bottomToSuperview()
            .centerX(of: self)
            .widthEqual(of: scrollView)
        
        pizzaImage
            .topToSuperview(margin: 0)
            .leadingToSuperview(margin: 0)
            .trailingToSuperview(margin: 0)
            .height(250)
        
        title
            .topToBottom(of: pizzaImage, margin: 8)
            .leadingToSuperview(margin: 16)
            .trailingToSuperview(margin: 16)
            .bottomToSuperview(margin: 10, relation: .greaterThanOrEqual)
    }
    
    func fetchData() {
        DispatchQueue.main.async {
            self.pizzaImage.loadImageWith(url: "https://massafinna.com.br/wp-content/uploads/2018/11/Romana.jpg")
            self.title.text = "Gino Sorbilla ai Tribunali"
        }
    }
}
