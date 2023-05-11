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

enum ARSessionStates {
    case QRCodeDisplayed
    case QRCodeDownloaded
    case ARImageAdded
    case ARSessionStarted
}

class ARViewController: UIViewController, ARSCNViewDelegate {
    private(set) var arView: ARSCNView!
    private(set) var arSession = ARSession()
    private var loadedImage: UIImage = UIImage()
    private var state: ARSessionStates = .QRCodeDisplayed
    private let configuration = ARWorldTrackingConfiguration()
    
    let handPoseRequest: VNDetectHumanHandPoseRequest = {
        let request = VNDetectHumanHandPoseRequest()
        request.maximumHandCount = 2
        return request
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        configuration.worldAlignment = .gravity
        configuration.maximumNumberOfTrackedImages = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView = ARSCNView(frame: self.view.frame)
        arView.delegate = self
        arView.session = arSession
        arView.automaticallyUpdatesLighting = true
        arView.autoenablesDefaultLighting = true
        arView.showsStatistics = true
        arView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        
        self.view.addSubview(arView)
        
        ARModel.fetchSessionQRCode(completion: { imageResult in
            switch imageResult {
            case .success(let image):
                self.loadedImage = image
            case .failure(let error):
                print("Error fetching qr code: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.state = .QRCodeDisplayed
                self.arView.addSubview(QrCodeMenuView(frame: self.arView.frame, qrCode: self.loadedImage, viewController: self))
            }
        })
    }
    
    @objc func handleQRCodeDownload(tapGestureRecognizer: UITapGestureRecognizer) {
        let activityViewController = UIActivityViewController(activityItems: [self.loadedImage], applicationActivities: nil)
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
        guard let image = loadedImage.cgImage else {
            print("error accessing the qr code!")
            return
        }
        let referanceImage = ARReferenceImage(image, orientation: .up, physicalWidth: 0.035)
        
        configuration.detectionImages.insert(referanceImage)
        
        self.state = .ARImageAdded
        self.arSession.run(configuration)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // Check if the anchor is an image anchor
        print("RENDERING")
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return
        }
        print(imageAnchor.referenceImage)
        let physicalWidth = imageAnchor.referenceImage.physicalSize.width
        let physicalHeight = imageAnchor.referenceImage.physicalSize.height

        // Create a plane geometry to visualize the initial position of the detected image
        let mainPlane = SCNPlane(width: physicalWidth, height: physicalHeight)

        mainPlane.firstMaterial?.diffuse.contents = UIColor.blue
        
        let mainNode = SCNNode(geometry: mainPlane)
        mainNode.eulerAngles.x = -.pi / 2
        mainNode.renderingOrder = -1
        mainNode.opacity = 1
        
//        let cube = SCNBox(width: 0.035, height: 0.035, length: 0.035, chamferRadius: 0)
//        cube.firstMaterial?.diffuse.contents = UIColor.red
//
//        mainNode.addChildNode(SCNNode(geometry: cube))
        
        
        node.transform = SCNMatrix4(imageAnchor.transform)
        
        node.addChildNode(mainNode)
        
    }
    
}
