//
//  User.swift
//  UI_Project
//
//  Created by  Shisetsu on 16.02.2021.

import Foundation

// MARK: - User
struct User: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
//    let count: Int
    let items: [Users]
}

// MARK: - Item
struct Users: Codable {
    
    let firstName: String
    let id: Int
    let lastName: String
//    let canAccessClosed, isClosed: Bool
    let sex: Int
    let photo: String
    let online: Int
//    let nickname: String
    let bdate: String?
    let city: City?
//    let trackCode: String
//    let onlineMobile, onlineApp: Int?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
//        case canAccessClosed = "can_access_closed"
//        case isClosed = "is_closed"
        case sex
        case photo = "photo_100"
        case online, bdate, city
//        case trackCode = "track_code"
//        case onlineMobile = "online_mobile"
//        case onlineApp = "online_app"
    }
}

// MARK: - City
struct City: Codable {
    //let id: Int
    let title: String
}
