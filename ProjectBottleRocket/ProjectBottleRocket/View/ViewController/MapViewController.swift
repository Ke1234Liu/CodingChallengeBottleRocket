//
//  MapViewController.swift
//  ProjectBottleRocket
//
//  Created by Ke on 10/12/21.
//

import UIKit

class MapViewController: UIViewController {
    
    private lazy var mapView: MapView = {
        let mapView = MapView(latitudes: self.mainVM.allLatitudes(), longitudes: self.mainVM.allLatitudes(), titles: self.mainVM.allFormattedMapAnnotationTitle())
        return mapView
    }()
    
    private let mainVM: RestaurantsViewModel
    
    init(mainVM: RestaurantsViewModel) {
        self.mainVM = mainVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    private func setUpUI() {
        self.view.addSubview(self.mapView)
        self.mapView.boundToSuperView(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    }
}
