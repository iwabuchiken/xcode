//
//  Methods.swift
//  Chapter6
//
//  Created by mac on 2016/02/07.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import Foundation
import MediaPlayer
import RealmSwift

//public func out_Message(str: String) ->Void {
//    
//    print(__FILE__)
//    
//}

//class Methods: Object {
//public class Methods {
class Methods {
    
    static func out_Message(str: String) ->Void {
      
        print("[\(__FILE__):\(__LINE__)] file => '\(__FILE__)'")
//        print(__FILE__)
        
    }

  // MARK: directory-related
    
    static func basename(path: String) -> String {
        
        let tokens = path.componentsSeparatedByString("/")
        
        // no '/' char
        if tokens.count == 1 {
            
            print("path string has no '/' char")
            
            return path
            
        }
        
        // 1 '/'    => "/memos.txt" --> ["","memos.txt"]
        if tokens.count == 2 {
            
            //            print("path string has 1 '/' char")
            
            //            return tokens[0]
            return tokens[1]
            
        }
        
        // multiple
        return tokens[tokens.count - 1]
        
        //        return ""
        
    }
    

    static func dirname(path: String) -> String {
        
        //        let tokens = path.componentsSeparatedByString("/")
        //        let tokens = path.componentsSeparatedByString(CONS.s_DirSeparator)    //=> works
        let tokens = path.componentsSeparatedByString(CONS.s_DirSeparator)
        
        // no '/' char
        if tokens.count == 1 {
            
            print("path string has no '\(CONS.s_DirSeparator)' char")
            
            return path
            
        }
        
        // 1 '/'    => "/Libray" --> ["","Library"]
        if tokens.count == 2 {
            
            //            print("path string has 1 '/' char")
            
            //            return tokens[0]
            return path
            
        }
        
        // 2 '/'    => "/Libray/path" --> ["","Library","path"]
        if tokens.count >= 3 {
            
            //            print("path string has 1 '/' char")
            
            //            return tokens[0]
            //            return path
            
            //            return tokens[tokens.startIndex.advancedBy((0))..<tokens.startIndex.advancedBy(tokens.count)]
            
            //            return tokens.map{Array($0)}  //=> /Users/mac/Desktop/works/WS/xcode/Chapter6_L-32_after/I/chapter6/Methods.swift:93:20: Ambiguous reference to member 'map'
            
            //ref http://stackoverflow.com/questions/29874414/cannot-subscript-a-value-of-anyobject-with-an-index-of-type-int answered Apr 26 '15 at 6:44
            //            return tokens[1...(tokens.count - 1)] //=> n.w.
            //            return tokens?[1...(tokens?.count - 1)]
            
            let len = tokens.count
            
            //ref join http://stackoverflow.com/questions/25827033/how-do-i-convert-a-swift-array-to-a-string answered Sep 13 '14 at 19:54
            return tokens[0...(len - 2)].joinWithSeparator(CONS.s_DirSeparator)
            //            //debug
            //            print("[\(Methods.basename(__FILE__)):\(__LINE__)] len => \(len)")
            //
            //            return ""
            
        }
        
        // multiple
        //        let tmp = tokens[0..(tokens.count - 2)].joinWithSeparator(CONS.s_DirSeparator)
        
        //        let tmp = tokens.startIndex
        //
        //        return path
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] tokens.count => unknown value¥n returning path")
        
