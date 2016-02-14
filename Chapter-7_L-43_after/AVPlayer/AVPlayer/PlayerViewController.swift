//
//  PlayerViewController.swift
//  AVPlayer
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import RealmSwift

class PlayerViewController: AVPlayerViewController {

    var item_name : String!
    
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }

  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    player?.pause()

    //debug
    print("[\(Methods.basename(__FILE__)):\(__LINE__)] player?.currentTime().value.description => \(player?.currentTime().value.description)")
    
    //debug
    print("[\(Methods.basename(__FILE__)):\(__LINE__)] player?.currentTime().seconds => \(player?.currentTime().seconds)")
    
    //  background play
    UIApplication.sharedApplication().endReceivingRemoteControlEvents()
    
    try! AVAudioSession.sharedInstance().setActive(false)
    
//    // save records
//    save_BM()
    
  }
    
//    func save_BM() {
//        
//        //ref https://realm.io/docs/swift/latest/ "Adding Objects"
//        let realm = try! Realm()
//        
////        let bm = BM()
//        let bm = BM_2()
//        
//        bm.title = item_name
//        
//        bm.bm_time = Int((player?.currentTime().seconds)!)
//        
//        try! realm.write {
//            
//            realm.add(bm)
//            
//            //debug
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm => saved (\(bm.title) / \(bm.bm_time))")
//            
//        }
//        
//        
//    }
//  
  // 音楽を再生する
  func playMusic(url: NSURL) {
    player = AVPlayer(URL: url)
    
    //debug
    print("[\(Methods.basename(__FILE__)):\(__LINE__)] item_name => \(item_name)")
    
    
    //ref http://dev.digitrick.us/notes/LoopingVideoWithAVFoundation
    let seekTime : CMTime = CMTimeMake(10, 1)
    
    player?.seekToTime(seekTime)
    
    //debug
    print("[\(Methods.basename(__FILE__)):\(__LINE__)] seekTime.value.value => \(seekTime.value.value)")
    
    // background play
    try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
    
    try! AVAudioSession.sharedInstance().setActive(true)
    
    UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
    
    player?.play()
  }
  
  // 動画を再生する
  func playMovie(playerItem: AVPlayerItem) {
    player = AVPlayer(playerItem: playerItem)
    player?.play()
  }
}
