//
//  V_Recipe.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 01/05/2023.
//

import UIKit

class V_Recipe: UIView {
        
    static func createRecipeView(recipe: Recipe) -> UIView {
        let cardContainer = UIView()
        cardContainer.backgroundColor = .white
        cardContainer.layer.cornerRadius = 8
        cardContainer.layer.shadowColor = UIColor.black.cgColor
        cardContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardContainer.layer.shadowOpacity = 0.25
        cardContainer.layer.shadowRadius = 4
        cardContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let recipeTitle = UILabel()
        recipeTitle.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        recipeTitle.textColor = .black
        recipeTitle.text = recipe.name
        recipeTitle.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(recipeTitle)
        
        let recipeBy = UILabel()
        recipeBy.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        recipeBy.textColor = .black
        recipeBy.text = "By: " + recipe.author_id
        recipeBy.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(recipeBy)
        
        let recipePrepTime = UILabel()
        recipePrepTime.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        recipePrepTime.textColor = .black
        recipePrepTime.text = "Prep time: " + recipe.prepTime.description + " mins"
        recipePrepTime.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(recipePrepTime)
        
        let recipeCookTime = UILabel()
        recipeCookTime.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        recipeCookTime.textColor = .black
        recipeCookTime.text = "Cook time: " + recipe.cookTime.description + " mins"
        recipeCookTime.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(recipeCookTime)
        
        let viewsDictionary = ["recipeTitle": recipeTitle, "recipeBy": recipeBy, "recipePrepTime": recipePrepTime, "recipeCookTime": recipeCookTime]
        
        cardContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[recipeTitle]-[recipeBy]-[recipePrepTime]-[recipeCookTime]-|", options: [], metrics: nil, views: viewsDictionary))
        cardContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[recipeTitle]-|", options: [], metrics: nil, views: viewsDictionary))
        cardContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[recipeBy]-|", options: [], metrics: nil, views: viewsDictionary))
        cardContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[recipePrepTime]-|", options: [], metrics: nil, views: viewsDictionary))
        cardContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[recipeCookTime]-|", options: [], metrics: nil, views: viewsDictionary))
        
        return cardContainer
    }

}
