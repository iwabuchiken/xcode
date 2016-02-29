//
//  Proj.swift
//  avplayer
//
//  Created by mac on 2016/02/26.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import Foundation
import MediaPlayer
import RealmSwift

class Proj {

    static func timeLabel_Addup
    (time_label : String, addup : Int) -> String {
    
        // conv: label --> Int
        let seconds = Methods.conv_ClockLabel_2_Seconds(time_label)
        
        // add up
        let seconds_added = seconds + addup
        
        let time_label_new = Methods.conv_Seconds_2_ClockLabel(seconds_added)
        
        
        return time_label_new
        
    }

    static func timeLabel_Subtract
        (time_label : String, subtract : Int, min : Int) -> String {
            
            // conv: label --> Int
            let seconds = Methods.conv_ClockLabel_2_Seconds(time_label)
            
            // add up
            var seconds_added = seconds + subtract
            
            // validate: min
            if seconds_added < 0 {
                
               seconds_added = 0
                
            }
            
            let time_label_new = Methods.conv_Seconds_2_ClockLabel(seconds_added)
            
            return time_label_new
            
    }

    static func add_BM
    (item_name : String, bm_time : Int, audio_url : NSURL) -> Bool {
        
        // realm
        let rl_tmp = Methods.get_RealmInstance(CONS.s_Realm_FileName)
        //    let rl_tmp = Methods.get_RealmInstance("abc.realm")
        
        // BM instance
        let bm = BM()

        // title
        bm.title = item_name

        // time
        bm.bm_time = bm_time
        
        // time -> meta
        let tmp_time = NSDate()
        
        bm.created_at = Methods.conv_NSDate_2_DateString(tmp_time)
        bm.modified_at = Methods.conv_NSDate_2_DateString(tmp_time)

        // id
        bm.id = Methods.lastId()
        
//        // audio id
//        let url = self.current_song!.valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL
        bm.audio_id = (audio_url.absoluteString)
        
        //ref https://realm.io/docs/swift/latest/#adding-objects "Adding Objects"
        //ref https://mynavi-agent.jp/it/geekroid/2015/07/realm-2-realmswift-.html
        try! rl_tmp.write {
            
            //        self.realm.add(self.diary, update: true)
            
            
            rl_tmp.add(bm, update: true)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm => written (bm_time => \(bm.bm_time) (\(bm.title))")
            
            
        }

        
        return false
    }

    static func update_BM
        (bm : BM) -> Bool {
            
        // realm
        let rl_tmp = Methods.get_RealmInstance(CONS.s_Realm_FileName)
        //    let rl_tmp = Methods.get_RealmInstance("abc.realm")
        
        // time -> meta
        let tmp_time = NSDate()
        
        bm.modified_at = Methods.conv_NSDate_2_DateString(tmp_time)
        
        //ref https://realm.io/docs/swift/latest/#adding-objects "Adding Objects"
        //ref https://mynavi-agent.jp/it/geekroid/2015/07/realm-2-realmswift-.html
        try! rl_tmp.write {
            
            //        self.realm.add(self.diary, update: true)
            
            rl_tmp.add(bm, update: true)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm => updated (\(bm.description)")
            
        }
        
        return true
            
    }

}
