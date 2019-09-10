//
//  SoundManager.swift
//  MatchEm
//
//  Created by Yuren Wang on 9/6/19.
//  Copyright © 2019 Frederick Wang. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static var audioPlayer:AVAudioPlayer?
    
    enum SoundEffect {
    
        case flip
        case shuffle
        case match
        case nomatch
    }
    
    static func playSound(_ effect:SoundEffect) {
        
        var soundFilename = ""
        
        // determine sound filename
        switch effect {
            
        case .flip:
            soundFilename = "cardflip"
            
        case .match:
            soundFilename = "dingcorrect"
            
        case .nomatch:
            soundFilename = "dingwrong"
            
        case .shuffle:
            soundFilename = "shuffle"
        }
        
        // get the path to the sound file inside the bundle
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        
        guard bundlePath != nil else {
            print("Couldn't find source file \(soundFilename) in the bundle")
            return
        }
        
        // create a URL object from this string path
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        do {
            // create audio player object
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            audioPlayer?.play()
        }
        catch {
            // log error if audio player object cannot be created
            print("Couldn't create audio player from sound file \(soundFilename)")
        }
    }
    
}
