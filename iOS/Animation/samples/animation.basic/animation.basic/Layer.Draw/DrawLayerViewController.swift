//
//  DrawLayerViewController.swift
//  animation.basic
//
//  Created by jhunter on 2019/4/28.
//  Copyright © 2019 mobile.knowledge.map. All rights reserved.
//

import UIKit

class DrawLayerViewController: UIViewController {
    private var shapeLayer: CAShapeLayer?
    private var delegateLayer: CALayer?
    private var drawInContextLayer: CALayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapShapeLayer(_ sender: UIButton) {
        reset()
        let width: CGFloat = 300
        let height: CGFloat = 300
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: 0, y: 100,
                                  width: width, height: height)
        
        let path = CGMutablePath()
        
        stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 6).forEach {
            angle in
            var transform  = CGAffineTransform(rotationAngle: angle)
                .concatenating(CGAffineTransform(translationX: width / 2, y: height / 2))
            
            let petal = CGPath(ellipseIn: CGRect(x: -20, y: 0, width: 40, height: 100),
                               transform: &transform)
            
            path.addPath(petal)
        }
        
        shapeLayer.path = path
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.yellow.cgColor
        shapeLayer.fillRule = .evenOdd
        
        self.shapeLayer = shapeLayer
        view.layer.addSublayer(shapeLayer)
    }
    
    @IBAction func tapDelegate(_ sender: UIButton) {
        reset()
        delegateLayer = CALayer()
        delegateLayer?.frame = CGRect(x: (UIScreen.main.bounds.width - 300.0) / 2.0, y: 100,
                                  width: 300, height: 300)
        delegateLayer?.delegate = self
        if let layer = delegateLayer {
            view.layer.addSublayer(layer)
            layer.setNeedsDisplay()
        }
    }
    
    @IBAction func tapDrawInContext(_ sender: UIButton) {
        reset()
        drawInContextLayer = CustomLayer()
        drawInContextLayer?.frame = CGRect(x: (UIScreen.main.bounds.width - 300.0) / 2.0, y: 100,
                                      width: 300, height: 300)
        if let layer = drawInContextLayer {
            view.layer.addSublayer(layer)
            layer.setNeedsDisplay()
        }
    }

    private func reset() {
        shapeLayer?.removeFromSuperlayer()
        shapeLayer = nil
        delegateLayer?.removeFromSuperlayer()
        delegateLayer = nil
        drawInContextLayer?.removeFromSuperlayer()
        drawInContextLayer = nil
    }
}

extension DrawLayerViewController: CALayerDelegate {
    func draw(_ layer: CALayer, in ctx: CGContext) {
        if let image: UIImage = UIImage(named: "transform.demo"), let cgImage = image.cgImage {
            ctx.saveGState()
            
            // Core Graphics的坐标系是自然坐标系，因此需要变换一下和UIView的坐标系一致
            let scale = layer.bounds.size.width / image.size.width // 因为Demo用的图片宽比高要大
            ctx.scaleBy(x: scale, y: -scale)
            ctx.translateBy(x: 0, y: -image.size.height)
            ctx.draw(cgImage, in: CGRect(origin: .zero, size: image.size))
            
            ctx.restoreGState()
        }
    }
}

class CustomLayer: CALayer {
    override func draw(in ctx: CGContext) {
        if let image: UIImage = UIImage(named: "transform.demo"), let cgImage = image.cgImage {
            ctx.saveGState()
            
            // Core Graphics的坐标系是自然坐标系，因此需要变换一下和UIView的坐标系一致
            let scale = bounds.size.width / image.size.width // 因为Demo用的图片宽比高要大
            ctx.scaleBy(x: scale, y: -scale)
            ctx.translateBy(x: 0, y: -image.size.height)
            ctx.draw(cgImage, in: CGRect(origin: .zero, size: image.size))
            
            ctx.restoreGState()
        }
    }
}
