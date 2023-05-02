import UIKit

class VC_RecipeSelection: UIViewController {
    var recipes: [Recipe] = []
    let activityIndicator = UIActivityIndicatorView(style: .large) // Instantiate the activity indicator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        setupActivityIndicator()
        
        let recipeSelectionView = V_RecipeSelection()
        recipeSelectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recipeSelectionView)
        
        NSLayoutConstraint.activate([
            recipeSelectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            recipeSelectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            recipeSelectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            recipeSelectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        let recipeModel = RecipeModel()
        
        // Fetch recipes
        recipeModel.fetchRecipes { [weak self] recipes in
            guard let self = self else { return }
            self.recipes = recipes
            
            DispatchQueue.global().async {
                let group = DispatchGroup()
                
                for index in 0..<recipes.count {
                    group.enter()
                    
                    let recipe = recipes[index]
                    
                    recipeModel.fetchRecipeImage(imageUrl: recipe.image_url) { result in
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
}
