//
//  Methods.swift
//  Chapter6
//
//  Created by mac on 2016/02/07.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import Foundation

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
        
        // 1 '/'
        if tokens.count == 2 {
            
//            print("path string has 1 '/' char")
            
            return tokens[0]
            
        }
        
        // multiple
        return tokens[tokens.count - 1]
        
//        return ""
        
    }

    static func show_DirList() {
        
        //ref http://stackoverflow.com/questions/26072796/get-list-of-files-at-path-swift answered Sep 27 '14 at 8:41
        let filemanager:NSFileManager = NSFileManager()
        let files = filemanager.enumeratorAtPath(NSHomeDirectory())
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
            
            let oneDay:Double = Double(60 * 60 * 24 * diff)
            
            //        return current.dateByAddingTimeInterval(-(Double(oneDay)))
            return current.dateByAddingTimeInterval(oneDay)
            
            
    }

}