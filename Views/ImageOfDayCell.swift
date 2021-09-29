//
//  ImageOfDayCell.swift
//  NasaApp
//
//  Created by iMac on 27.09.2021.
//

import UIKit

class ImageOfDayCell: UITableViewCell {

    @IBOutlet var imageOfDay: UIImageView!
    @IBOutlet var titleOfImage: UILabel!
    @IBOutlet var dateOfImage: UILabel!
    @IBOutlet var explanationOfImage: UILabel!
    
    func configure(with photoOfDay: PhotoOfToday?) {
        titleOfImage.text = "\(photoOfDay?.title ?? "")"
        dateOfImage.text = "Date: \(photoOfDay?.date ?? "")"
        explanationOfImage.text = "Explanation: \(photoOfDay?.explanation ?? "")"
        DispatchQueue.global().async {
            guard let url = URL(string: photoOfDay?.url ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.imageOfDay.image = UIImage(data: imageData)
            }
        }
    }
        
    }


