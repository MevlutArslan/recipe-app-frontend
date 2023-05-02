//
//  Recipe.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 01/05/2023.
//

struct Recipe : Codable {
    var id: String
    var name: String
    var author: Author
    var prepTime: String = "10min"
    var cookTime: String = "15min"
    var ingredients: [String]
    var instructions: [String]
}

extension Recipe {
    static var sampleData = [
        Recipe(id: "1", name: "Pasta with Tomato Sauce", author: Author(id: "1", name: "John Doe"), ingredients: ["Pasta", "Tomatoes", "Garlic", "Basil", "Olive Oil"], instructions: ["Boil pasta according to package instructions", "Heat olive oil in a pan and add minced garlic", "Add chopped tomatoes and cook until soft", "Season with salt and pepper", "Add cooked pasta and toss with sauce", "Garnish with fresh basil leaves"]),
        Recipe(id: "2", name: "Grilled Chicken with Vegetables", author: Author(id: "2", name: "Jane Smith"), ingredients: ["Chicken Breasts", "Zucchini", "Bell Peppers", "Red Onion", "Olive Oil"], instructions: ["Preheat grill to medium-high heat", "Brush chicken breasts with olive oil and season with salt and pepper", "Grill chicken for 5-6 minutes per side or until cooked through", "Slice zucchini, bell peppers, and red onion into thin strips", "Toss vegetables with olive oil and season with salt and pepper", "Grill vegetables for 2-3 minutes per side or until tender", "Serve chicken with grilled vegetables"]),
        Recipe(id: "3", name: "Beef Stew", author: Author(id: "3", name: "Bob Smith"), ingredients: ["Beef Chuck Roast", "Carrots", "Potatoes", "Onion", "Garlic", "Tomato Paste", "Beef Broth"], instructions: ["Preheat oven to 350 degrees F", "Cut beef chuck roast into bite-sized pieces", "Season beef with salt and pepper", "Heat oil in a large Dutch oven over medium-high heat", "Brown beef in batches and set aside", "Add chopped onions and minced garlic to the pot and cook until softened", "Add tomato paste and cook for 1-2 minutes", "Add beef broth and stir to combine", "Return beef to the pot and add chopped carrots and potatoes", "Cover and bake in the oven for 2-3 hours or until beef is tender", "Serve hot"]),
        Recipe(id: "4", name: "Spaghetti Carbonara", author: Author(id: "4", name: "Mary Johnson"), ingredients: ["Spaghetti", "Bacon", "Egg Yolks", "Parmesan Cheese", "Garlic", "Olive Oil"], instructions: ["Cook spaghetti according to package instructions", "In a large pan, cook bacon until crispy and set aside", "Whisk together egg yolks and grated Parmesan cheese", "Add minced garlic to the pan and cook until fragrant", "Add cooked spaghetti to the pan and toss to combine", "Remove pan from heat and add egg yolk mixture, stirring quickly to avoid scrambling the eggs", "Crumble bacon over the top and serve hot"]),
        Recipe(id: "5", name: "Roast Chicken", author: Author(id: "5", name: "Alex Brown"), ingredients: ["Whole Chicken", "Lemon", "Garlic", "Rosemary", "Butter", "Salt", "Pepper"], instructions: ["Preheat oven to 425 degrees F", "Remove giblets from chicken and rinse chicken inside and out", "Pat chicken dry with paper towels", "Cut lemon in half and place in the cavity of the chicken, along with a few sprigs of rosemary and a few cloves of garlic", "Rub chicken with softened butter and season with"])]
}
