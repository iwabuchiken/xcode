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
        
        //ref https://realm.io/docs/swift/latest/#adding-objects "Adding Objects"
        //ref https://mynavi-agent.jp/it/geekroid/2015/07/realm-2-realmswift-.html
        try! rl_tmp.write {

            //        //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] adding a new BM...")
            
            //        self.realm.add(self.diary, update: true)
            // BM instance
            let bm = BM()
            
            // id
            bm.id = Methods.lastId()

            //        //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm.id => \(bm.id)")

            
            // title
            bm.title = item_name
            
            // time
            bm.bm_time = bm_time
            
            // time -> meta
            let tmp_time = NSDate()
            
            bm.created_at = Methods.conv_NSDate_2_DateString(tmp_time)
            bm.modified_at = Methods.conv_NSDate_2_DateString(tmp_time)

            bm.audio_id = (audio_url.absoluteString)

            
            rl_tmp.add(bm, update: true)
//            rl_tmp.add(bm, update: false)
            
            //debug
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm => written (bm_time => \(bm.bm_time) (\(bm.title))")
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm => written (\(bm.description)")
          
            
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

    static func save_Clips__MediaItems(songs : [MPMediaItem]) {
        
        var count = 0

        let aryOf_Clips = Proj.conv_MediaItems_2_AryOf_Clips(songs)
        
        // iterate
        var aryOf_Clips_NotInDB = Array<Clip>()
        
        for item in aryOf_Clips {
            
            let clip = item
            
            let res_b = DB.isInDb__Clip_Title(CONS.s_Realm_FileName, title: clip.title)
            
            if res_b == false {
                
                aryOf_Clips_NotInDB.append(clip)
                
                count += 1
                
            }
            
        }
        
        // report
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] aryOf_Clips.count => \(aryOf_Clips.count) / aryOf_Clips_NotInDB.count => \(aryOf_Clips_NotInDB.count)")

        // validate: any entries
        if aryOf_Clips_NotInDB.count < 1 {

            print("[\(Methods.basename(__FILE__)):\(__LINE__)] no new entries. returning...")

            return
            
        }
        
        /*
            save
        */
        count = 0
        
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
        
        let len = aryOf_Clips_NotInDB.count
        
        for var i = 0; i < len; i++ {

            let item = aryOf_Clips_NotInDB[i]
            
            try! realm.write {
                
                //        //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] adding a new Clip...")
                
                // id
                item.id = Proj.lastId_Clip()
                
                //        //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm.id => \(item.id)")
                
                // time -> meta
                let tmp_time = NSDate()
                
                item.created_at = Methods.conv_NSDate_2_DateString(tmp_time)
                item.modified_at = Methods.conv_NSDate_2_DateString(tmp_time)
                
                realm.add(item, update: true)
                
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] clip => written (\(item.description)")
                
                // count
                count += 1
                
            }

        }
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] aryOf_Clips_NotInDB.count => \(aryOf_Clips_NotInDB.count) / saved => \(count)")
        
    }

    static func conv_MediaItems_2_AryOf_Clips
    (items : [MPMediaItem]) -> [Clip] {
    
        var count = 0
        
        var aryOf_Clips = Array<Clip>()
        
        //        for item in self.songs {
        for item in items {
            
            let clip = Clip()
            
            clip.id = Proj.lastId_Clip()
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] clip.id => \(clip.id)")
            
            //            clip.title = item.title!
            var s_tmp = item.title!.stringByReplacingOccurrencesOfString("\"", withString: "\\\"", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            //ref http://stackoverflow.com/questions/25591241/swift-remove-character-from-string answered Aug 31 '14 at 10:55
            //ref escape "'" http://stackoverflow.com/questions/30170908/swift-how-to-print-character-in-a-string answered May 11 '15 at 14:54
            s_tmp = item.title!.stringByReplacingOccurrencesOfString("\'", withString: "\\\'", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            clip.title = s_tmp
            
            //            clip.title = item.title!.stringByReplacingOccurrencesOfString("\"", withString: "\\\"", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            let url = item.valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL
            
            let str = url?.absoluteString
            
            clip.audio_id = str!
            
            // created_at, modified_at
            let tmp = Methods.conv_NSDate_2_DateString(NSDate())
            
            clip.created_at = tmp
            clip.modified_at = tmp
            
            // length
            //debug
            //            print("[\(Methods.basename(__FILE__)):\(__LINE__)] item.valueForProperty(MPMediaItemPropertyPlaybackDuration) => \(item.valueForProperty(MPMediaItemPropertyPlaybackDuration))")
            //            //=> Optional(641.227)
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] item.valueForProperty(MPMediaItemPropertyPlaybackDuration) => \(item.valueForProperty(MPMediaItemPropertyPlaybackDuration)!)")
            //=>
            
            clip.length = Int(item.valueForProperty(MPMediaItemPropertyPlaybackDuration)! as! NSNumber)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] clip.description => \(clip.description)")
            
            // append
            aryOf_Clips.append(clip)
            
            // count
            count += 1
            
//            // is in db
//            let res_b = DB.isInDb__Clip_Title(CONS.s_Realm_FileName, title: clip.title)
//            
//            if res_b == false {
//                
//                // save clip info
//                
//                
//                count += 1
//                
//            }
            
        }//for item in items

        // report
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] items.count => \(items.count) / aryOf_Clips.count => \(aryOf_Clips.count)")

        // return
        return aryOf_Clips
        
    }
    
    static func lastId_Clip() -> Int {
        
        // get realm
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
        
        //        if let user = realm.objects(BM).last {
//        if let user = realm.objects(Clip).last {
        if let user = realm.objects(Clip).sorted("created_at", ascending: true).last {
        
            return user.id + 1
            
        } else {
            
            return 1
            
        }
    }

    static func lastId_PH() -> Int {
        
        // get realm
        let realm = Methods.get_RealmInstance(CONS.RealmVars.s_Realm_FileName__Admin)
        
        let resOf_PHs = realm.objects(PH).sorted("created_at", ascending: true)
        
        // validate
        if resOf_PHs.count < 1 {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_PHs.count < 1")

            return 1
            
        }
        
//        if let user = realm.objects(PH).sorted("created_at", ascending: true).last {
        if let user = resOf_PHs.last {
        
            return user.id + 1
            
        } else {
            
            return 1
            
        }
    }
    
    static func find_All_Clips
        (sort_column : String = "created_at", ascend : Bool = true) -> [Clip] {
        
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
        
        let resOf_Clips = realm.objects(Clip).sorted(sort_column, ascending: true)
        
        // convert -> to array
        var aryOf_Clips = Array<Clip>()
        
        for item in resOf_Clips {
            
            aryOf_Clips.append(item)
            
        }
        
        // return
        return aryOf_Clips
        
    }

    static func find_All_PHs
    (sort_column : String = "created_at", ascend : Bool = true) -> [PH] {
            
            let realm = Methods.get_RealmInstance(CONS.RealmVars.s_Realm_FileName__Admin)
            
            let resOf_Clips = realm.objects(PH).sorted(sort_column, ascending: true)
            
            // convert -> to array
            var aryOf_Clips = Array<PH>()
            
            for item in resOf_Clips {
                
                aryOf_Clips.append(item)
                
            }
            
            // return
            return aryOf_Clips
            
    }

    /*
        @return
        if no entries in the table
            => returns a PH instance with id being "-1"
    */
    static func find_PH__Latest() -> PH {

        // realm
        let realm = Methods.get_RealmInstance(CONS.RealmVars.s_Realm_FileName__Admin)
        
        let sort_column = "created_at"
        
        let ascend = true
        
        let resOf_PHs = realm.objects(PH).sorted(sort_column, ascending: ascend)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_PHs.count => \(resOf_PHs.count)")

        // return
        if resOf_PHs.count < 1 {
            
            let ph = PH()
            
            ph.id = -1
            
            return ph
            
        } else {
            
            return resOf_PHs.last!
            
        }
        
//        return realm.objects(PH).sorted(sort_column, ascending: ascend).last!
//        return PH()

    }

    static func save_PH(ph : PH) -> Bool {
        // realm
        let rl_tmp = Methods.get_RealmInstance(CONS.RealmVars.s_Realm_FileName__Admin)

        var res = false
        
        try! rl_tmp.write {
            
            rl_tmp.add(ph, update: true)
            //            rl_tmp.add(bm, update: false)
            
            //debug
            //            print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm => written (bm_time => \(bm.bm_time) (\(bm.title))")
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] ph => written (\(ph.description)")
            
//            // return
//            return true
        
            // result
            res = true
            
        }
        
        // return result
        return res
        
    }

}

