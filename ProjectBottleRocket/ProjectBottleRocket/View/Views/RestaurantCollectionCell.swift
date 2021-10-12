//
//  RestaurantCollectionCell.swift
//  ProjectBottleRocket
//
//  Created by Ke on 10/12/21.
//

import UIKit

class RestaurantCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = "\(RestaurantCollectionCell.self)"
        
    private lazy var gradientLeft: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        self.restaurantImageView.layer.addSublayer(gradient)
        return gradient
    }()
    
    private lazy var gradientRight: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        self.restaurantImageView.layer.addSublayer(gradient)
        return gradient
    }()
    
    private lazy var gradientBottom: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        self.restaurantImageView.layer.addSublayer(gradient)
        return gradient
    }()
    
    private lazy var restaurantImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        self.contentView.addSubview(imageView)
        imageView.boundToSuperView()
        
        return imageView
    }()
    
    private lazy var restaurantNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var restaurantCategoryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        return label
    }()
    
    private var detailViewModel: RestaurantInfoViewModel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not found")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLeft.frame = CGRect(x: 0, y: 0, width: self.contentView.layer.frame.width / 2, height: self.contentView.layer.frame.height)
        self.gradientRight.frame = CGRect(x: self.contentView.layer.frame.midX, y: 0, width: self.contentView.layer.frame.width / 2, height: self.contentView.layer.frame.height)
        self.gradientBottom.frame = self.contentView.layer.frame
    }
    
    private func setUpUI() {
        self.restaurantCategoryLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12).isActive = true
        self.restaurantCategoryLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12).isActive = true
        self.restaurantCategoryLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6).isActive = true
        self.restaurantNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12).isActive = true
        self.restaurantNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12).isActive = true
        self.restaurantNameLabel.bottomAnchor.constraint(equalTo: self.restaurantCategoryLabel.topAnchor, constant: -6).isActive = true
    }
    
    func configure(with viewModel: RestaurantInfoViewModel?) {
        guard let viewModel = viewModel else { return }
        
        self.detailViewModel = viewModel
        let nameAttributes = [NSAttributedString.Key.font: UIFont.avenirBold(for: 16) as Any, NSAttributedString.Key.foregroundColor: UIColor.white]
        self.restaurantNameLabel.attributedText = NSAttributedString(string: viewModel.name, attributes: nameAttributes)
        let categoryAttributes = [NSAttributedString.Key.font: UIFont.avenirRegular(for: 12) as Any, NSAttributedString.Key.foregroundColor: UIColor.white]
        self.restaurantCategoryLabel.attributedText = NSAttributedString(string: viewModel.category, attributes: categoryAttributes)
        viewModel.imageData { [weak self] (data) in
            if let data = data, let image = UIImage(data: data), let self = self {
                DispatchQueue.main.async {
                    self.restaurantImageView.image = image
                    self.contentView.bringSubviewToFront(self.restaurantNameLabel)
                    self.contentView.bringSubviewToFront(self.restaurantCategoryLabel)
                }
            }
        }
        
    }
    
}

