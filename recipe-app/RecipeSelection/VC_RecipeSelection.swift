import UIKit

class VC_RecipeSelection: UIViewController {
    var recipes: [Recipe] = []
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add an activity indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        fetchRecipes()
    }

    func fetchRecipes() {
        guard let url = URL(string: "http://10.0.0.62:8888/recipes") else {
            return
        }

        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in

            guard error == nil else {
                print(error!)
                return
            }

            // handle response
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected response status code")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let recipes = try decoder.decode([Recipe].self, from: data)
                self.recipes = recipes
                print(self.recipes)

                // Update the view on the main thread
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.removeFromSuperview()

                    let recipeSelectionView = V_RecipeSelection()
                    recipeSelectionView.setRecipes(self.recipes)
                    recipeSelectionView.setupRecipeMenu()
                    recipeSelectionView.translatesAutoresizingMaskIntoConstraints = false
                    self.view.addSubview(recipeSelectionView)

                    NSLayoutConstraint.activate([
                        recipeSelectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
                        recipeSelectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                        recipeSelectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                        recipeSelectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
                    ])
                }
            } catch let error {
                print(error)
            }

        })

        task.resume()
    }
}
