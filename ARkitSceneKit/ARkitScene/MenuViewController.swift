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
    @IBOutlet weak var wonderWomanSad: UIImageView!
    @IBOutlet weak var cameraPermissionButton: UIButton!
    @IBOutlet weak var missionObjectiveLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        nextButton.alpha = 0.0
        nextButton.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraPermissionButton(_ sender: Any) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { (success) in
            
            DispatchQueue.main.async {
                
                self.nextButton.isHidden = false
                
                self.missionObjectiveLabel.text = "MISSION SUCCESS!"
                self.otherLabel.text = ""
                
                UIView.animate(withDuration: 1, animations: {
                    self.missionObjectiveLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                    self.wonderWomanHappy.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                    self.wonderWomanSad.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                    
                    self.wonderWomanHappy.alpha = 0.5
                    self.wonderWomanSad.alpha = 0.5
                    self.cameraPermissionButton.alpha = 0.5
                })
                
                UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                    self.missionObjectiveLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 20)
                    self.wonderWomanHappy.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 20)
                    self.wonderWomanSad.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 20)
                    
                    self.wonderWomanHappy.alpha = 1
                    self.wonderWomanSad.alpha = 0
                    self.cameraPermissionButton.alpha = 0
                    self.nextButton.alpha = 1.0
                }, completion: nil)
            }
        }
    }
}
