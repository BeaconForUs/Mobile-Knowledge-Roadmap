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
        presentationView.layer.transform = CATransform3D(m11: <#T##CGFloat#>, m12: <#T##CGFloat#>, m13: <#T##CGFloat#>, m14: <#T##CGFloat#>, m21: <#T##CGFloat#>, m22: <#T##CGFloat#>, m23: <#T##CGFloat#>, m24: <#T##CGFloat#>, m31: <#T##CGFloat#>, m32: <#T##CGFloat#>, m33: <#T##CGFloat#>, m34: <#T##CGFloat#>, m41: <#T##CGFloat#>, m42: <#T##CGFloat#>, m43: <#T##CGFloat#>, m44: <#T##CGFloat#>)
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
    
    // MARK: - Private methods
    private func setupPresentationView() {
        if let image: UIImage = UIImage(named: "transform.demo") {
            presentationView.layer.contents = image.cgImage
        }
    }
}
