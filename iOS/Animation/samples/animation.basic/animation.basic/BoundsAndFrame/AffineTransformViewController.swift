//
//  AffineTransformViewController.swift
//  animation.basic
//
//  Created by jhunter on 2019/4/26.
//  Copyright © 2019 mobile.knowledge.map. All rights reserved.
//

import UIKit

class AffineTransformViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var presentationView: UIView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupPresentationView()
    }

    // MARK: - Event handler
    @IBAction func tapDiscard(_ sender: UIButton) {
        presentationView.transform = CGAffineTransform.identity
    }

    @IBAction func tapTranslation(_ sender: UIButton) {
        // 平移100, 100
        let transform = CGAffineTransform(translationX: 100, y: 100)
        presentationView.transform = transform
    }
    
    @IBAction func tapRotation(_ sender: UIButton) {
        // 旋转45°
        let transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) / 4)
        presentationView.transform = transform
    }
    
    @IBAction func tapScale(_ sender: UIButton) {
        // 缩小，比例是75%, 50%
        let transform = CGAffineTransform(scaleX: 0.75, y: 0.5)
        presentationView.transform = transform
    }
    
    @IBAction func tapMakeTransform(_ sender: UIButton) {
        // 平移0，100，同时旋转45°
        let quaterOfPi = CGFloat(Double.pi) / 4
        let transform = CGAffineTransform(a: quaterOfPi, b: quaterOfPi, c: -quaterOfPi, d: quaterOfPi, tx: 0, ty: 100)
        presentationView.transform = transform
    }
    
    @IBAction func tap3DX(_ sender: UIButton) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / 800
        transform = CATransform3DRotate(transform, CGFloat(Float.pi) / 4, 1, 0, 0)
        presentationView.layer.transform = transform
    }
    
    @IBAction func tap3DY(_ sender: UIButton) {
    }
    
    @IBAction func tap3DZ(_ sender: UIButton) {
    }
    
    // MARK: - Private methods
    private func setupPresentationView() {
        if let image: UIImage = UIImage(named: "transform.demo") {
            presentationView.layer.contents = image.cgImage
        }
    }
}
