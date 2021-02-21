//
//  Group.swift
//  UI_Project
//
//  Created by  Shisetsu on 18.02.2021.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let group = try? newJSONDecoder().decode(Group.self, from: jsonData)

import Foundation

// MARK: - Group
struct Group: Codable {
    let response: Response2
}

// MARK: - Response
struct Response2: Codable {
//    let count: Int
    let items: [Groups]
}

// MARK: - Item
struct Groups: Codable {
    //let id: Int
    let name: String
    //let isClosed: Int
    //let type: TypeEnum
    //let isAdmin, isMember, isAdvertiser: Int
    let photo: String

    enum CodingKeys: String, CodingKey {
        case name
        //case screenName = "screen_name"
        //case isClosed = "is_closed"
        //case type
        //case isAdmin = "is_admin"
        //case isMember = "is_member"
        //case isAdvertiser = "is_advertiser"
        case photo = "photo_100"
        //case photo100 = "photo_100"
        //case photo200 = "photo_200"
    }
}

//enum TypeEnum: String, Codable {
//    case group = "group"
//    case page = "page"
//}
