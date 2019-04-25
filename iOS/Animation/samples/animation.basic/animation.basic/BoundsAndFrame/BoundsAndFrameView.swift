//
//  BoundsAndFrameView.swift
//  animation.basic
//
//  Created by jhunter on 2019/4/25.
//  Copyright © 2019 mobile.knowledge.map. All rights reserved.
//

import Foundation
import UIKit

class BoundsFrameView: UIView {
    // MARK: - Properties
    private weak var rotateLayer: CALayer!
    private weak var resultLabel: UILabel!
    
    override func willMove(toSuperview newSuperview: UIView?) {
        setupRotationLayer()
    }
    
    // MARK: - Private methods
    private func setupRotationLayer() {
        guard rotateLayer == nil else { return }
        
        let rotation: CALayer = {
            layer.addSublayer($0)
            $0.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
            layer.backgroundColor = UIColor.blue.cgColor
            $0.backgroundColor = UIColor.yellow.cgColor
            
            return $0
        }(CALayer())
        rotateLayer = rotation
        let transform = CATransform3DMakeRotation(CGFloat(Double.pi) / 4, 0, 0, 1)
        rotateLayer.transform = transform
        
        let label: UILabel = {
            addSubview($0)
            $0.frame = CGRect(x: 16, y: 16, width: 300, height: 30)
            $0.adjustsFontSizeToFitWidth = true
            $0.minimumScaleFactor = 0.5
            $0.textColor = .white
            return $0
        }(UILabel(frame: .zero))
        label.text = String(format: "Bound size: \(rotation.bounds.size), frame size: (%0.2f , %0.2f)",
            rotation.frame.size.width, rotation.frame.size.height)
    }
}