        return path
        
    }
    

    static func show_DirList() {
        
        //ref http://stackoverflow.com/questions/26072796/get-list-of-files-at-path-swift answered Sep 27 '14 at 8:41
        let filemanager:NSFileManager = NSFileManager()
        let files = filemanager.enumeratorAtPath(NSHomeDirectory())
        while let file = files?.nextObject() {
            print(file)
        }
        
        //        let realmPath = Realm.Configuration.defaultConfiguration.path
        //
        //        let dpath_realm = Methods.dirname(realmPath!)
 
        
    }

    static func show_DirList__RealmFiles() {
        
        let realmPath = Realm.Configuration.defaultConfiguration.path
        
        let dpath_realm = Methods.dirname(realmPath!)
        
        //ref http://stackoverflow.com/questions/26072796/get-list-of-files-at-path-swift answered Sep 27 '14 at 8:41
        let filemanager:NSFileManager = NSFileManager()
        let files = filemanager.enumeratorAtPath(dpath_realm)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] path => \(dpath_realm)")
        
        
        while let file = files?.nextObject() {
            print(file)
        }
        
        
        
    }
    

    static func show_DirList(path : String) {
        
        //ref http://stackoverflow.com/questions/26072796/get-list-of-files-at-path-swift answered Sep 27 '14 at 8:41
        let filemanager:NSFileManager = NSFileManager()
        let files = filemanager.enumeratorAtPath(path)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] path => \(path)")

        
        while let file = files?.nextObject() {
            print(file)
        }
        
        
        
    }
    
  // MARK: time-related
    /*
        "2016/02/08 12:38:09"   => "2016/02/08"
        if the string has more than 1 ' ' char => returns the string
    */
    static func get_Date(date_string: String) -> String {
 
        //ref http://stackoverflow.com/questions/30759158/using-the-split-function-in-swift-2 answered Jun 10 '15 at 14:27
        let tokens = date_string.componentsSeparatedByString(" ")
        
        // no '/' char
        if tokens.count == 1 {
            
            print("path string has no '/' char")
            
            return date_string
            
        }
        
        // 1 '/'
        if tokens.count == 2 {
            
//            print("path string has 1 '/' char")
            
            return tokens[0]
            
        }
        
        // multiple
//        return tokens[tokens.count - 1]
        return date_string
       
    }//static func get_Date(date_string: String) -> String

    /*
        "2016/02/08 12:38:09"   => "12:38:09"
        if the string has more than 1 ' ' char => returns the string
    */
    static func get_Time(date_string: String) -> String {
        
        //ref http://stackoverflow.com/questions/30759158/using-the-split-function-in-swift-2 answered Jun 10 '15 at 14:27
        let tokens = date_string.componentsSeparatedByString(" ")
        
        // no '/' char
        if tokens.count == 1 {
            
//            print("path string has no ' ' char")
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] path string has no ' ' char")
            return date_string
            
        }
        
        // 1 '/'
        if tokens.count == 2 {
            
//            print("path string has 1 ' ' char")
            
            return tokens[1]
            
        }
        
        // multiple
