//
//  SoundManager.swift
//  MemoryGame
//
//  Created by Camilo Cabana on 11/10/18.
//  Copyright © 2018 Camilo Cabana. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager
{
    var audioPlayer: AVAudioPlayer?
    
    enum SoundEffect
    {
        case flip
        case shuffle
        case match
        case noMatch
    }
    func playSound(_ effect: SoundEffect)
    {
        var soundFileName = ""
        switch effect
        {
        case .flip:
            soundFileName = "cardflip"
            
        case .match:
            soundFileName = "dingcorrect"
            
        case .noMatch:
            soundFileName = "dingwrong"
            
        case .shuffle:
            soundFileName = "shuffle"
        }
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: "wav")
        guard bundlePath != nil else {
            print("Could not find sound file \(soundFileName) in the bundle")
            return
        }
        let soundURL = URL(fileURLWithPath: bundlePath!)
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        }
        catch
        {
            print("Could not create the player object for sound file \(soundFileName)")
        }
    }
}
