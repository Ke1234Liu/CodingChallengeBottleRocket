//
//  RestaurantsViewModel.swift
//  ProjectBottleRocket
//
//  Created by Ke on 10/12/21.
//

import Foundation

class RestaurantsViewModel {
    private var restaurants: [RestaurantInfoViewModel] = [] {
        didSet {
            self.updateHandler?()
        }
    }
    private let service: NetworkServiceApi
    
    private var updateHandler: (() -> Void)?
    private var errorHandler: ((Error) -> Void)?
    
    init(service: NetworkServiceApi = NetworkManager()) {
        self.service = service
    }

    func bind(updateHandler: @escaping () -> Void, errHandler: @escaping (Error) -> Void) {
        self.updateHandler = updateHandler
        self.errorHandler = errHandler
    }
    func launchRestaurants() {
        let lunchdata = "https://s3.amazonaws.com/br-codingexams/restaurants.json"
        self.service.fetchDecodableData(url: URL(string: lunchdata)) { [weak self] (result: Result<RestaurantData, Error>) in
            guard let self = self else {return}
            switch result {
            case .success(let res):
                var detailVMArr: [RestaurantInfoViewModel] = []
                for element in res.restaurants {
                    detailVMArr.append(RestaurantInfoViewModel(restaurant: element, service: self.service))
                }
                self.restaurants = detailVMArr
            case .failure(let err):
                self.errorHandler?(err)
            }
        }
    }
    
    var count: Int {
        return self.restaurants.count
    }

    func restaurantDetailViewModel(for index: Int) -> RestaurantInfoViewModel? {
        guard index < self.restaurants.count else { return nil }
        return self.restaurants[index]
    }
    
    func allLatitudes() -> [Double] {
        var latitudes: [Double] = []
        for index in 0..<self.restaurants.count {
            if let lat = self.restaurantDetailViewModel(for: index)?.latitude {
                latitudes.append(lat)
            }
        }
        return latitudes

    }

    func allLongitudes() -> [Double] {
        var longitudes: [Double] = []
        for index in 0..<self.restaurants.count {
            if let lng = self.restaurantDetailViewModel(for: index)?.longitude {
                longitudes.append(lng)
            }
        }
        return longitudes
    }

    func allFormattedMapAnnotationTitle() -> [String] {
        var titles: [String] = []
        for index in 0..<self.restaurants.count {
            if let title = self.restaurantDetailViewModel(for: index)?.formattedMapAnnotationTitle {
                titles.append(title)
            }
        }
        return titles
    }

}
