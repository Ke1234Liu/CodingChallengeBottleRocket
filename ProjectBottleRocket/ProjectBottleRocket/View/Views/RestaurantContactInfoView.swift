//
//  RestaurantContactInfoView.swift
//  ProjectBottleRocket
//
//  Created by Ke on 10/12/21.
//

import UIKit

class RestaurantContactInfoView: UIView {

    private lazy var addressLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        let attr = [NSAttributedString.Key.font: UIFont.avenirRegular(for: 16) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]
        label.attributedText = NSAttributedString(string: self.address, attributes: attr)
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        let attr = [NSAttributedString.Key.font: UIFont.avenirRegular(for: 16) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]
        label.attributedText = NSAttributedString(string: self.phone, attributes: attr)
        return label
    }()
    
    private lazy var twitterLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        let attr = [NSAttributedString.Key.font: UIFont.avenirRegular(for: 16) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]
        label.attributedText = NSAttributedString(string: self.twitter, attributes: attr)
        return label
    }()
    
    private let address: String
    private let phone: String
    private let twitter: String
    
    init(address: String, phone: String, twitter: String) {
        self.address = address
        self.phone = phone
        self.twitter = twitter
        super.init(frame: .zero)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not found")
    }
    
    private func setUp() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        let stackview = UIStackView(axis: .vertical, spacing: 26)
        stackview.addArrangedSubview(self.addressLabel)
        stackview.addArrangedSubview(self.phoneLabel)
        stackview.addArrangedSubview(self.twitterLabel)
        stackview.addArrangedSubview(UIView.createBufferView())
        self.addSubview(stackview)
        stackview.boundToSuperView(insets: UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12))
    }
    
}

