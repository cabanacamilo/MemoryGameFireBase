//
//  settingsCell.swift
//  MemoryGame
//
//  Created by Camilo Cabana on 1/26/19.
//  Copyright © 2019 Camilo Cabana. All rights reserved.
//

import UIKit

class settingsCell: UITableViewCell {
    
    @IBOutlet weak var currentUser: UILabel!
    @IBOutlet weak var currentUserPhoto: UIImageView!
    
    @IBOutlet weak var settingsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
