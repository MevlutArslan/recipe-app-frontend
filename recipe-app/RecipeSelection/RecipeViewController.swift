//
//  VC_RecipeViewController.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 02/05/2023.
//

import UIKit
import ARKit

class RecipeViewController: UIViewController {
    private var recipeId: String
    private var recipe: Recipe?
    let activityIndicator = UIActivityIndicatorView(style: .large) // Instantiate the activity indicator
    
    
    init(recipeId: String) {
        self.recipeId = recipeId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.recipeId = ""
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        
        RecipeModel.fetchRecipeById(recipeId: recipeId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let recipe):
                self.recipe = recipe
                
                DispatchQueue.global().async {
                    RecipeModel.fetchRecipeImage(imageUrl: self.recipe!.image_url) { imageResult in
                        switch imageResult {
                        case .success(let image):
                            self.recipe!.image = image
                        case .failure(let error):
                            print("Error fetching recipe image: \(error.localizedDescription)")
                        }
                    }
                }
                
            case .failure(let error):
                print("Error fetching recipe: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                guard self.recipe != nil else { return }
                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()
                self.view.addSubview(RecipeView(frame: self.view.frame, recipe: self.recipe!, viewController: self))
            }
        }

        // Do any additional setup after loading the view.
    }
    
    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    @objc func launchAR() {
        guard ARWorldTrackingConfiguration.isSupported else {
            fatalError("""
                ARKit is not available on this device. For apps that require ARKit
                for core functionality, use the `arkit` key in the key in the
                `UIRequiredDeviceCapabilities` section of the Info.plist to prevent
                the app from installing. (If the app can't be installed, this error
                can't be triggered in a production scenario.)
                In apps where AR is an additive feature, use `isSupported` to
                determine whether to show UI for launching AR experiences.
            """) // For details, see https://developer.apple.com/documentation/arkit
        }
        navigationController?.pushViewController(ARViewController(), animated: true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
