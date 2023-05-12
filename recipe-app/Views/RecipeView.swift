//
//  RecipeView.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 02/05/2023.
//

import UIKit

class RecipeView : UIView {
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let recipeImageView = UIImageView()
    private let recipeTitleView = UITextView()
    private let recipeInfoStackView = UIStackView()
    private let recipeAuthorLabel = UILabel()
    private let recipeYieldLabel = UILabel()
    private let recipePrepTime = UILabel()
    private let recipeCookTime = UILabel()
    private let ingredientsStackView = UIStackView()
    private let instructionsStackView = UIStackView()
    
    private weak var viewController: RecipeViewController?
    
    init(frame: CGRect, recipe: Recipe, viewController: RecipeViewController) {
        super.init(frame: frame)
        setupRecipeView(recipe: recipe)
        self.viewController = viewController
    }
    
    init(frame: CGRect, recipe: Recipe) {
        super.init(frame: frame)
        setupRecipeView(recipe: recipe)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupRecipeView(recipe: Recipe) {
        scrollView.backgroundColor = .systemRed
        scrollView.frame = self.frame
        addSubview(scrollView)
        
        let button = UIButton(type: .system)
        button.setTitle("AR", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.tintColor = .white
        
        button.addTarget(viewController, action: #selector(self.viewController!.launchAR), for: .touchUpInside)
        
        // Add the button to the view
        addSubview(button)
        
        // Set the button's position
        button.translatesAutoresizingMaskIntoConstraints = false
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        recipeImageView.image = recipe.image
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.contentMode = .scaleAspectFit
        
        stackView.addArrangedSubview(recipeImageView)
        
        NSLayoutConstraint.activate([
            recipeImageView.heightAnchor.constraint(equalToConstant: 250),
            recipeImageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        
        recipeTitleView.text = recipe.name
        recipeTitleView.font = UIFont.boldSystemFont(ofSize: 24)
        recipeTitleView.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        recipeTitleView.textAlignment = .center
        recipeTitleView.isEditable = false
        recipeTitleView.isScrollEnabled = false
        recipeTitleView.translatesAutoresizingMaskIntoConstraints = false
        recipeTitleView.backgroundColor  = .clear
        
        stackView.addArrangedSubview(recipeTitleView)
        
        recipeInfoStackView.axis = .horizontal
        recipeInfoStackView.alignment = .center
        recipeInfoStackView.spacing = 8
        recipeInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        recipeAuthorLabel.text = recipe.author_name
        recipeAuthorLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        recipeAuthorLabel.textColor = .black
        recipeAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeInfoStackView.addArrangedSubview(recipeAuthorLabel)
        
        recipeYieldLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        recipeYieldLabel.textColor = .black
        recipeYieldLabel.text = "👥" + recipe.recipe_yield
        recipeYieldLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeInfoStackView.addArrangedSubview(recipeYieldLabel)
        
        recipePrepTime.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        recipePrepTime.textColor = .black
        recipePrepTime.text = "👨‍🍳" + recipe.prepTime.description
        recipePrepTime.translatesAutoresizingMaskIntoConstraints = false
        recipeInfoStackView.addArrangedSubview(recipePrepTime)
        
        recipeCookTime.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        recipeCookTime.textColor = .black
        recipeCookTime.text = "⏲️" + recipe.cookTime.description
        recipeCookTime.translatesAutoresizingMaskIntoConstraints = false
        recipeInfoStackView.addArrangedSubview(recipeCookTime)
        
        stackView.addArrangedSubview(recipeInfoStackView)
        
        for pair in recipe.ingredients {
            // ["Patates püresi için;": ["4 adet orta boy patates", "1 yemek kaşığı tereyağı", "Yarım çay bardağı kaşar peyniri rendesi", "1 tatlı kaşığı tuz", "Yarım çay kaşığı karabiber"]]
            let verticalStack = UIStackView()
            verticalStack.axis = .vertical
            verticalStack.alignment = .leading
            verticalStack.spacing = 0
            verticalStack.translatesAutoresizingMaskIntoConstraints = false
            
            for dict in pair {
                let subtitleLabel = UILabel()
                subtitleLabel.text = dict.key
                subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
                subtitleLabel.textColor = .darkText
                subtitleLabel.textAlignment = .left
                subtitleLabel.numberOfLines = 0 // Set to 0 for multiline support
                verticalStack.addArrangedSubview(subtitleLabel)
                
                for value in dict.value {
                    let subtitleLabel = UILabel()
                    subtitleLabel.text = ("* \(value)")
                    subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
                    subtitleLabel.textColor = .darkText
                    subtitleLabel.textAlignment = .left
                    subtitleLabel.numberOfLines = 0 // Set to 0 for multiline support
                    verticalStack.addArrangedSubview(subtitleLabel)
                }
            }
            
            stackView.addArrangedSubview(verticalStack)
        }
        
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.alignment = .leading
        verticalStack.spacing = 5
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        for instruction in recipe.instructions {
            let subtitleLabel = UILabel()
            subtitleLabel.text = ("\(instruction)")
            subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            subtitleLabel.textColor = .darkText
            subtitleLabel.textAlignment = .left
            subtitleLabel.numberOfLines = 0 // Set to 0 for multiline support
            
            verticalStack.addArrangedSubview(subtitleLabel)
        }
        
        stackView.addArrangedSubview(verticalStack)
        
    }
}

extension UIView {
    func renderToImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        return renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
    }
}
