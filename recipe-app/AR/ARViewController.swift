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
import RealityKit

enum ARSessionStates {
    case QRCodeDisplayed
    case QRCodeDownloaded
    case ARImageAdded
    case ARSessionStarted
}

class ARViewController: UIViewController {
    private(set) var arView: ARView!
    private(set) var previousViewController: RecipeViewController?

    private var loadedQRCode: UIImage = UIImage()
    private var state: ARSessionStates = .QRCodeDisplayed

    let configuration = ARWorldTrackingConfiguration()

    let handPoseRequest: VNDetectHumanHandPoseRequest = {
        let request = VNDetectHumanHandPoseRequest()
        request.maximumHandCount = 2
        return request
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configuration.worldAlignment = .gravity
        configuration.maximumNumberOfTrackedImages = 1
        configuration.frameSemantics.insert(.personSegmentationWithDepth)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView = ARView(frame: self.view.frame)
       
        arView.debugOptions = [.showFeaturePoints, .showWorldOrigin, .showAnchorOrigins]
        arView.session.delegate = self;
        self.view.addSubview(arView)
        
        ARModel.fetchSessionQRCode(completion: { imageResult in
            switch imageResult {
            case .success(let image):
                self.loadedQRCode = image
            case .failure(let error):
                print("Error fetching qr code: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.state = .QRCodeDisplayed
                self.arView.addSubview(QrCodeMenuView(frame: self.arView.frame, qrCode: self.loadedQRCode, viewController: self))
            }
        })
        
        let n = self.navigationController!.viewControllers.count
        previousViewController = self.navigationController?.viewControllers[n-2] as? RecipeViewController
    }
    
    @objc func handleQRCodeDownload(tapGestureRecognizer: UITapGestureRecognizer) {
        let activityViewController = UIActivityViewController(activityItems: [self.loadedQRCode], applicationActivities: nil)
        present(activityViewController, animated: true)
        
        self.state = .QRCodeDownloaded
        addQRCodeToTracking()
    }
    
    @objc func handleQRCodeMenuClosing(tapGestureRecognizer: UITapGestureRecognizer) {
        tapGestureRecognizer.view?.superview?.removeFromSuperview()
        
        self.state = .QRCodeDownloaded
        addQRCodeToTracking()
    }
    
    private func addQRCodeToTracking() {
        guard let image = loadedQRCode.cgImage else {
            print("error accessing the qr code!")
            return
        }
        let referanceImage = ARReferenceImage(image, orientation: .up, physicalWidth: 0.035)
        
        self.configuration.detectionImages.insert(referanceImage)
        
        self.state = .ARImageAdded
        self.arView.session.run(self.configuration)
    }
    
}