//        return tokens[tokens.count - 1]
        return date_string
        
    }//static func get_Date(date_string: String) -> String

    static func get_TimeLable() -> String {
        
        // date
                let currentDate = NSDate()
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale.currentLocale()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        return dateFormatter.stringFromDate(currentDate)
        
    }

    static func get_TimeLabel__Serial() -> String {
        
        // date
        let currentDate = NSDate()
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale.currentLocale()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        
        dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
        
        return dateFormatter.stringFromDate(currentDate)
        
    }

    static func conv_NSDate_2_DateString(date : NSDate) -> String {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale.currentLocale()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        return dateFormatter.stringFromDate(date)
        
    }
    
    static func get_Date_BeforeAfter_ByDate
        (current : NSDate, diff: Int) -> NSDate {
            
            //        var date_Now = NSDate()
            
            //ref http://captaindanko.blogspot.jp/2015/06/getting-daybefore-and-dayafter-from.html
            let oneDay:Double = Double(60 * 60 * 24 * diff)
            
            //        return current.dateByAddingTimeInterval(-(Double(oneDay)))
            //ref http://captaindanko.blogspot.jp/2015/06/getting-daybefore-and-dayafter-from.html
            //ref https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSDate_Class/#//apple_ref/occ/instm/NSDate/dateByAddingTimeInterval: "dateByAddingTimeInterval(_ ti: NSTimeInterval)"
            
            return current.dateByAddingTimeInterval(oneDay)
            
            
    }
    
    static func conv_Seconds_2_ClockLabel(sec : Int) -> String {
        
        // seconds
        let seconds = Int(sec % 60)
        
        // minutes
        var min = 0
        var hour = 0
        
        if sec >= 60 {
            
            min = Int(sec / 60)
            
            // hour
            if min >= 60 {
                
                hour = Int(min / 60)
                
                min = Int(min % 60)
                
            }
            
        }
        
        return NSString(format: "%02d:%02d:%02d", hour, min, seconds) as String
        
        //        let min_tmp = Int(sec / 60)
        
        
        
    }
    

    
    
  // MARK: defaults
    static func set_Defaults(tmp_s : String) -> Void {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setValue(tmp_s, forKey: CONS.key_SearchWords)
        
        // sync
        defaults.synchronize()
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] defaults set => '\(tmp_s)' (key = \(CONS.key_SearchWords))")
        
        
    }

    static func set_Defaults(tmp_s : String, key : String) -> Void {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setValue(tmp_s, forKey: key)
        
        // sync
        defaults.synchronize()
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] defaults set => '\(tmp_s)' (key = \(CONS.key_SearchWords))")
        
        
    }
    

    static func get_Defaults(keys : String) -> String {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //        defaults.setValue(tmp_s, forKey: CONS.key_SearchWords)
        //        let tmp_s : String? = (defaults.stringForKey(CONS.key_SearchWords))   //=> 'Optional(...)'
        return defaults.stringForKey(keys)!   //=> '那覇'
        
    }

    static func getDefaults_Boolean(dflt_key : String) -> Bool {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //        var dfltVal_DebugMode = defaults.valueForKey(CONS.defaultKeys.key_Set_DebugMode)
        let dfltVal_DebugMode = defaults.valueForKey(CONS.defaultKeys.key_Set_DebugMode)
        
        return (dfltVal_DebugMode?.boolValue)!
        
    }
    

    
    // iPhone 内から曲情報を取得する
    static func getSongs() -> Array<MPMediaItem> {
        
        var array = Array<MPMediaItem>()
        
        // アルバム情報を取得する
        //        let albumsQuery: MPMediaQuery = MPMediaQuery.albumsQuery()
        
        //ref http://stackoverflow.com/questions/26124062/swift-xcode-play-sound-files-from-player-list answered Sep 30 '14 at 18:49
        let songsQuery: MPMediaQuery = MPMediaQuery.songsQuery()
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] albumsQuery.description => \(songsQuery.description)")
        
        
        let albumItems: [MPMediaItemCollection] = songsQuery.collections!
        
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] albumItems.count => \(albumItems.count)")
        
        
        // アルバム情報から曲情報を取得する
        for album in albumItems {
            let albumItems: [MPMediaItem] = album.items
            for song in albumItems {
                array.append( song )
            }
        }
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] array => built")
        
        return array
    }

// MARK: basics
    static func joinArray
        (ary : [String], connect : String, start : Int, end : Int) -> String {
        
//        var tmp = ""
//            
//            for i in start...end {
//                
//                
//                
//            }

            return ""
            
            
    }
 
// MARK: realm-related
    static func get_RealmInstance(file_name : String) -> Realm {
        
        let realmPath = Realm.Configuration.defaultConfiguration.path
        
        let dpath_realm = Methods.dirname(realmPath!)
        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dpath_realm => \(dpath_realm)")
//
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] path => \(dpath_realm)/\(file_name)")
        
        
        //        let rl_tmp = try! Realm(path: "abc.realm")    //=> permission denied
