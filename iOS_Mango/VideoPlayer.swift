//
//  VideoPlayer.swift
//  iOS_Mango
//
//  Created by Joshua O'Connor on 5/18/16.
//  Copyright © 2016 Joshua O'Connor. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

var controlButton: UIButton = UIButton()

class VideoPlayer: UIView {
    
    var contentURL: NSURL?
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var isPaused: Bool!

    
    // MARK: Initialization
    
    init(frame: CGRect, contentURL: NSURL) {
        self.contentURL = contentURL
        isPaused = false
        
        super.init(frame: frame)
        
        self.setUpPlayer()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setUpPlayer() {

        self.backgroundColor = UIColor.blackColor()
        
        controlButton = UIButton(frame: self.frame)
        controlButton.addTarget(self, action: #selector(VideoPlayer.controlButtonTapped), forControlEvents: .TouchUpInside)
        self.addSubview(controlButton)


        player = AVPlayer(URL: self.contentURL!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.bounds
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(VideoPlayer.playerItemDidReachEnd(_:)),
                                                         name: AVPlayerItemDidPlayToEndTimeNotification,
                                                         object: player.currentItem)
        
        self.layer.addSublayer(playerLayer)
        player.play()
    }
    
    
    // MARK: Player Methods
    
    func playerItemDidReachEnd(notification: NSNotification) {
        player.seekToTime(kCMTimeZero)
        player.play()
    }
    
    func controlButtonTapped() {
        if (isPaused == false){
            self.pauseVideo()
        }
        else{
            self.playVideo()
        }
    }
    
    func terminateVideo(){
        self.pauseVideo()
        playerLayer.removeFromSuperlayer()
    }
    
    func pauseVideo() {
        isPaused = true
        player.pause()
    }
    
    func playVideo() {
        player.play()
        isPaused = false
    }
}



