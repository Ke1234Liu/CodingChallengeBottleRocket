//
//  MockNetworking.swift
//  ProjectBottleRocket
//
//  Created by Ke Liu on 5/21/24.
//

import Foundation

class MockSession: Session {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func getData(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completion(data, response, error)
    }
}
