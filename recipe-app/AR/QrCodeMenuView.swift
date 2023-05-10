//
//  QrCodeMenuView.swift
//  recipe-app
//
//  Created by Mevlut Arslan on 09/05/2023.
//

import UIKit

class QrCodeMenuView : UIView {
    let rootView = UIImageView()
    let optionsView = UIImageView()
    let cancelView = UIImageView()
    
    let buttonSize = 30.0
    let sideOffset = 15.0
    var qrCode: UIImage
    
    weak var viewController: ARViewController?
    
    init(frame: CGRect, qrCode: UIImage, viewController: ARViewController) {
        self.qrCode = qrCode
        self.viewController = viewController
        super.init(frame: frame)
        isUserInteractionEnabled = true
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        rootView.frame = CGRect(x: (self.frame.width / 2) - 200, y: (self.frame.height / 2) - 200, width: 400, height: 400)
        rootView.image = qrCode
        rootView.isUserInteractionEnabled = true
        self.addSubview(rootView)

        cancelView.frame = CGRect(x: sideOffset, y:sideOffset, width: buttonSize, height: buttonSize)
        cancelView.backgroundColor = .clear
        cancelView.image = UIImage(systemName: "xmark.circle")
        cancelView.isUserInteractionEnabled = true
        
        optionsView.frame = CGRect(x: rootView.frame.width - (buttonSize + sideOffset), y: rootView.frame.height - (buttonSize + sideOffset), width: buttonSize, height: buttonSize)
        optionsView.backgroundColor = .clear
        optionsView.image = UIImage(systemName: "square.and.arrow.down")
        optionsView.isUserInteractionEnabled = true

        if let vc = viewController {
            var gestureRecognizer = UITapGestureRecognizer(target: vc, action: #selector(vc.handleQRCodeMenuClosing(tapGestureRecognizer:)))
            cancelView.addGestureRecognizer(gestureRecognizer)
            
            gestureRecognizer = UITapGestureRecognizer(target: vc, action: #selector(vc.handleQRCodeDownload(tapGestureRecognizer:)))
            optionsView.addGestureRecognizer(gestureRecognizer)
        }
        
        rootView.addSubview(cancelView)
        rootView.addSubview(optionsView)
    }

}
