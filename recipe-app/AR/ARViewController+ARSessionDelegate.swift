//
//  ARViewController+HandRecognizer.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 09/05/2023.
//
import ARKit
import Vision
import AVFoundation

extension ARViewController: ARSessionDelegate {
    func session(_ session: ARSession, didUpdate frame: ARFrame) {

        let imageBuffer = frame.capturedImage
        // Pass imageBuffer to Vision for processing
        var fingerTips: [CGPoint] = []

        let ciImage = CIImage(cvPixelBuffer: imageBuffer)

        // Get the image from the sample buffer
        let handler = VNImageRequestHandler(ciImage: ciImage)

        do {
            try handler.perform([handPoseRequest])
            guard let results = handPoseRequest.results else {
                return
            }

            // Clear previously drawn points
            DispatchQueue.main.async {
                // Remove all circle layers from view
                self.view.layer.sublayers?.filter { $0 is CAShapeLayer }.forEach {
                    $0.removeFromSuperlayer()
                }
            }

            var recognizedPoints: [VNRecognizedPoint] = []
            try results.forEach { observation in
                // Get finger points
                let fingers = try observation.recognizedPoints(.all)

                recognizedPoints.append(contentsOf: fingers.values)
            }

            // Filter recognized points and convert to view coordinates
            fingerTips = recognizedPoints.filter {
                // Ignore low confidence points.
                $0.confidence > 0.7
            }
            .map {
                return VNImagePointForNormalizedPoint(CGPoint(x: $0.location.y, y: $0.location.x), Int(self.arView.bounds.width),  Int(self.arView.bounds.height))
            }


            guard fingerTips.count > 0 else {return}

            // Draw circles at the fingertip locations
            let path = UIBezierPath()
            DispatchQueue.main.async {
                fingerTips.forEach { point in
                    path.move(to: point)
                    path.addArc(withCenter: point, radius: 5, startAngle: 0, endAngle: 360, clockwise: true)
                }

                let circleLayer = CAShapeLayer()
                circleLayer.path = path.cgPath
                circleLayer.fillColor = UIColor.red.cgColor
                self.view.layer.addSublayer(circleLayer)
            }
        }
     catch {
        print("Error: \(error)")
    }

}

}
