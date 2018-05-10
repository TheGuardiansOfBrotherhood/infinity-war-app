//
//  ViewController.swift
//  InfinityWarApp
//
//  Created by Roger Silva on 28/04/2018.
//  Copyright © 2018 The Guardians Of Brotherhood. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var body: Body?
    let charactersUrl = PListHelper().getInfo(filename: "Url", key: "characters")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        
        do {
            activityIndicator.startAnimating()
            try NetworkingHelper().startLoad(Body.self, "\(charactersUrl)", funcSucess, funcError)
        } catch {
            funcAlert(alertMessage: "Error Body not is Decodable")
            activityIndicator.stopAnimating()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func funcSucess(body: Body)  {
        DispatchQueue.main.async {
            self.body = body
            // reload component
            // self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func funcError(error: NetworkingHelperError)  {
        DispatchQueue.main.async {
            switch error {
            case NetworkingHelperError.RequestError:
                self.funcAlert(alertMessage: "Error requesting")
            case NetworkingHelperError.HttpStatusError:
                self.funcAlert(alertMessage: "Error HTTP Status")
            case NetworkingHelperError.SerializationJsonError:
                self.funcAlert(alertMessage: "Error serialization JSON")
            }
            self.activityIndicator.stopAnimating()
        }
    }
    
    func funcAlert(alertMessage: String) {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
