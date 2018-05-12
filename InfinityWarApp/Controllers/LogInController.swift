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

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView.image = UIImage(named: "background-logan")
        
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    @IBAction func LogInAction(_ sender: Any) {
        guard let email = emailField.text else {return}
        guard let password = passwordField.text else {return}

        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.funcAlert(alertMessage: error.localizedDescription)
                return
            }
            self.performSegue(withIdentifier: "showLogin", sender: self)
        }
    }

    func funcAlert(alertMessage: String) {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
