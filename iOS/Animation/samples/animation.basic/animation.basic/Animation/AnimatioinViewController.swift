//
//  AnimatioinViewController.swift
//  animation.basic
//
//  Created by jhunter on 2019/4/29.
//  Copyright © 2019 mobile.knowledge.map. All rights reserved.
//

import UIKit

class AnimatioinViewController: UIViewController {
    
    private weak var animationLayer: CALayer!
    private weak var paperPlane: CALayer!
    
    private var randomColor: CGColor {
        let red = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let green = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let blue = CGFloat(arc4random()) / CGFloat(UInt32.max)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0).cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupAnimationLayer()
        setupPaperPlane()
    }
    
    @IBAction func tapAnimation(_ sender: UIButton) {
        animationLayer.removeAllAnimations()
        paperPlane.isHidden = true
        animationLayer.isHidden = false
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.toValue = UIColor.blue.cgColor
        animation.duration = 2
        animation.delegate = self
        animationLayer.add(animation, forKey: nil)
    }
    
    @IBAction func tapKeyframe(_ sender: UIButton) {
        animationLayer.removeAllAnimations()
        paperPlane.isHidden = true
        animationLayer.isHidden = false
        let animation = CAKeyframeAnimation(keyPath: "backgroundColor")
        animation.values = [randomColor, randomColor, randomColor, randomColor, randomColor]
        animation.duration = 7
        animation.delegate = self
        animationLayer.add(animation, forKey: nil)
    }
    
    @IBAction func tapPaperPlane(_ sender: UIButton) {
        paperPlane.removeAllAnimations()
        paperPlane.isHidden = false
        animationLayer.isHidden = true

        let animation = pathAnimation(origin: paperPlane.position)
        paperPlane.add(animation, forKey: nil)
    }
    
    @IBAction func tapGroup(_ sender: UIButton) {
        paperPlane.removeAllAnimations()
        paperPlane.isHidden = false
        animationLayer.isHidden = true
        
        let flyAnimation = pathAnimation(origin: paperPlane.position)
        let zoomAnimation = scaleAnimation()
        let zoomAnimation2 = scaleAnimation2()

        let group = CAAnimationGroup()
        group.animations = [flyAnimation, zoomAnimation, zoomAnimation2]
        group.duration = 2.7
        paperPlane.add(group, forKey: nil)
    }
    
    private func setupAnimationLayer() {
        let layer = CALayer()
        layer.frame = CGRect(x: UIScreen.main.bounds.size.width / 2.0 - 100.0,
                             y: UIScreen.main.bounds.size.height / 2.0 - 100.0,
                             width: 200.0,
                             height: 200.0)
        view.layer.addSublayer(layer)
        layer.cornerRadius = 100.0
        layer.masksToBounds = true
        layer.backgroundColor = UIColor.red.cgColor
        animationLayer = layer
        layer.isHidden = true
    }
    
    private func setupPaperPlane() {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 100, y: 50))
        path.addLine(to: CGPoint(x: 23, y: 18))
        path.addLine(to: CGPoint(x: 25, y: 40))
        path.addLine(to: CGPoint(x: 100, y: 50))
        path.addLine(to: CGPoint(x: 18, y: 55))
        path.addLine(to: CGPoint(x: 3, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 50))
        path.addLine(to: CGPoint(x: 45, y: 95))
        path.addLine(to: CGPoint(x: 40, y: 82))
        path.move(to: CGPoint(x: 25, y: 40))
        path.addLine(to: CGPoint(x: 35, y: 55))
        let layer = CAShapeLayer()
        layer.path = path
        layer.strokeColor = UIColor.gray.cgColor
        layer.fillColor = UIColor.white.cgColor
        layer.lineWidth = 2.1
        layer.lineJoin = .round
        view.layer.addSublayer(layer)
        layer.position = CGPoint(x: 20, y: 200)
        paperPlane = layer
    }
    
    private func pathAnimation(origin: CGPoint) -> CAAnimation {
        let animation = CAKeyframeAnimation(keyPath: "position")
        let bezierPath = UIBezierPath()
        bezierPath.move(to: origin)
        let endPoint = CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height - 100)
        bezierPath.addCurve(to: endPoint, controlPoint1: CGPoint(x: 300, y: 300), controlPoint2: CGPoint(x: 80, y: 440))
        animation.path = bezierPath.cgPath
        animation.duration = 2.7
        animation.calculationMode = .cubic
        animation.rotationMode = .rotateAuto
        
        return animation
    }
    
    private func scaleAnimation() -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 1.2
        animation.toValue = 0.5
        
        return animation
    }
    
    private func scaleAnimation2() -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 1.5
        animation.beginTime = 1.2
        animation.fromValue = 0.5
        animation.toValue = 0.35
        
        return animation
    }
}

extension AnimatioinViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let layer = animationLayer, let animation = anim as? CABasicAnimation {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            layer.backgroundColor = (animation.toValue as! CGColor)
            CATransaction.commit()
        } else if let layer = animationLayer, let animation = anim as? CAKeyframeAnimation {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            layer.backgroundColor = (animation.values?.last as! CGColor)
            CATransaction.commit()
        }

    }
}
