//
//  Recipe.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 01/05/2023.
//

struct Recipe : Codable {
    var id: String
    var name: String
    var author_id: String
    var prepTime: String
    var cookTime: String
    var ingredients: [[String: [String]]]
    var instructions: [String]
}
