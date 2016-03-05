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
    
    var current_clip : Clip?
    
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
    
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] self.current_song?.title => \(self.current_song?.title)")
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] self.current_clip?.title => \(self.current_clip?.title)")

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
        viewWillDisappear__SaveBM(item_name, bm_time: Int((player?.currentTime().seconds)!))
    
        //  background play
        UIApplication.sharedApplication().endReceivingRemoteControlEvents()
    
        /*
            save history
        */
        viewWillDisappear__SaveHistory(item_name, bm_time: Int((player?.currentTime().seconds)!))

        do {
            
            try AVAudioSession.sharedInstance().setActive(false)
            
        } catch let e as NSError {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] NSError => \(e.description)")
            
        } catch {

            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] other errors")

        }
    
        // set --> current time
        //    CONS.current_time = bm.bm_time
        CONS.current_time = Int((player?.currentTime().seconds)!)
    
    }

    func viewWillDisappear__SaveHistory
        //    (item_name : String, bm_time : Int, audio_url : NSURL) {
        (item_name : String, bm_time : Int) {

            /*
                validate: latest history --> same clip
            */
            let ph_latest = Proj.find_PH__Latest()
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] ph_latest.description => \(ph_latest.description)")

            /*
                dispatch
                1. ph_latest.id => -1   ==> no history --> save history
                2. ph_latest.title == item_name ==> update the record
                3. ph_latest.title != item_name ==> different record
                                                --> save history
            */
            if ph_latest.id == -1 {

                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] ph_latest.id == -1 --> saving ph...")

                self._viewWillDisappear__SaveHistory__SavePH(item_name, bm_time: bm_time)
                
            } else if ph_latest.title != item_name {

                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] ph_latest.title != item_name --> saving ph...")

                self._viewWillDisappear__SaveHistory__SavePH(item_name, bm_time: bm_time)
                
            } else if ph_latest.title == item_name {

                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] ph_latest.title == item_name --> not saving ph...")

            } else {

                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] viewWillDisappear__SaveHistory: unknown case --> ph => \(ph_latest.description)")

            }
            
//            // url
//            //        let audio_url = self.current_song!.valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL
//            
//            let audio_url = NSURL(fileURLWithPath: (self.current_clip?.audio_id)!)
//            
//            
//            Proj.add_BM(item_name, bm_time: bm_time, audio_url: audio_url)
            
    }
    
    func _viewWillDisappear__SaveHistory__SavePH
    (item_name : String, bm_time : Int) {
        
        // build: PH
        let ph = PH()
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] calling => Proj.lastId_PH()")

        ph.id = Proj.lastId_PH()
        
        // time
        let t_label = Methods.get_TimeLable()
        
        ph.created_at   = t_label
        ph.modified_at  = t_label
        
        ph.title        = item_name

//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] clip => \(self.current_clip?.description)")
        
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] setting => self.current_clip?.audio_id")
        
        ph.audio_id     = (self.current_clip?.audio_id)!

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] setting => ph.memo")

        ph.memo         = (self.current_clip?.memos)!

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] ph.memo => set")

        ph.current_time = bm_time
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] saving PH => (\(ph.description)")

//        // save
//        let res = Proj.save_PH(ph)
//
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] Proj.save_PH(ph) => (\(res)")

        
    }//_viewWillDisappear__SaveHistory__SavePH

    func viewWillDisappear__SaveBM
//    (item_name : String, bm_time : Int, audio_url : NSURL) {
     (item_name : String, bm_time : Int) {
    
        // validate: pref --> true
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //        var dfltVal_DebugMode = defaults.valueForKey(CONS.defaultKeys.key_Set_DebugMode)
        let dfltVal_AddBM = defaults.valueForKey(CONS.defaultKeys.key_Pref_AddBM)

        if dfltVal_AddBM?.boolValue == false {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_AddBM => false; not saving BM")
            
            return
            
        }
        
        // url
//        let audio_url = self.current_song!.valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL

        let audio_url = NSURL(fileURLWithPath: (self.current_clip?.audio_id)!)

        
        Proj.add_BM(item_name, bm_time: bm_time, audio_url: audio_url)
        
    }
    
    // 音楽を再生する
    func playMusic(url: NSURL) {

        player = AVPlayer(URL: url)

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
