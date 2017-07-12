//
//  Song.swift
//  Ambient
//
//  Created by Vitaly Plivachuk on 08.07.17.
//  Copyright © 2017 Vitaly Plivachuk. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MediaPlayer

var globalSoundArray = [AmbientSound]()
var globalSoundPlayer = AVAudioPlayer()
var globalSoundIndex = Int()
var playedAnyTime = false
let commandCenter = MPRemoteCommandCenter.shared()
var activePlayerViewController = PlayerViewController()
var timer = Timer()


class PlaybackControl {
    static func startPlaySound(sender: PlayerViewController) {
        if globalSoundPlayer != globalSoundArray[globalSoundIndex].player!{
            if playedAnyTime {
                if globalSoundPlayer.isPlaying{
                    globalSoundPlayer.pause()
                }
            }
            //globalSoundArray[globalSoundIndex].player?.delegate = sender
            globalSoundPlayer = globalSoundArray[globalSoundIndex].player!
            globalSoundPlayer.prepareToPlay()
            globalSoundPlayer.currentTime = 0
            globalSoundPlayer.play()
            playedAnyTime = true
        }
    }
    
    static func pausePlayback() {
        globalSoundPlayer.pause()
    }
    
    static func playNextSound(sender: PlayerViewController) {
        globalSoundIndex += 1
        startPlaySound(sender: sender)
    }
    
}

class AmbientSound {
    let name: String?
    let fileName: String?
    let image: UIImage?
    var isFavorite: Bool
    let player: AVAudioPlayer?
    
    init(name: String, fileName: String, image: UIImage, isFavorite: Bool) {
        self.name = name
        self.fileName = fileName
        self.image = image
        self.isFavorite = isFavorite
        
        let soundPath = URL.init(fileURLWithPath: Bundle.main.path(forResource: self.fileName, ofType: "mp3")!)
        
        do{
            self.player = try AVAudioPlayer(contentsOf: soundPath)
        } catch{
            self.player = nil
        }
        
        
        
    }
    
    
    
    
    
    
    static func defaultSoundsArray() -> [AmbientSound] {
        var soundsArray = [AmbientSound]()
        soundsArray.append(AmbientSound(name: "Morning Birds", fileName: "Birds", image: UIImage(named: "birds")!, isFavorite: false))
        soundsArray.append(AmbientSound(name: "Cat", fileName: "Cat", image: UIImage(named: "cat")!, isFavorite: false))
        soundsArray.append(AmbientSound(name: "Dolphins", fileName: "Dolphins", image: UIImage(named: "dolphins")!, isFavorite: false))
        soundsArray.append(AmbientSound(name: "Fire", fileName: "Fire", image: UIImage(named: "fire")!, isFavorite: false))
        soundsArray.append(AmbientSound(name: "Forest", fileName: "Forest", image: UIImage(named: "forest")!, isFavorite: false))
        soundsArray.append(AmbientSound(name: "Island", fileName: "Island", image: UIImage(named: "island")!, isFavorite: false))
        soundsArray.append(AmbientSound(name: "Night Forrest", fileName: "Night forest", image: UIImage(named: "night forest")!, isFavorite: false))
        soundsArray.append(AmbientSound(name: "Rain And Thunder", fileName: "Rain and thunder", image: UIImage(named: "rain and thunder")!, isFavorite: false))
        soundsArray.append(AmbientSound(name: "Sea", fileName: "Sea", image: UIImage(named: "sea")!, isFavorite: false))
        soundsArray.append(AmbientSound(name: "Tropic", fileName: "Tropic", image: UIImage(named: "tropic")!, isFavorite: false))
        soundsArray.append(AmbientSound(name: "Village Morning", fileName: "Village", image: UIImage(named: "village")!, isFavorite: false))
        soundsArray.append(AmbientSound(name: "Wolf", fileName: "Wolf", image: UIImage(named: "wolf")!, isFavorite: false))
        
        return(soundsArray)
    }
    
}
