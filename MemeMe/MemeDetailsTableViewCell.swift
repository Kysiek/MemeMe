//
//  MemeDetailsTableViewCell.swift
//  MemeMe
//
//  Created by Krzysztof Maciążek on 27/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

class MemeDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeText: UILabel!
    
    func setMemeImage(memeImage: UIImage) {
        memeImageView.image = memeImage
    }
    
    func setMemeText(topText: String, bottomText: String) {
        memeText.text = "\(topText)...\(bottomText)"
    }
    
}
