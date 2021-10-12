//
//  RestaurantInfoViewController.swift
//  ProjectBottleRocket
//
//  Created by Ke on 10/12/21.
//

import UIKit

class RestaurantInfoViewController: UIViewController {
    private lazy var restaurantMapView: MapView = {
        let mapView = MapView(latitudes: [self.restaurantInfoViewModel.latitude], longitudes: [self.restaurantInfoViewModel.longitude], titles: [self.restaurantInfoViewModel.formattedMapAnnotationTitle])
        mapView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        return mapView
    }()
    
    private lazy var basicInfoView: RestaurantBasicInfoView = {
        let infoView = RestaurantBasicInfoView(name: self.restaurantInfoViewModel.name, category: self.restaurantInfoViewModel.category)
        infoView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        return infoView
    }()
    
    private lazy var contactInfoView: RestaurantContactInfoView = {
        let contactView = RestaurantContactInfoView(address: self.restaurantInfoViewModel.formattedAddress, phone: self.restaurantInfoViewModel.formattedTelephone, twitter: self.restaurantInfoViewModel.socialMediaHandle)
        return contactView
    }()
    
    init?(restaurantDetailViewModel: RestaurantInfoViewModel?) {
        guard let restVM = restaurantDetailViewModel else { return nil }
        self.restaurantInfoViewModel = restVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not found")
    }
    private let restaurantInfoViewModel: RestaurantInfoViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    private func setUpUI() {
        let stackView = UIStackView(axis: .vertical)
        stackView.addArrangedSubview(self.restaurantMapView)
        stackView.addArrangedSubview(self.basicInfoView)
        stackView.addArrangedSubview(self.contactInfoView)
        self.view.addSubview(stackView)
        stackView.boundToSuperView()
    }
}
