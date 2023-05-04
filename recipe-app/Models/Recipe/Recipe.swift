//
//  Recipe.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 01/05/2023.
//
import UIKit

struct Recipe : Codable {
    var id: String
    var name: String
    var author_name: String
    var image_url: String
    var recipe_yield: String
    var prepTime: String
    var cookTime: String
    var ingredients: [[String: [String]]]
    var instructions: [String]
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case author_name
        case image_url
        case prepTime
        case cookTime
        case ingredients
        case instructions
        case recipe_yield
    }
    
}
