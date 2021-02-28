//
//  Photo.swift
//  UI_Project
//
//  Created by  Shisetsu on 20.02.2021.

import Foundation
import RealmSwift

// MARK: - Photo
class Photo: Codable {
    var response: Response3
}

// MARK: - Response
class Response3: Codable {
    var items: [Item3]
}

// MARK: - Item
class Item3: Codable {
    var sizes: [Size]
}

// MARK: - Size
class Size: Object, Codable {
    @objc dynamic var url = ""
    
    override static func primaryKey() -> String? {
        return "url"
    }
}





