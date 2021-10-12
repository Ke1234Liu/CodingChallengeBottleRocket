//
//  ErrorMessage.swift
//  ProjectBottleRocket
//
//  Created by Ke on 10/12/21.
//

import Foundation

enum ErrorMessage: Error {
    case badURL
    case badData
    case decodingFailed
    case badStatusCode(Int)
}

extension ErrorMessage: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return NSLocalizedString("Bad URL", comment: "Bad URL")
        case .badData:
            return NSLocalizedString("Bad Data", comment: "Bad Data")
        case .decodingFailed:
            return NSLocalizedString("Decoding Failed", comment: "Decoding Failed")
        case .badStatusCode(let code):
            return NSLocalizedString("The network connection was improper. Received Status code \(code)", comment: "Bad Status Code")
        }
    }
}
