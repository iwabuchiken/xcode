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
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] calling => stringForKey")

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
    
//    //ref http://qiita.com/_ha1f/items/f6318e326434dbf83037
//    static func lastId() -> Int {
//        
//        // get realm
//        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
//        
//        
////        if let user = realm.objects(BM).last {
//        if let user = realm.objects(BM).last {
//
//            return user.id + 1
//            
//        } else {
//            
//            return 1
//            
//        }
//    }
//
//    static func lastId_Clip() -> Int {
//        
//        // get realm
//        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
//        
//        //        if let user = realm.objects(BM).last {
//        if let user = realm.objects(Clip).last {
//            
//            return user.id + 1
//            
//        } else {
//            
//            return 1
//            
//        }
//    }
    
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

//        let realmPaths_backup = [
//            "\(realmPath as String).backup",
//            "\(realmPath).lock.backup",
//            "\(realmPath).log_a.backup",
//            "\(realmPath).log_b.backup",
//            "\(realmPath).note.backup"
//            //            realmPath.stringByAppendingPathExtension("lock")!,
//            //            realmPath.stringByAppendingPathExtension("log_a")!,
//            //            realmPath.stringByAppendingPathExtension("log_b")!,
//            //            realmPath.stringByAppendingPathExtension("note")!
//        ]

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

    static func conv_Diaries_2_CSV
//    (resOf_Diaries : [Results<Diary>]) -> [String] {
    (resOf_Diaries : Results<Diary>) -> [String] {


        
//        let obj = resOf_Diaries[0]
        
        // vars
        var lines = Array<String>()
        
//        //debug
//        let limit = 10
//        
//        var count = 0
        
        // iterate
        let numOf_items = resOf_Diaries.count
        
        //ref http://www.raywenderlich.com/117456/swift-tutorial-repeating-steps-with-loops
//        for item in resOf_Diaries {
        for var i = 0; i < numOf_items; i++ {

            // item
            let item = resOf_Diaries[i]
            
            // title
            let title = "\"\(Methods.conv_String_2_EscapedString(item.title))\""
            
//            // ',' contained?
            // ref http://stackoverflow.com/questions/24034043/how-do-i-check-if-a-string-contains-another-string-in-swift answered Jun 11 '14 at 11:34
//            if (title.rangeOfString(",") != nil) {
//                
//                title = "\"\(title)\""
//                
//            }
            
            // body
//            let body = "\"\(Methods.conv_String_2_EscapedString(item.title))\""
            let body = "\"\(Methods.conv_String_2_EscapedString(item.body))\""

//            // ',' contained?
//            if (body.rangeOfString(",") != nil) {
//                
//                body = "\"\(body)\""
//                
//            }

//            let str_1 = "\(item.id),\(item.title),\(item.body)"
            let str_1 = "\(item.id),\(title),\(body)"

//            let str_2 = "\"\(Methods.conv_NSDate_2_DateString(item.date))\",\"\(Methods.conv_NSDate_2_DateString(item.created_at))\""
            let str_2 = "\"\(Methods.conv_NSDate_2_DateString(item.created_at))\",\"\(Methods.conv_NSDate_2_DateString(item.date))\""
            
            let line = "\(str_1),\(str_2)"
            
//            //debug
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] line => \(line)")

            // append
            lines.append(line)
            
//            //debug
//            count += 1
//            
//            if count > limit {
//                
//                break
//                
//            }

        }

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_Diaries => \(resOf_Diaries.count) / lines => \(lines.count)")

        
//        return Array<String>()
        return lines
        
    }
    
// MARK: others
    
    static func conv_String_2_EscapedString(str : String) -> String {
        
        
        let s_tmp = str.stringByReplacingOccurrencesOfString("\"", withString: "\\\"", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        //ref http://stackoverflow.com/questions/25591241/swift-remove-character-from-string answered Aug 31 '14 at 10:55
        //ref escape "'" http://stackoverflow.com/questions/30170908/swift-how-to-print-character-in-a-string answered May 11 '15 at 14:54

        return s_tmp.stringByReplacingOccurrencesOfString("\'", withString: "\\\'", options: NSStringCompareOptions.LiteralSearch, range: nil)

        
    }
    
//    static func _experiments__FileIO() {
    static func writeTo_File
    (fpath_full : String, content : String) -> Void {
    
//        //ref http://www.learncoredata.com/how-to-save-files-to-disk/
//        let realmPath = Realm.Configuration.defaultConfiguration.path
//        
//        let dpath_realm = Methods.dirname(realmPath!)
//        
//        let fpath_full = "\(dpath_realm)/realm_data_\(Methods.get_TimeLabel__Serial()).csv"
        
        do {
            
//            try "yes".writeToFile(fpath_full, atomically: true, encoding: NSUTF8StringEncoding)
            try content.writeToFile(fpath_full, atomically: true, encoding: NSUTF8StringEncoding)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] file written => \(fpath_full)")
            
//            // report
//            Methods.show_DirList__RealmFiles()
            
        } catch {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] error occurred")
            
            
        }
        
    }

    static func writeTo_File__CSV
        (fpath_full : String, lines : [String]) -> Void {

//            //debug
//            let max = 10
//            var count = 0
            
            var content = ""
            
            // build: content
            let numOf_items = lines.count
            
            
//            for line in lines {
            for var i = 0; i < numOf_items; i++ {
            
                // line
                let line = lines[i]
                
                content += "\(line)\n"
                
//                // count
//                count += 1
//                
//                if count > max { break }
                
            }
            
            do {
            
                //            try "yes".writeToFile(fpath_full, atomically: true, encoding: NSUTF8StringEncoding)
                try "\(content)".writeToFile(fpath_full, atomically: true, encoding: NSUTF8StringEncoding)
            
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] file written => \(fpath_full)")
            
            } catch {
            
                    //debug
                    print("[\(Methods.basename(__FILE__)):\(__LINE__)] error occurred => \(fpath_full)")
                                
                                
            }
            
