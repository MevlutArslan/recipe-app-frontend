//
//  RecipeView.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 02/05/2023.
//

import UIKit

class RecipeView : UIScrollView {
    private var recipe: Recipe?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, recipe: Recipe){
        self.recipe = recipe
        super.init(frame: frame)
        
        self.backgroundColor = .darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func drawRecipe() {
        guard self.recipe != nil else {
            print("RECIPE OBJECT IS NULL")
            return
        }
        
        
    }
    
    func setRecipe(recipe: Recipe) {
        self.recipe = recipe
    }
}
