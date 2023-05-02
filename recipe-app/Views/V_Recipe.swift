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

        let recipeImageView = UIImageView(image: recipe.image)
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(recipeImageView)
        
        let recipeTitle = UILabel()
        recipeTitle.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        recipeTitle.textColor = .black
        recipeTitle.text = recipe.name
        recipeTitle.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(recipeTitle)
        
        let recipeBy = UILabel()
        recipeBy.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        recipeBy.textColor = .black
        recipeBy.text = "By: " + recipe.author_name
        recipeBy.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(recipeBy)
        
        let recipePrepTime = UILabel()
        recipePrepTime.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        recipePrepTime.textColor = .black
        recipePrepTime.text = "👨‍🍳" + recipe.prepTime.description
        recipePrepTime.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(recipePrepTime)
        
        let recipeCookTime = UILabel()
        recipeCookTime.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        recipeCookTime.textColor = .black
        recipeCookTime.text = "⏲️" + recipe.cookTime.description
        recipeCookTime.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(recipeCookTime)
        
        let viewsDictionary = ["recipeImageView": recipeImageView, "recipeTitle": recipeTitle, "recipeBy": recipeBy, "recipePrepTime": recipePrepTime, "recipeCookTime": recipeCookTime]
        
        // V: prefix indicates that the constraints being added are for the vertical axis.
        // '|' symbol represents the top and bottom edges of the container view.
        // '-' symbol is a spacing indicator, indicating that there should be some space between each view and the next.
        cardContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[recipeImageView(250)]-[recipeTitle]-[recipeBy(20)]", options: [], metrics: nil, views: viewsDictionary))
        cardContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[recipeBy]-[recipePrepTime(20)]", options: [], metrics: nil, views: viewsDictionary))
        cardContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[recipeBy]-[recipeCookTime(20)]-|", options: [], metrics: nil, views: viewsDictionary))
        cardContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[recipeImageView]-|", options: [], metrics: nil, views: viewsDictionary))
        cardContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[recipeTitle]-|", options: [], metrics: nil, views: viewsDictionary))
        cardContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[recipeBy]-[recipePrepTime]-[recipeCookTime]-|", options: [], metrics: nil, views: viewsDictionary))

        recipeImageView.centerYAnchor.constraint(equalTo: cardContainer.centerYAnchor, constant: -40).isActive = true
        recipeImageView.centerXAnchor.constraint(equalTo: cardContainer.centerXAnchor).isActive = true

        return cardContainer
    }


}
