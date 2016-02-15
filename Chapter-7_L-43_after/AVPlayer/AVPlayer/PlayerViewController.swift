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

    //debug
    print("[\(Methods.basename(__FILE__)):\(__LINE__)] Int((player?.currentTime().seconds)!) => \(Int((player?.currentTime().seconds)!))")

    /*

        save data

    */
    // realm
    let rl_tmp = Methods.get_RealmInstance(CONS.s_Realm_FileName)
//    let rl_tmp = Methods.get_RealmInstance("abc.realm")
    
    // BM instance
    let bm = BM()
    
    bm.title = item_name
    bm.bm_time = Int((player?.currentTime().seconds)!)
    let tmp_time = NSDate()
    
    bm.created_at = tmp_time
    bm.modified_at = tmp_time
    
    bm.id = Methods.lastId()
    
    //ref https://realm.io/docs/swift/latest/#adding-objects "Adding Objects"
    //ref https://mynavi-agent.jp/it/geekroid/2015/07/realm-2-realmswift-.html
    try! rl_tmp.write {
        
//        self.realm.add(self.diary, update: true)
        
        
        rl_tmp.add(bm, update: true)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm => written (bm_time => \(bm.bm_time) (\(bm.title))")

        
    }
    
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
