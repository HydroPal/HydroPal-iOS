//
//  HelpViewController.swift
//  HydroPal
//
//  Created by Cheuk Lun Ko on 15/12/2016.
//  Copyright © 2016 Hydropal. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}
