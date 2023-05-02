//
//  Author.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 01/05/2023.
//

struct Author: Codable {
    var id: String
    var name: String
    var recipes: [Recipe] = []
}
