//
//  RecipeModel.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 02/05/2023.
//

import UIKit

class RecipeModel {
    // @escaping makes sure we wait for the results to be ready before we return to make sure we don't return an empty array.
    private static let baseUrl = "http://10.0.0.62:8888/"
    
    static func fetchRecipes(completion: @escaping ([Recipe]) -> Void) {
        guard let url = URL(string: baseUrl + "recipes") else {
            completion([])
            return
        }
        
        let request = URLRequest(url: url)
//        request.cachePolicy = .returnCacheDataElseLoad
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
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
                let recipes = try decoder.decode([Recipe].self, from: data)
                completion(recipes)
            } catch let error {
                print(error)
                completion([])
            }
        })
        
        task.resume()
    }
    
    static func fetchRecipeImage(imageUrl: String, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        guard let url = URL(string: imageUrl) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data, let image = UIImage(data: data) else {
                completion(.failure(NSError(domain: "Error fetching image", code: 0, userInfo: nil)))
                return
            }
            
            completion(.success(image))
        }
        
        task.resume()
    }
    
    static func fetchRecipeById(recipeId: String, completion: @escaping ((Result<Recipe, Error>) -> Void)) {
        guard let url = URL(string: baseUrl + "recipes/\(recipeId)") else {
            completion(.failure(NSError(domain: "Failed to create URL", code: 0)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(NSError(domain: "Failed to connect to URL", code: 0)))
                return
            }
            
            // handle response
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Unexpected response status code", code: 0)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data Received", code: 0)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let recipe = try decoder.decode(Recipe.self, from: data)
                completion(.success(recipe))
            } catch let error {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }



}
