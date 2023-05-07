//
//  ARViewController.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 05/05/2023.
//

import UIKit
import ARKit

class ARViewController: UIViewController {
    var arView: ARSCNView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Create a new ARSCNView instance
        arView = ARSCNView(frame: self.view.frame)

        // Add the ARSCNView to your view hierarchy
        self.view.addSubview(arView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the AR session
        arView.session.run(configuration)
    }
    
    
    
    func setupView() {
        
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
