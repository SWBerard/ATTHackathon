//
//  MasterViewController.swift
//  ARkitScene
//
//  Created by Steven Berard on 7/8/17.
//  Copyright © 2017 josh. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    var menuVC: OverlayViewController?
    var arVC: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arVC?.toggleDebugView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let segueIdentifier = segue.identifier {
            switch segueIdentifier {
            case "menuEmbedSegue":
                menuVC = segue.destination as? OverlayViewController
                menuVC?.delegate = self
            case "ARViewEmbedSegue":
                arVC = segue.destination as? ViewController
            default:
                break
            }
        }
    }
}

extension MasterViewController: MenuDelegate {
    func userWantsToToggleDebugView() {
        arVC?.toggleDebugView()
    }
    
    func userTappedOverlayView(_ sender: UITapGestureRecognizer) {
        arVC?.tap(recognizer: sender)
    }
    
    func userPinchedOverlayView(_ sender: UIPinchGestureRecognizer) {
        arVC?.pinch(recognizer: sender)
    }
    
    func userPannedView(_ sender: UIPanGestureRecognizer) {
        arVC?.pan(recognizer: sender)
    }
}
