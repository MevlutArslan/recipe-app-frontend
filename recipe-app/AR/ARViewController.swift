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
    private var previousViewController: RecipeViewController?
    
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
        
        let n = self.navigationController!.viewControllers.count
        previousViewController = self.navigationController?.viewControllers[n-2] as? RecipeViewController
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

        let physicalWidth = imageAnchor.referenceImage.physicalSize.width
        let physicalHeight = imageAnchor.referenceImage.physicalSize.height
        
        let widthInPixels = self.getDimensionInPixels(meters: Float(physicalWidth))
        let heightInPixels = self.getDimensionInPixels(meters: Float(physicalHeight))
        
        let frameWidthInPixels: Float = 390
        let frameHeightInPixels: Float = 844

        let frameWidthInMeters: Float = self.pixelToMeters(pixels: frameWidthInPixels)
        let frameHeightInMeters: Float = self.pixelToMeters(pixels: frameHeightInPixels)
        
        let cube = SCNBox(width: CGFloat(frameWidthInMeters), height: CGFloat(frameHeightInMeters), length: CGFloat(frameWidthInMeters) / 3, chamferRadius: 0)
        
        // Create a plane geometry to visualize the initial position of the detected image
        let mainPlane = SCNPlane(width: CGFloat(frameWidthInMeters), height: CGFloat(frameHeightInMeters))
        
        let mainNode = SCNNode(geometry: mainPlane)
        mainNode.position = SCNVector3(x: 0, y: 0, z: ((frameWidthInMeters / 3) / 2) + 0.0012)
        mainNode.opacity = 1
        
        DispatchQueue.main.async {
            let recipeView = RecipeView(frame: self.arView.frame, recipe: self.previousViewController!.recipe!)

            mainPlane.firstMaterial?.diffuse.contents = recipeView.renderToImage()
        }
        
        let cubeNode = SCNNode(geometry: cube)
        cubeNode.position = SCNVector3(x: 0, y: 0, z: 0) // Position the cube slightly above the detected image
        cubeNode.eulerAngles.x = -.pi / 2
        cubeNode.addChildNode(mainNode)
        node.transform = SCNMatrix4(imageAnchor.transform)
        
        node.addChildNode(cubeNode)
        
    }
    
    private func pixelToMeters(pixels: Float) -> Float {
        return (pixels / 460) * 0.0254;
    }
    
    private func getDimensionInPixels(meters: Float) -> Float {
        return meters * 460 / 0.0254
    }
    
}
