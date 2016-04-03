//
//  PlayerVC.swift
//  avplayer
//
//  Created by mac on 2016/02/26.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

//import Cocoa
import UIKit
import AVKit
import AVFoundation
import RealmSwift
import MediaPlayer

//class PlayerVC: AVPlayerViewController {
class PVC: AVPlayerViewController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] viewWillAppear()")
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        player?.pause()
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] player => paused")
        
        
    }

    // 音楽を再生する
    func playMusic(url: NSURL) {
        
        player = AVPlayer(URL: url)
        
//        // background play
//        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//        
//        try! AVAudioSession.sharedInstance().setActive(true)
//        
//        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        
        player?.play()
        
    }

}
