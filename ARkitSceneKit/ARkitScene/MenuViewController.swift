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
}

class MenuViewController: UIViewController {
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
