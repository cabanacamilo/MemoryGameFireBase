//
//  UserCell.swift
//  MemoryGame
//
//  Created by Camilo Cabana on 12/8/18.
//  Copyright © 2018 Camilo Cabana. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var profileScore: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var profileUser: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profilePhoto.layer.cornerRadius = profilePhoto.bounds.height / 2
        profilePhoto.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
