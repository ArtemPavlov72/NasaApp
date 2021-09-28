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
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
