//
//  ARViewController.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 05/05/2023.
//

import UIKit
import ARKit

class ARViewController: UIViewController, ARSessionDelegate {
    var arView: ARSCNView!
    var arSession = ARSession()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravity
        
        // Run the AR session
        arView.session.run(configuration)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Create a new ARSCNView instance
        arSession.delegate = self
        
        arView = ARSCNView(frame: self.view.frame)
        arView.session = arSession
        
        // Create a 3D object node
        let objectNode = SCNNode()
        objectNode.geometry = SCNSphere(radius: 0.1)
        objectNode.position = SCNVector3(0, 0, -0.5) // Set position in 3D space

        // Add the object node to the AR session
        arView.scene.rootNode.addChildNode(objectNode)

        // Add the ARSCNView to your view hierarchy
        self.view.addSubview(arView)
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
