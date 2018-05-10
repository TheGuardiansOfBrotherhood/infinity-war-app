//
//  LogInController.swift
//  InfinityWarApp
//
//  Created by Jackson Castro on 5/9/18.
//  Copyright © 2018 The Guardians Of Brotherhood. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class LogInController : UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
        
    }
    
    @IBAction func LogInAction(_ sender: Any) {
        guard let username = emailField.text else {return}
        guard let password = passwordField.text else {return}
        
        print("Aqui" + username + " " + password)
    }
}
