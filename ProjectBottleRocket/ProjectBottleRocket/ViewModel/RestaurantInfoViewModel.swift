//
//  RestaurantInfoViewModel.swift
//  ProjectBottleRocket
//
//  Created by Ke on 10/12/21.
//

import Foundation

class RestaurantInfoViewModel {
    
    internal let model: Restaurant
    private let service: NetworkServiceApi
    
    init(restaurant: Restaurant, service: NetworkServiceApi) {
        self.model = restaurant
        self.service = service
    }
    
    var name: String {
        return self.model.name
    }
        
    var category: String {
        return self.model.category
    }
        
    var formattedAddress: String {
        let charArrayAddress = self.model.location.formattedAddress.flatMap{
            "\($0)\n"
        }.dropLast()
        return String(charArrayAddress)
    }
        
    var formattedTelephone: String {
        return self.model.contact?.formattedPhone ?? "Contact not found"
    }
    
    var socialMediaHandle: String {
        guard let socialMedia = self.model.contact?.twitter else { return "Twitter Unavailable" }
        return "@\(socialMedia)"
    }
    
    var latitude: Double {
        return self.model.location.lat
    }
    
    var longitude: Double {
        return self.model.location.lng
    }
    
    var formattedMapAnnotationTitle: String {
        return "\(self.model.name)\n\(self.model.location.city), \(self.model.location.state)"
    }
    
    func imageData(completion: @escaping (Data?) -> Void) {
        if let imageData = ImageCache.shared.getImageData(for: self.model.backgroundImageURL) {
            completion(imageData)
            return
        }
        
        self.service.fetchRawData(url: URL(string: self.model.backgroundImageURL)) { [weak self] (result) in
            switch result {
            case .success(let data):
                ImageCache.shared.setImageData(for: self?.model.backgroundImageURL, imageData: data)
                completion(data)
            case .failure(let err):
                print(err)
                completion(nil)
            }
        }
    }

}

