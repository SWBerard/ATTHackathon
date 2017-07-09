//
//  MenuViewController.swift
//  ARkitScene
//
//  Created by Steven Berard on 7/8/17.
//  Copyright © 2017 josh. All rights reserved.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {

    @IBOutlet weak var wonderWomanHappy: UIImageView!
    @IBOutlet weak var cameraPermissionButton: UIButton!
    @IBOutlet weak var otherLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var jokerImage: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        nextButton.alpha = 0.0
        nextButton.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        cameraPermissionButton.layer.cornerRadius = cameraPermissionButton.frame.height / 2
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
        wonderWomanHappy.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraPermissionButton(_ sender: Any) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { (success) in
            
            DispatchQueue.main.async {
                
                self.nextButton.isHidden = false
                
                self.otherLabel.text = ""
                
                UIView.animate(withDuration: 1, animations: {
                    self.wonderWomanHappy.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                    self.wonderWomanHappy.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

                    self.jokerImage.transform = CGAffineTransform(scaleX: 0, y: 0)

                    self.wonderWomanHappy.alpha = 0.5
                    self.cameraPermissionButton.alpha = 0.5
                })
                
                UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                    self.wonderWomanHappy.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 20)
                    self.wonderWomanHappy.transform = CGAffineTransform(scaleX: 1, y: 1)

                    self.wonderWomanHappy.alpha = 1
                    self.cameraPermissionButton.alpha = 0
                    self.nextButton.alpha = 1.0
                }, completion: nil)
            }
        }
    }
}
