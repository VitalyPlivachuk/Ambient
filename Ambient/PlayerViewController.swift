//
//  ViewController.swift
//  Ambient
//
//  Created by Vitaly Plivachuk on 06.07.17.
//  Copyright © 2017 Vitaly Plivachuk. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import UserNotifications

class PlayerViewController: UIViewController {
    
    
    
    func setup() {
        NotificationCenter.default.removeObserver(self)
        let nextNotification = Notification(name: Notification.Name(rawValue: "playNextSound \(self.soundName)"))
        let previousNotification = Notification(name: Notification.Name(rawValue: "playPreviousSound \(self.soundName)"))
        NotificationCenter.default.addObserver(self, selector: #selector(nextButtonTapDetected), name: nextNotification.name, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(backButtonTapDetected), name: previousNotification.name, object: nil)
    }
    
    
    
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
        globalSoundPlayer.play()
        setUpControls()
    }
    
    func backButtonTapDetected() {
        print("back Clicked")
        if globalSoundIndex > 0{
            globalSoundIndex -= 1
            updateViewContent()
            setUpControls()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "timerSegue"
        {
            let destination = segue.destination as! TimerSetupViewController
            destination.playerViewController = self
        }
    }
    
    func likeButtonTapDetected() {
        print("like Clicked")
        if self == activePlayerViewController{
            if globalSoundArray[globalSoundIndex].isFavorite {
                globalSoundArray[globalSoundIndex].isFavorite = false
                likeButtonImageView.image = UIImage(named: "likeWhite")
            } else {
                globalSoundArray[globalSoundIndex].isFavorite = true
                likeButtonImageView.image = UIImage(named: "likeBlack")
            }
        }
        listViewController.tableView.reloadData()
    }
    
    func pauseButtonTapDetected() {
        print("pause Clicked")
        if globalSoundPlayer.isPlaying{
            globalSoundPlayer.pause()
        }
    }
    
    
    func nextButtonTapDetected() {
        if self == activePlayerViewController{
            print("next Clicked")
            if globalSoundIndex < globalSoundArray.count - 1{
                globalSoundIndex += 1
                PlaybackControl.startPlaySound(sender: self)
                updateViewContent()
                setUpControls()
            }
        }
        
        nextTrackNotification(inSeconds: 1) { (success) in
            if success {
            print("sended")
            } else {
                print ("not sended")
            }
        }
        
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
        
        updateViewContent()
        
        print(self)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func updateViewContent() {
        soundName = globalSoundArray[globalSoundIndex].name!
        soundFileName = globalSoundArray[globalSoundIndex].fileName!
        soundPicture = globalSoundArray[globalSoundIndex].image!
        soundIsFavorite = globalSoundArray[globalSoundIndex].isFavorite
        
        soundNameLabel.text = soundName
        pictureImageViewController.image = soundPicture
        
        if globalSoundArray[globalSoundIndex].isFavorite{
            likeButtonImageView.image = UIImage(named: "likeBlack")
        } else {
            likeButtonImageView.image = UIImage(named: "likeWhite")
        }
        
        PlaybackControl.startPlaySound(sender: self)
        
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch{
            print(error)
        }
        
        setUpControls()
        setup()
        
    }
    
    func runTimer(forSeconds seconds: Double) {
        timer = Timer.scheduledTimer(timeInterval: seconds, target: self,   selector: (#selector(self.pauseButtonTapDetected)), userInfo: nil, repeats: false)
    }
    
    func nextTrackNotification(inSeconds seconds: TimeInterval, completion: (Bool) -> ()) {
        
        removeNotifications(identifiers: ["playing next sound"])
        
        
        let date = Date(timeIntervalSinceNow: seconds)
        print(Date())
        print(date)
        
        let content = UNMutableNotificationContent()
        content.title = "Entering in another ambient"
        content.body = globalSoundArray[globalSoundIndex].name!
        content.sound = UNNotificationSound.default()
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "playing next sound", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
        
    }
    
    func removeNotifications(identifiers: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    func setUpControls() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyTitle: soundName,
            MPMediaItemPropertyAlbumTitle: "",
            MPMediaItemPropertyArtist: "",
            MPMediaItemPropertyPlaybackDuration: globalSoundPlayer.duration]
        MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(image: soundPicture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        activePlayerViewController = self
    }
    
    
    
}

