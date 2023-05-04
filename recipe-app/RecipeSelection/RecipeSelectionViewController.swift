import UIKit

class RecipeSelectionViewController: UIViewController {
    var recipes: [Recipe] = []
    let activityIndicator = UIActivityIndicatorView(style: .large) // Instantiate the activity indicator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        setupActivityIndicator()
        
        let recipeSelectionView = RecipeMenuView(frame: view.frame, viewController: self)
        recipeSelectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recipeSelectionView)
        
        NSLayoutConstraint.activate([
            recipeSelectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            recipeSelectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            recipeSelectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            recipeSelectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        // Fetch recipes
        RecipeModel.fetchRecipes { [weak self] recipes in
            guard let self = self else { return }
            self.recipes = recipes
            
            DispatchQueue.global().async {
                let group = DispatchGroup()
                
                for index in 0..<recipes.count {
                    group.enter()
                    
                    let recipe = recipes[index]
                    
                    RecipeModel.fetchRecipeImage(imageUrl: recipe.image_url) { result in
                        switch result {
                        case .success(let image):
                            self.recipes[index].image = image
                        default:
                            // Handle error case
                            break
                        }
                        
                        group.leave()
                    }
                }
                
                group.wait()
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.removeFromSuperview()
                    recipeSelectionView.setRecipes(self.recipes)
                    recipeSelectionView.setupRecipeMenu()
                }
            }
        }
    }
    
    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    @objc func handleRecipeSelect(sender: UITapGestureRecognizer) {
        let id = sender.accessibilityValue // this is a dumb way to do it but f*** it
        navigationController?.pushViewController(RecipeViewController(recipeId: id!), animated: true)
    }
}
