//
//  CharacterViewController.swift
//  InfinityWarApp
//
//  Created by Roger Silva on 10/05/2018.
//  Copyright © 2018 The Guardians Of Brotherhood. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

class CharacterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var body: Body?
    let charactersUrl = PListHelper().getInfo(filename: "Url", key: "characters")
    
    @IBOutlet weak var characterTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterTableView.delegate = self
        characterTableView.dataSource = self
        
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
            self.characterTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let result = body {
            return result.data.results.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedIndex = indexPath.row
        let cell = characterTableView.dequeueReusableCell(withIdentifier: "characterCell") as! CharacterTableViewCell
        if let result = body {
            let character = result.data.results[selectedIndex]
            cell.nameLabel.text = character.name
            cell.thumbnailImageView.downloadedFrom(link: "\(character.thumbnail.path).\(character.thumbnail.extension)")
        }
        return cell
    }
}
