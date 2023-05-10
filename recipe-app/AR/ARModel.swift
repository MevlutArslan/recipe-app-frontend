//
//  ARModel.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 09/05/2023.
//

import UIKit
import ARKit

class ARModel {
    private static let baseUrl = "http://10.0.0.62:8888/ar_session/"
    
    static func fetchSessionQRCode(completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        guard let url = URL(string: baseUrl + "qr_code/\(UIDevice.current.identifierForVendor!)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let data = data, let image = UIImage(data: data) else {
                completion(.failure(NSError(domain: "Error fetching image", code: 0, userInfo: nil)))
                return
            }
            
            completion(.success(image))
        }
        
        task.resume()
    }
}
