//
//  ViewController.swift
//  Menu
//
//  Created by Raghav Mangrola on 7/8/17.
//  Copyright © 2017 Raghav Mangrola. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var wonderWomanHappy: UIImageView!
    @IBOutlet weak var wonderWomanSad: UIImageView!
    @IBOutlet weak var cameraPermissionButton: UIButton!
    @IBOutlet weak var missionObjectiveLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cameraPermissionButton(_ sender: Any) {
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { (success) in

            DispatchQueue.main.async {

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
                }, completion: nil)
            }


        }
    }



}

