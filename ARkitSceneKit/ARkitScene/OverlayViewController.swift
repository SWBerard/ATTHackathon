//
//  MenuViewController.swift
//  ARkitScene
//
//  Created by Steven Berard on 7/8/17.
//  Copyright © 2017 josh. All rights reserved.
//

import UIKit

protocol MenuDelegate: class {
    func userWantsToToggleDebugView()
    func userTappedOverlayView(_ sender: UITapGestureRecognizer)
    func userPinchedOverlayView(_ sender: UIPinchGestureRecognizer)
    func userPannedView(_ sender: UIPanGestureRecognizer)
}

class OverlayViewController: UIViewController {
    
    weak var delegate: MenuDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func userTappedDebugButton(_ sender: Any) {
        delegate?.userWantsToToggleDebugView()
    }
    
    @IBAction func userTappedView(_ sender: UITapGestureRecognizer) {
        delegate?.userTappedOverlayView(sender)
    }
    
    @IBAction func userPinchedView(_ sender: UIPinchGestureRecognizer) {
        delegate?.userPinchedOverlayView(sender)
    }
    
    @IBAction func userPannedView(_ sender: UIPanGestureRecognizer) {
        delegate?.userPannedView(sender)
    }
}
