//
//  ViewController.swift
//  NasaApp
//
//  Created by Artem Pavlov on 26.09.2021.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: Link.imageURL.rawValue) { result in
            switch result {
            case .success(let imageData):
                self.imageView.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

