//
//  SignUpController.swift
//  InfinityWarApp
//
//  Created by Jackson Castro on 5/9/18.
//  Copyright © 2018 The Guardians Of Brotherhood. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class SignUpController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {

        super.viewDidLoad()

        userNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self

    }

    @IBAction func SignUpAction(_ sender: Any) {

        guard let userName = userNameField.text else {return}
        guard let email = emailField.text else {return}
        guard let password = passwordField.text else {return}

        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            user?.user.createProfileChangeRequest().displayName = userName

            // self.funcAlert(alertMessage: "User successfully registered")
            
            self.navigationController!.popViewController(animated: true)
            
        }
    }
    
    func funcAlert(alertMessage: String) {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
