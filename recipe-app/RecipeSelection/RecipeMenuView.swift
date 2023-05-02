//
//  RecipeSelectionView.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 01/05/2023.
//

import UIKit

class RecipeMenuView: UIScrollView {
    private var recipes: [Recipe] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
       
        setupRecipeMenu()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize your view here.
        setupRecipeMenu()
    }
        
    
    func setupRecipeMenu() {
        self.backgroundColor = .yellow
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: topAnchor),
            self.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -32)
        ])

        for recipe in recipes {
            let recipeView = RecipeCardView(frame: self.frame, recipe: recipe)
            stackView.addArrangedSubview(recipeView)
        }

        // Set the content size of the scroll view based on the height of the stack view
        self.contentSize = CGSize(width: self.frame.size.width, height: stackView.frame.size.height + 32)
    }

    public func setRecipes(_ recipes: [Recipe]) {
        self.recipes = recipes
    }

}
