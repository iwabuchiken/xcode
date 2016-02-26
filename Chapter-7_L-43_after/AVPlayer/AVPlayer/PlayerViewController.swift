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
import MediaPlayer

class PlayerViewController: AVPlayerViewController {

    var item_name : String!

    var seekTime : CMTime?
    
    var current_song : MPMediaItem?
    
// MARK: View-related methods
  override func viewDidLoad() {
        super.viewDidLoad()
        
        // NavigationBar の戻るボタンを消す
        self.navigationItem.setHidesBackButton(true, animated:false)
    
        // tab bar => hide
        //ref http://stackoverflow.com/questions/32465415/how-do-you-hide-a-tab-bar-in-xcode-swift answered Sep 9 '15 at 0:11
    
//        self.definesPresentationContext = true
        self.definesPresentationContext = false
    
        self.tabBarController?.tabBar.hidden = true
    
        // hide => nav bar
        //ref http://stackoverflow.com/questions/31507676/swift-xcode-hide-navigation-bar-for-specific-view answered Jul 20 '15 at 1:25
        self.navigationController?.navigationBarHidden = true
    
//        // show "done" button

    
        //ref http://stackoverflow.com/questions/31812142/swift-avplayer-has-no-done-button answered Aug 4 '15 at 14:48
//        let playerVC = AVPlayerViewController()
////        playerVC.player = AVPlayer(URL: NSURL(string: "http://www.ebookfrenzy.com/ios_book/movie/movie.mov")!)
//        self.presentViewController(playerVC, animated: true, completion: nil)
    
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] self.current_song?.title => \(self.current_song?.title)")

    
    
    }
    
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
   
    //debug
    print("[\(Methods.basename(__FILE__)):\(__LINE__)] viewWillAppear()")

    
  }

  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    player?.pause()

    //debug
    print("[\(Methods.basename(__FILE__)):\(__LINE__)] player?.description => \(player?.description)")
    
    
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
    
    //debug
    print("[\(Methods.basename(__FILE__)):\(__LINE__)] item_name => \(item_name)")

    
    bm.bm_time = Int((player?.currentTime().seconds)!)
    let tmp_time = NSDate()
    
//    bm.created_at = tmp_time
//    bm.modified_at = tmp_time
    bm.created_at = Methods.conv_NSDate_2_DateString(tmp_time)
    bm.modified_at = Methods.conv_NSDate_2_DateString(tmp_time)
    
    //debug
    print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm.modified_at => set")

    
    bm.id = Methods.lastId()
    
    // audio id
    let url = self.current_song!.valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL
    
    
//    //debug
//    print("[\(Methods.basename(__FILE__)):\(__LINE__)] url?.absoluteString => \(url?.absoluteString)")

    bm.audio_id = (url?.absoluteString)!

    //debug
    print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm.audio_id => \(bm.audio_id)")

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
    
    //debug
    print("[\(Methods.basename(__FILE__)):\(__LINE__)] done => UIApplication.sharedApplication().endReceivingRemoteControlEvents()")
    
    
//    try! AVAudioSession.sharedInstance().setActive(false)
    try! AVAudioSession.sharedInstance().setActive(false)
    
    // set --> current time
    CONS.current_time = bm.bm_time
    
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
    
//    // show "done" button
//    let playerVC = AVPlayerViewController()
//    //        playerVC.player = AVPlayer(URL: NSURL(string: "http://www.ebookfrenzy.com/ios_book/movie/movie.mov")!)
//    playerVC.player = AVPlayer(URL: url)
//    player = playerVC.player
//    
//    self.presentViewController(playerVC, animated: true, completion: nil)

//    self.presentViewController(self, animated: true, completion: nil)
        //    2016-02-15 18:56:11.585 AVPlayer[6825:2918740] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'Application tried to present modal view controller on itself. Presenting controller is <AVPlayer.PlayerViewController: 0x13e846800>.'
    
    //debug
    print("[\(Methods.basename(__FILE__)):\(__LINE__)] item_name => \(item_name)")
    
    
    //ref http://dev.digitrick.us/notes/LoopingVideoWithAVFoundation
    var seekTime : CMTime = CMTimeMake(10, 1)
  
    //debug
    print("[\(Methods.basename(__FILE__)):\(__LINE__)] self.seekTime => \(self.seekTime)")
    
    
    // seek time preset?
    if self.seekTime != nil {
        
        seekTime = self.seekTime!
        
    }
    
    
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
