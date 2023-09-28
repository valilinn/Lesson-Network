//
//  PostModel.swift
//  Networking
//
//  Created by Валентина Лінчук on 27/09/2023.
//

import Foundation

class Post: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
    init(usetId: Int, title: String, body: String) {
        self.title = title
        self.body = body
        self.userId = usetId
        self.id = 0
    }
}
