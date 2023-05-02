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
        
        // Fetch recipes
        RecipeModel().fetchRecipes { recipes in
            self.recipes = recipes
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()
                recipeSelectionView.setRecipes(recipes)
                recipeSelectionView.setupRecipeMenu()
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