//        return try! Realm(path: "\(dpath_realm)/abc.realm")   //=> works
        return try! Realm(path: "\(dpath_realm)/\(file_name)")   //=> works

    }
 
    static func get_RealmInstance__Identifier(id_name : String) -> Realm {
        
//        let realmPath = Realm.Configuration.defaultConfiguration.path
//        
//        let dpath_realm = Methods.dirname(realmPath!)
        
        
        //        let rl_tmp = try! Realm(path: "abc.realm")    //=> permission denied
        //        return try! Realm(path: "\(dpath_realm)/abc.realm")   //=> works
//        return try! Realm(path: "\(dpath_realm)/\(id_name)")   //=> works
        return try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: id_name))   //=> works
        
    }
    
    //ref http://qiita.com/_ha1f/items/f6318e326434dbf83037
    static func lastId() -> Int {
        
        // get realm
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
        
        //        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] lastId(): realm.objects(BM).sorted(\"id\", ascending: true).last?.description => \(realm.objects(BM).sorted("id", ascending: true).last?.description)")

        
//        if let user = realm.objects(BM).last {
//        if let user = realm.objects(BM).last {
        if let user = realm.objects(BM).sorted("id", ascending: true).last {

            return user.id + 1
            
        } else {
            
            return 1
            
        }
    }

    static func lastId_Clip() -> Int {
        
        // get realm
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
        
        //        if let user = realm.objects(BM).last {
        if let user = realm.objects(Clip).last {
            
            return user.id + 1
            
        } else {
            
            return 1
            
        }
    }
    
    static func realm_RemoveFiles(fname : String) {
        
        let manager = NSFileManager.defaultManager()
        
        //        let realmPath = Realm.Configuration.defaultConfiguration.path as! NSString
        
        let realmPath2 = Realm.Configuration.defaultConfiguration.path
        
        let dpath_realm = Methods.dirname(realmPath2!)
        
        //        let fname_realm = Methods.basename(realmPath2!)
        //        let fname_realm = "db_20160219_173550.realm"
        let fname_realm = fname
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dpath_realm => \(dpath_realm) *** fname_realm => \(fname_realm)")
        
        //        let realmPath = String("dpath_realm" + "/" + fname_realm)
        //        let realmPath = NSString.init("\(dpath_realm)/\(fname_realm)")
        
        //        let tmp = NSString()
        //
        //        tmp.
        
        //        let realmPath = tmp.stringByAppendingString("\(dpath_realm)/\(fname_realm)")
        let realmPath = "\(dpath_realm)/\(fname_realm)"
        
        let realmPaths = [
            realmPath as String,
            "\(realmPath).lock",
            "\(realmPath).log_a",
            "\(realmPath).log_b",
            "\(realmPath).note"
            //            realmPath.stringByAppendingPathExtension("lock")!,
            //            realmPath.stringByAppendingPathExtension("log_a")!,
            //            realmPath.stringByAppendingPathExtension("log_b")!,
            //            realmPath.stringByAppendingPathExtension("note")!
        ]
        for path in realmPaths {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] path => \(path)")
            
            do {
                try manager.removeItemAtPath(path)
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] path removed => \(path)")
                
            } catch {
                // handle error
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] remove path => error (\(path))")
                
            }
        }
        
        /*
        show dir list
        */
        Methods.show_DirList__RealmFiles()
        
    }
    
    static func realm_BackupFiles(fname : String) {
        
        let manager = NSFileManager.defaultManager()
        
        //        let realmPath = Realm.Configuration.defaultConfiguration.path as! NSString
        
        let realmPath2 = Realm.Configuration.defaultConfiguration.path
        
        let dpath_realm = Methods.dirname(realmPath2!)
        
        //        let fname_realm = Methods.basename(realmPath2!)
        //        let fname_realm = "db_20160219_173550.realm"
        let fname_realm = fname
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dpath_realm => \(dpath_realm) *** fname_realm => \(fname_realm)")
        
        //        let realmPath = String("dpath_realm" + "/" + fname_realm)
        //        let realmPath = NSString.init("\(dpath_realm)/\(fname_realm)")
        
        //        let tmp = NSString()
        //
        //        tmp.
        
        //        let realmPath = tmp.stringByAppendingString("\(dpath_realm)/\(fname_realm)")
        let realmPath = "\(dpath_realm)/\(fname_realm)"
        
        let realmPaths = [
            realmPath as String,
            "\(realmPath).lock",
            "\(realmPath).log_a",
            "\(realmPath).log_b",
            "\(realmPath).note"
            //            realmPath.stringByAppendingPathExtension("lock")!,
            //            realmPath.stringByAppendingPathExtension("log_a")!,
            //            realmPath.stringByAppendingPathExtension("log_b")!,
            //            realmPath.stringByAppendingPathExtension("note")!
        ]

        let realmPaths_backup = [
            "\(realmPath as String).backup",
            "\(realmPath).lock.backup",
            "\(realmPath).log_a.backup",
            "\(realmPath).log_b.backup",
            "\(realmPath).note.backup"
            //            realmPath.stringByAppendingPathExtension("lock")!,
            //            realmPath.stringByAppendingPathExtension("log_a")!,
            //            realmPath.stringByAppendingPathExtension("log_b")!,
            //            realmPath.stringByAppendingPathExtension("note")!
        ]

        for path in realmPaths {

            let res_b = manager.fileExistsAtPath(path)
            
            if res_b == true {
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] file exists => \(path)")

            } else {
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] file NOT exists => \(path)")

            }
            
        }
        
        /*
        show dir list
        */
        Methods.show_DirList__RealmFiles()
        
    }

    
