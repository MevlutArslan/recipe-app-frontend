//
//  RecipeModel.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 02/05/2023.
//

import UIKit

class RecipeModel {
    // @escaping makes sure we wait for the results to be ready before we return to make sure we don't return an empty array.
    
    func fetchRecipes(completion: @escaping ([Recipe]) -> Void) {
        guard let url = URL(string: "http://10.0.0.62:8888/recipes") else {
            completion([])
            return
        }
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        
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
    
    func fetchRecipeImage(imageUrl: String, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
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



}
