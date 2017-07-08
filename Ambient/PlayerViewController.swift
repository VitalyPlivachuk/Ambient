//
//  ViewController.swift
//  Ambient
//
//  Created by Vitaly Plivachuk on 06.07.17.
//  Copyright © 2017 Vitaly Plivachuk. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    
    var soundName = String()
    var soundFileName = String()
    var soundPicture = UIImage()
    var soundIsFavorite = Bool()
    
    var soundPlayer = AVAudioPlayer()
    var listViewController = SoundsListTableViewController()
    
    //MARK:Outlets
    @IBOutlet weak var playButtonImageView: UIImageView!
    @IBOutlet weak var backButtonImageView: UIImageView!
    @IBOutlet weak var likeButtonImageView: UIImageView!
    @IBOutlet weak var pauseButtonImageView: UIImageView!
    @IBOutlet weak var nextButtonImageView: UIImageView!
    @IBOutlet weak var pictureImageViewController: UIImageView!
    @IBOutlet weak var soundNameLabel: UILabel!

    
    //Action
    func playButtonTapDetected() {
        print("play Clicked")
        soundPlayer.play()
    }
    
    func backButtonTapDetected() {
        print("back Clicked")
    }
    
    func likeButtonTapDetected() {
        print("like Clicked")
    }
    
    func pauseButtonTapDetected() {
        print("pause Clicked")
        if soundPlayer.isPlaying{
            soundPlayer.pause()
        }
    }
    
    func nextButtonTapDetected() {
        print("next Clicked")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let playTap = UITapGestureRecognizer(target: self, action: #selector(PlayerViewController.playButtonTapDetected))
        playTap.numberOfTapsRequired = 1 // you can change this value
        playButtonImageView.addGestureRecognizer(playTap)
        
        let backTap = UITapGestureRecognizer(target: self, action: #selector(PlayerViewController.backButtonTapDetected))
        backTap.numberOfTapsRequired = 1 // you can change this value
        backButtonImageView.addGestureRecognizer(backTap)
        
        let likeTap = UITapGestureRecognizer(target: self, action: #selector(PlayerViewController.likeButtonTapDetected))
        likeTap.numberOfTapsRequired = 1 // you can change this value
        likeButtonImageView.addGestureRecognizer(likeTap)
        
        let pauseTap = UITapGestureRecognizer(target: self, action: #selector(PlayerViewController.pauseButtonTapDetected))
        pauseTap.numberOfTapsRequired = 1 // you can change this value
        pauseButtonImageView.addGestureRecognizer(pauseTap)
        
        let nextTap = UITapGestureRecognizer(target: self, action: #selector(PlayerViewController.nextButtonTapDetected))
        nextTap.numberOfTapsRequired = 1 // you can change this value
        nextButtonImageView.addGestureRecognizer(nextTap)
        
        //soundNameLabel.text = soundName
        soundNameLabel.text = listViewController.soundsArray[(listViewController.tableView.indexPathForSelectedRow?.row)!].name
        
        pictureImageViewController.image = soundPicture

        
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: soundFileName, ofType: "mp3")!))
            soundPlayer.prepareToPlay()
            var audioSession = AVAudioSession.sharedInstance()
            
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            } catch{
                
            }
            
        } catch {
            print(error)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

