//
//  Methods.swift
//  Chapter6
//
//  Created by mac on 2016/02/07.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import Foundation
import MediaPlayer

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
    
    
}