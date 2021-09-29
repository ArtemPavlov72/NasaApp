//
//  ViewController.swift
//  NasaApp
//
//  Created by iMac on 24.09.2021.
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
        DispatchQueue.global().async {
        guard let url = URL(string: Link.imageURL.rawValue) else {return}
        guard let imageData = try? Data(contentsOf: url) else { return }
        DispatchQueue.main.async {
            let image = UIImage(data: imageData)
            self.imageView.image = image
            self.activityIndicator.stopAnimating()
        }
        }
            /*
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            guard let image = UIImage(data: data) else {return}
            
            DispatchQueue.main.async {
                self.imageView.image = image
                self.activityIndicator.stopAnimating()
            }
        }.resume() */
    }
}

