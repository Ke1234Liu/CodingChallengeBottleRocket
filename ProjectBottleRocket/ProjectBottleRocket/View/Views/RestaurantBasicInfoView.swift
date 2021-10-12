//
//  RestaurantBasicInfoView.swift
//  ProjectBottleRocket
//
//  Created by Ke on 10/12/21.
//

import UIKit

class RestaurantBasicInfoView: UIView {

    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        let attr = [NSAttributedString.Key.font: UIFont.avenirBold(for: 16) as Any, NSAttributedString.Key.foregroundColor: UIColor.white]
        label.attributedText = NSAttributedString(string: self.name, attributes: attr)
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        let attr = [NSAttributedString.Key.font: UIFont.avenirRegular(for: 12) as Any, NSAttributedString.Key.foregroundColor: UIColor.white]
        label.attributedText = NSAttributedString(string: self.category, attributes: attr)
        return label
    }()
    
    private let name: String
    private let category: String
    
    init(name: String, category: String) {
        self.name = name
        self.category = category
        super.init(frame: .zero)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not found")
    }
    
    private func setUp() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .restaurantGreen
        let stackView = UIStackView(axis: .vertical, spacing: 6)
        stackView.addArrangedSubview(self.nameLabel)
        stackView.addArrangedSubview(self.categoryLabel)
        self.addSubview(stackView)
        stackView.boundToSuperView(insets: UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12))
    }
    
}