//            // write
//            for line in lines {
//
//                do {
//                    
//                    //            try "yes".writeToFile(fpath_full, atomically: true, encoding: NSUTF8StringEncoding)
//                    try "\(line)\n".writeToFile(fpath_full, atomically: true, encoding: NSUTF8StringEncoding)
//                    
//                    //debug
//                    print("[\(Methods.basename(__FILE__)):\(__LINE__)] file written => \(fpath_full)")
//                    
//                    //            // report
//                    //            Methods.show_DirList__RealmFiles()
//                    
//                    // count
//                    count += 1
//                    
//                    if count > max { break }
//                    
//                } catch {
//                    
//                    //debug
//                    print("[\(Methods.basename(__FILE__)):\(__LINE__)] error occurred => \(line)")
//                    
//                    
//                }
//
//            }
            
            
    }

    static func writeTo_File__CSV_ForBackup
        (fpath_full : String, lines : [String]) -> Void {
            
            //            //debug
            //            let max = 10
            //            var count = 0
            
            var content = ""
            
            // build: content
            let numOf_items = lines.count
            
            // write => meta info
            let date_label = Methods.conv_NSDate_2_DateString(NSDate())
            
//            let latest_diary = CONS.s_Latest_Diary_at
            
            content += "created_at=\(date_label),num_of_diaries=\(numOf_items),latest_diary_at=\(CONS.s_Latest_Diary_at)"
            
            content += "\n"
            
            // write => header
            content += "id,titile,body,created_at,modified_at"

            content += "\n"

            //            for line in lines {
            for var i = 0; i < numOf_items; i++ {
                
                // line
                let line = lines[i]
                
                content += "\(line)\n"
                
                //                // count
                //                count += 1
                //
                //                if count > max { break }
                
            }
            
            do {
                
                //            try "yes".writeToFile(fpath_full, atomically: true, encoding: NSUTF8StringEncoding)
                try "\(content)".writeToFile(fpath_full, atomically: true, encoding: NSUTF8StringEncoding)
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] file written => \(fpath_full)")
                
            } catch {
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] error occurred => \(fpath_full)")
                
                
            }
            
            //            // write
            //            for line in lines {
            //
            //                do {
            //
            //                    //            try "yes".writeToFile(fpath_full, atomically: true, encoding: NSUTF8StringEncoding)
            //                    try "\(line)\n".writeToFile(fpath_full, atomically: true, encoding: NSUTF8StringEncoding)
            //
            //                    //debug
            //                    print("[\(Methods.basename(__FILE__)):\(__LINE__)] file written => \(fpath_full)")
            //
            //                    //            // report
            //                    //            Methods.show_DirList__RealmFiles()
            //
            //                    // count
            //                    count += 1
            //
            //                    if count > max { break }
            //
            //                } catch {
            //                    
            //                    //debug
            //                    print("[\(Methods.basename(__FILE__)):\(__LINE__)] error occurred => \(line)")
            //                    
            //                    
            //                }
            //
            //            }
            
            
    }
 
    static func delete_Diary_CSVFiles() {
        
        let realmPath = Realm.Configuration.defaultConfiguration.path
        
        let dpath_realm = Methods.dirname(realmPath!)
 
        let filemanager:NSFileManager = NSFileManager()
        let files = filemanager.enumeratorAtPath(dpath_realm)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] path => \(dpath_realm)")
        
        
        while let file = files?.nextObject() {

            //ref prefix http://stackoverflow.com/questions/24034043/how-do-i-check-if-a-string-contains-another-string-in-swift Oct 14 '15 at 14:19
            if String(file).hasPrefix("realm") && String(file).hasSuffix("csv") {

                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] path => \(String(file))")

                do {

                    try filemanager.removeItemAtPath("\(dpath_realm)/\(String(file))")

                    //debug
                    print("[\(Methods.basename(__FILE__)):\(__LINE__)] file removed => (\(file))")

                } catch let e as NSError! {
                    
                    // handle error
                    //debug
                    print("[\(Methods.basename(__FILE__)):\(__LINE__)] error => \(e.description) (\(file))")

                    
                    
                }
                
//            print("\(file) (\(files?.description))")
//            
//            print("file.name => \(file.name)")
            }
            
        }

    }
}