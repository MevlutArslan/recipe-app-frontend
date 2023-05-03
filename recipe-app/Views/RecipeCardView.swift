//
//  V_Recipe.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 01/05/2023.
//

import UIKit

class RecipeCardView: UIView {
    
    init(frame: CGRect, recipe: Recipe) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 4
        self.translatesAutoresizingMaskIntoConstraints = false
        
        createRecipeView(recipe: recipe)
    }    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize your view here.
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 4
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createRecipeView(recipe: Recipe) {
        let recipeImageView = UIImageView(image: recipe.image)
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(recipeImageView)
        
        let recipeTitle = UILabel()
        recipeTitle.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        recipeTitle.textColor = .black
        recipeTitle.text = recipe.name
        recipeTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(recipeTitle)
        
        let recipeBy = UILabel()
        recipeBy.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        recipeBy.textColor = .black
        recipeBy.text = "By: " + recipe.author_name
        recipeBy.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(recipeBy)
        
        let recipePrepTime = UILabel()
        recipePrepTime.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        recipePrepTime.textColor = .black
        recipePrepTime.text = "👨‍🍳" + recipe.prepTime.description
        recipePrepTime.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(recipePrepTime)
        
        let recipeCookTime = UILabel()
        recipeCookTime.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        recipeCookTime.textColor = .black
        recipeCookTime.text = "⏲️" + recipe.cookTime.description
        recipeCookTime.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(recipeCookTime)
        
        let viewsDictionary = ["recipeImageView": recipeImageView, "recipeTitle": recipeTitle, "recipeBy": recipeBy, "recipePrepTime": recipePrepTime, "recipeCookTime": recipeCookTime]
        
        // V: prefix indicates that the constraints being added are for the vertical axis.
        // '|' symbol represents the top and bottom edges of the container view.
        // '-' symbol is a spacing indicator, indicating that there should be some space between each view and the next.
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[recipeImageView(250)]-[recipeTitle]-[recipeBy(20)]", options: [], metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[recipeBy]-[recipePrepTime(20)]", options: [], metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[recipeBy]-[recipeCookTime(20)]-|", options: [], metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[recipeImageView]-|", options: [], metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[recipeTitle]-|", options: [], metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[recipeBy]-[recipePrepTime]-[recipeCookTime]-|", options: [], metrics: nil, views: viewsDictionary))
        
        recipeImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40).isActive = true
        recipeImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
