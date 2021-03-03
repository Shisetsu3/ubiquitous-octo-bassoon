//
//  userPhotos.swift
//  UI_Project
//
//  Created by  Shisetsu on 02.03.2021.
//

import Foundation
import RealmSwift

class userPhotos: Object, Decodable {
    @objc dynamic var ownerID = 0
    @objc dynamic var url = ""
    
    override static func primaryKey() -> String? {
        return "ownerID"
    }
}
