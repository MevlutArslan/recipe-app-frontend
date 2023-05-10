//
//  ARViewController.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 05/05/2023.
//

import UIKit
import ARKit
import Vision
import AVFoundation

class ARViewController: UIViewController {
    private(set) var arView: ARSCNView!
    private(set) var arSession = ARSession()
    private var loadedImage: UIImage = UIImage()
    
    let handPoseRequest: VNDetectHumanHandPoseRequest = {
        let request = VNDetectHumanHandPoseRequest()
        request.maximumHandCount = 2
        return request
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravity
        configuration.detectionImages = []
        // Run the AR session
        arView.session.run(configuration)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //         Create a new ARSCNView instance
        //        arSession.delegate = self
        arView = ARSCNView(frame: self.view.frame)
        arView.session = arSession
        arView.automaticallyUpdatesLighting = true
        arView.autoenablesDefaultLighting = true
        arView.showsStatistics = true
        
        // Add the ARSCNView to your view hierarchy
        self.view.addSubview(arView)
    
        // I need a new view to enable the user to download or continue with the session
        ARModel.fetchSessionQRCode(completion: { imageResult in
            switch imageResult {
                case .success(let image):
                self.loadedImage = image
                case .failure(let error):
                    print("Error fetching qr code: \(error.localizedDescription)")
                }
            
            DispatchQueue.main.async {
                self.arView.addSubview(QrCodeMenuView(frame: self.arView.frame, qrCode: self.loadedImage, viewController: self))
            }
        })
        
    }
    
    @objc func handleQRCodeDownload(tapGestureRecognizer: UITapGestureRecognizer) {
        let activityViewController = UIActivityViewController(activityItems: [self.loadedImage], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
    
    @objc func handleQRCodeMenuClosing(tapGestureRecognizer: UITapGestureRecognizer) {
        tapGestureRecognizer.view?.superview?.removeFromSuperview()
    }
}
    


