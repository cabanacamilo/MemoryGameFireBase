//
//  User.swift
//  MemoryGame
//
//  Created by Camilo Cabana on 11/17/18.
//  Copyright © 2018 Camilo Cabana. All rights reserved.
//

import Foundation

class User
{
    var email: String = ""
    var user = ""
    var password = ""
    var photoUser = ""
    var flips = 1001
    
    var score: String {
        return hasPlayed ? "\(flips)" : ""
    }
    
    var hasPlayed: Bool {
        return flips < 1000
    }
}