// MARK: others
    //    func save_SongsData( data : Array<MPMediaItem> ) --> Void {
    static func save_SongsData( data : [MPMediaItem] ) -> Void {
        
        do {
            
        let s1 = data[0]
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] s1.title => \(s1.title)")
        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] s1.lastPlayedDate => \(Methods.conv_NSDate_2_DateString(s1.lastPlayedDate!))")
        
        //test
        let res = DB.isInDb__Clip_Title(CONS.s_Realm_FileName, title: s1.title!)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] is in db => \(res)")
        
        //debug: url
        let url = s1.valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL
        
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] url?.absoluteString => \(url?.absoluteString)")
        
        let s_id = url?.absoluteString.componentsSeparatedByString("=")[1]
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] s_id => \(s_id)")
        
        } catch {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] error")
            
            
        }
        
    }

    static func experiments() {
        
        let resOf_BMs = DB.findAll_BM(CONS.s_Realm_FileName, sort_key: "id", ascend: false)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_BMs.count => \(resOf_BMs.count)")

        
    }
 
    static func saveClips(songs : [MPMediaItem]) {
        
        var count = 0
        
//        for item in self.songs {
        for item in songs {
        
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] item.title => \(item.title)")
            
            let clip = Clip()
            
            clip.id = Methods.lastId_Clip()
            
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
            
            // is in db
            let res_b = DB.isInDb__Clip_Title(CONS.s_Realm_FileName, title: clip.title)
            
            if res_b == false {
                
                // save clip info
                
                
                count += 1
                
            }
            
        }
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] not in db => \(count) / total = \(songs.count)")
        
        
    }

    /*
        "00:07:56"  --> 476
    */
    static func conv_ClockLabel_2_Seconds
    (label : String) -> Int {
    
        let tokens = label.componentsSeparatedByString(":")
        
        // validate
        if tokens.count != 3 {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] tokens.count => not 3")

            return 0
            
        }
        
        //ref http://stackoverflow.com/questions/30739460/toint-removed-in-swift-2 answered Jun 9 '15 at 18:02
        let hour2sec = Int(tokens[0])! * 60 * 60
        let min2sec = Int(tokens[1])! * 60
        let sec = Int(tokens[2])!
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] tokens[0] = '\(tokens[0])', tokens[1] = '\(tokens[1])', tokens[2] = '\(tokens[2])'")
        
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] hour2sec = \(hour2sec), min2sec = \(min2sec), sec = \(sec)")
        
        return hour2sec + min2sec + sec
        
    }
    
}