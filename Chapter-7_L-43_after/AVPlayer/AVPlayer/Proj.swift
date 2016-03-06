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

    static func find_All_Clips
        (sort_column : String = "created_at", ascend : Bool = true, pred : NSPredicate) -> [Clip] {
        
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
        
//        let resOf_Clips = realm.objects(Clip).sorted(sort_column, ascending: true)
        let resOf_Clips = realm.objects(Clip).filter(pred).sorted(sort_column, ascending: true)
        
        // convert -> to array
        var aryOf_Clips = Array<Clip>()
        
        // validate: any entry
        if resOf_Clips.count < 1 {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_Clips.count < 1")

            return aryOf_Clips
            
        }
            
        for item in resOf_Clips {
            
            aryOf_Clips.append(item)
            
        }
        
        // return
        return aryOf_Clips
        
    }
    
    static func find_All_PHs
    (sort_column : String = "created_at", ascend : Bool = true) -> [PH] {
            
            let realm = Methods.get_RealmInstance(CONS.RealmVars.s_Realm_FileName__Admin)
            
            let resOf_Clips = realm.objects(PH).sorted(sort_column, ascending: ascend)
            
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

    static func update_PH(ph : PH, bm_time : Int) -> Bool {
        // realm
        let rl_tmp = Methods.get_RealmInstance(CONS.RealmVars.s_Realm_FileName__Admin)
        
        var res = false
        
        try! rl_tmp.write {
            
            // update => bm time
            ph.current_time = bm_time
            
            // update -> modified_at
            let t_label = Methods.get_TimeLable()
            
            ph.modified_at = t_label
            
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

    static func update_Clip(clip : Clip) -> Bool {
        // realm
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
        
        // result
        var res = false
        
        try! realm.write {
            
            // update -> modified_at
            let t_label = Methods.get_TimeLable()
            
            clip.modified_at    = t_label
            clip.removed_at     = t_label
            
            realm.add(clip, update: true)
            //            rl_tmp.add(bm, update: false)
            
            //debug
            //            print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm => written (bm_time => \(bm.bm_time) (\(bm.title))")
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] clip => updated (\(clip.description)")
            
            //            // return
            //            return true
            
            // result
            res = true
            
        }
        
        // return result
        return res
        
    }
    
    static func update_Clip__RemovedAt_Blank(clip : Clip) -> Bool {
        // realm
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
        
        // result
        var res = false
        
        try! realm.write {
            
            // update -> modified_at
            let t_label = Methods.get_TimeLable()
            
            clip.modified_at    = t_label
            clip.removed_at     = ""
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] clip.removed_at => ''")

            realm.add(clip, update: true)
            //            rl_tmp.add(bm, update: false)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] clip => updated (\(clip.description)")
            
            //            // return
            //            return true
            
            // result
            res = true
            
        }
        
        // return result
        return res
        
    }
    
    static func update_Clip__LastPlayedAt(clip : Clip) -> Bool {
        // realm
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
        
        // result
        var res = false
        
        try! realm.write {
            
            // update -> modified_at
            let t_label = Methods.get_TimeLable()
            
            clip.last_played_at    = t_label
            
            realm.add(clip, update: true)

            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] clip => updated (\(clip.description)")
            
            //            // return
            //            return true
            
            // result
            res = true
            
        }
        
        // return result
        return res
        
    }
    
    /*
        @return
            aryOf_Clips.count, aryOf_MediaItems.count, count_removed, count
    */
    static func refresh_Clips_Table() -> [Int] {
        
        // clips from --> db
        let aryOf_Clips = Proj.find_All_Clips()
        
        // from MediaItems
        let aryOf_MediaItems = Proj.getSongs()
        
        // build --> clip title list ~~> db
        var aryOf_Titles_from_MediaItems = Array<String>()
        
        for item in aryOf_MediaItems {
            
            aryOf_Titles_from_MediaItems.append(item.title!)
            
        }
        
        // check
        var count = 0
        
        var count_removed = 0
        
        for item in aryOf_Clips {
            
            let name = item.title
            
            //ref http://stackoverflow.com/questions/24102024/how-to-check-if-an-element-is-in-an-array answered Aug 19 '14 at 19:41
            if aryOf_Titles_from_MediaItems.contains(name) {
                
                // validate --> removed_at ==> ''
                
                Proj.update_Clip__RemovedAt_Blank(item)
                
                // continue
                continue
            
            } else if item.removed_at != "" {
                
                // count
                count_removed += 1
                
                // continue
                continue
                
            } else {
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] Clip not in MediaItems => \(name)")

                // update clip
                let time = Methods.get_TimeLable()
                
//                item.modified_at    = time
//                item.removed_at     = time
                
                Proj.update_Clip(item)
                
                // count
                count += 1
                
            }
            
        }
        
        // report
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] clips in db => \(aryOf_Clips.count) / aryOf_MediaItems.count =>  \(aryOf_MediaItems.count) / 'removed_at' => \(count_removed) / else => \(count)")

        // return
        return [aryOf_Clips.count, aryOf_MediaItems.count, count_removed, count]
        
    }

    static func getSongs() -> Array<MPMediaItem> {
        
        var array = Array<MPMediaItem>()
        
        // アルバム情報を取得する
        let albumsQuery: MPMediaQuery = MPMediaQuery.songsQuery()
        
        //ref https://stackoverflow.duapp.com/questions/32696647/swift-sort-artistsquery-by-album answered Feb 20 at 22:12
        albumsQuery.groupingType = MPMediaGrouping.Title
        
        let albumItems: [MPMediaItemCollection] = albumsQuery.collections!
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] albumItems.count => \(albumItems.count)")
        
        // アルバム情報から曲情報を取得する
        for album in albumItems {
            let albumItems: [MPMediaItem] = album.items
            for song in albumItems {
                array.append( song )
            }
        }
        
        //sort
        //ref http://stackoverflow.com/questions/31729337/swift-2-0-sorting-array-of-objects-by-property Rob Nov 10 '15 at 18:00
        array.sortInPlace{$0.title < $1.title}
        
        return array
        
    }

    static func mediaItem_Exists
    (title : String, audio_id : String) -> Bool {

        // setup
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)

        let query = "title == '\(title)' AND audio_id = '\(audio_id)'"
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] query => \(query)")
        
        
        let aPredicate = NSPredicate(format: query)

        let bmArray = DB.findAll_Clips__Filtered(CONS.s_Realm_FileName, predicate: aPredicate, sort_key: "created_at", ascend: false)

//        let bmArray = DB.findAll_Clips__Filtered(
//            CONS.s_Realm_FileName,  predicate: aPredicate, sort_key: "created_at", ascend: false)

        
        return true
        
    }

    static func find_Clip_from_Title_and_AudioId
    (title : String, audio_id : String) -> Clip {

        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
        
        //        let resOf_Clips = realm.objects(Clip).sorted(sort_column, ascending: true)
        
        let query = "title == '\(title)' AND audio_id = '\(audio_id)'"
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] query => \(query)")
        
        
        let aPredicate = NSPredicate(format: query)

        let sort_column : String = "created_at"
        let ascend : Bool = false
        
        let resOf_Clips = realm.objects(Clip).filter(aPredicate).sorted(sort_column, ascending: ascend)
        
        // validate
        if resOf_Clips.count < 1 {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] no clip found => returning a dummy clip")
            
            let clip = Clip()
            
            clip.id = -1
            
            return clip
            
        } else {
            
            return resOf_Clips.last!
            
        }

        
    }
}

