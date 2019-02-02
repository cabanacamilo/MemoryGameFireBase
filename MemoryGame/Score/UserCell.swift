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
    
    func configure(with user: User) {
        profileEmail.text = user.email
        profileUser.text = user.user
        profilePhoto.image = UIImage(named: "user")
        profilePhoto.layer.cornerRadius = profilePhoto.bounds.height / 2
        profilePhoto.clipsToBounds = true
        profilePhoto.loadImageUsingCache(urlString: user.photoUser)
        profileScore.text = user.score
    }

}
