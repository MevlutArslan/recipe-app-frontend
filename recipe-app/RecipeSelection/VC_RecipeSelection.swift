//
//  VC_RecipeSelection.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 01/05/2023.
//

import UIKit

class VC_RecipeSelection: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        let recipeSelectionView = V_RecipeSelection()
        recipeSelectionView.setRecipes(Recipe.sampleData)
        recipeSelectionView.setupRecipeMenu()
        recipeSelectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recipeSelectionView)
        
        NSLayoutConstraint.activate([
            recipeSelectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            recipeSelectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            recipeSelectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            recipeSelectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
    }
}
