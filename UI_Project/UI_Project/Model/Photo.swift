//
//  Photo.swift
//  UI_Project
//
//  Created by  Shisetsu on 20.02.2021.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let photo = try? newJSONDecoder().decode(Photo.self, from: jsonData)

// MARK: - Photo
struct Photo: Codable {
    let response: Response3
}

// MARK: - Response
struct Response3: Codable {
    let count: Int
    let items: [Item3]
}

// MARK: - Item
struct Item3: Codable {
//    let albumID, date, id, ownerID: Int
//    let hasTags: Bool
//    let postID: Int?
    let sizes: [Size]
//    let text: String

//    enum CodingKeys: String, CodingKey {
////        case albumID = "album_id"
////        case date, id
////        case ownerID = "owner_id"
////        case hasTags = "has_tags"
////        case postID = "post_id"
//        case sizes//, text
//    }
}

// MARK: - Size
struct Size: Codable {
//    let height: Int
    let url: String
//    let type: String
//    let width: Int
}
