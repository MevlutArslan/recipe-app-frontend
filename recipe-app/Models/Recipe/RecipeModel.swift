//
//  RecipeModel.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 02/05/2023.
//

import Foundation

class RecipeModel {
    private var recipes: [Recipe] = []
    private var authors: [Author] = []
    
    public static var recipeMap: [String: Recipe] = [:]
    public static var authorMap: [String: Author] = [:]
    
    // @escaping makes sure we wait for the results to be ready before we return to make sure we don't return an empty array.
    func fetchRecipes(completion: @escaping ([Recipe]) -> Void) {
        guard let url = URL(string: "http://10.0.0.62:8888/recipes") else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            guard error == nil else {
                print(error!)
                completion([])
                return
            }
            
            // handle response
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected response status code")
                completion([])
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                self.recipes = try decoder.decode([Recipe].self, from: data)
                completion(self.recipes)
            } catch let error {
                print(error)
                completion([])
            }
        })
        
        task.resume()
    }
    
}
