//
//  UserModel.swift
//  SevenAppsCaseStudy
//
//  Created by Turker Alan on 29.01.2025.
//

import Foundation

// MARK: - User
struct User: Decodable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

// MARK: - Address
struct Address: Decodable {
    let street, suite, city, zipcode: String
}

// MARK: - Company
struct Company: Decodable {
    let name, catchPhrase, bs: String
}

typealias UserContainer = [User]
