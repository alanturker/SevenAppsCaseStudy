//
//  SaError.swift
//  SevenAppsCaseStudy
//
//  Created by Turker Alan on 29.01.2025.
//

import Foundation

enum SaError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
    var description: String {
        switch self {
        case .invalidURL:
            "Invalid URL. Please contact support."
        case .invalidResponse:
            "Invalid Response from the server. Please try again later or contact support."
        case .invalidData:
            "Invalid Data, can not parse JSON. If this persists, please contact support."
        }
    }
}
