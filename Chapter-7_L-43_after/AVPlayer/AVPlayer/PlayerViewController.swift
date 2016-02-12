//
//  PlayerViewController.swift
//  AVPlayer
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

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
    
    
    
  }
  
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
    
    
    player?.play()
  }
  
  // 動画を再生する
  func playMovie(playerItem: AVPlayerItem) {
    player = AVPlayer(playerItem: playerItem)
    player?.play()
  }
}
