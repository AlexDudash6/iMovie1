//
//  MusicManager.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 3/26/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import AVFoundation

class MusicManager {
    
    var player: AVAudioPlayer!
    
    static let sharedInstance = MusicManager()
    
    private init() {}
    
    func playSound(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.volume = 0.2
            player.play()
            
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopSound() {
        player.stop()
    }
    
}
