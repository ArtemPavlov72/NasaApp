//
//  MarsRoverCell.swift
//  NasaApp
//
//  Created by Artem Pavlov on 26.09.2021.
//

import UIKit

class MarsRoverCell: UITableViewCell {
    
    @IBOutlet var marsRoverPhoto: UIImageView!
    @IBOutlet var nameOfRover: UILabel!
    @IBOutlet var idPhoto: UILabel!
    @IBOutlet var dateOfPhoto: UILabel!
    
    func configure(with rover: MarsRoverPhoto?) {
        nameOfRover.text = rover?.rover?.name
        idPhoto.text = "ID of Mars Rover: \(rover?.id ?? 0)"
        dateOfPhoto.text = "Date of photo: \(rover?.earthDate ?? "")"
        DispatchQueue.global().async {
            guard let url = URL(string: rover?.imgSrc ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.marsRoverPhoto.image = UIImage(data: imageData)
            }
        }
    }
}

   


