//
//  DetailCharacterViewController.swift
//  InfinityWarApp
//
//  Created by Roger Silva on 11/05/2018.
//  Copyright © 2018 The Guardians Of Brotherhood. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DetailCharacterViewController: UIViewController {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    var ref: DatabaseReference!

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var body: Body?
    var characterId: Int = 0
    let characterUrl = PListHelper().getInfo(filename: "Url", key: "character")
    let user = Auth.auth().currentUser
    var isFavorite: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()

        if let user = user {
            ref.child("users").child(user.uid).child("favorites").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as! NSArray
                self.isFavorite = value.contains(self.characterId)
                self.favoriteButton.isFavorite(self.isFavorite)
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)

        do {
            activityIndicator.startAnimating()
            let finalUrl = characterUrl.replacingOccurrences(of: "{characterId}", with: "\(characterId)")
            try NetworkingHelper().startLoad(Body.self, "\(finalUrl)", funcSucess, funcError)
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
            self.reload()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func reload() {
        if let result = body {
            let character = result.data.results[0]
            nameLabel.text = character.name
            descriptionLabel.text = character.description
            thumbnailImageView.downloadedFrom(link: "\(character.thumbnail.path).\(character.thumbnail.extension)")
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
    
    @IBAction func favoriteAction(_ sender: UIButton) {

        if let user = user {
            ref.child("users").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let favorites = value?["favorites"] as? [Int]
                if var favorites = favorites {
                    
                    if (self.isFavorite) {
                        favorites = favorites.filter {$0 != self.characterId}
                    } else {
                        favorites.append(self.characterId)
                    }
                    self.isFavorite = !self.isFavorite
                    self.favoriteButton.isFavorite(self.isFavorite)
                    self.ref.child("users/\(user.uid)/favorites").setValue(favorites)
                    self.funcAlert(alertMessage: "Update with success")
                }

            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
}

extension UIButton {

    func isFavorite(_ value: Bool) {
        switch value {
        case true:
            if let image = UIImage(named: "star_on.png") {
                self.setImage(image, for: .normal)
            }
        default:
            if let image = UIImage(named: "star_off.png") {
                self.setImage(image, for: .normal)
            }
        }
    }
}
