//
//  MenuViewController.swift
//  InfinityWarApp
//
//  Created by Jackson Castro on 5/9/18.
//  Copyright © 2018 The Guardians Of Brotherhood. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController : UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var marvelImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.image = UIImage(named: "background")
        marvelImageView.image = UIImage(named: "marvel-icon")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
