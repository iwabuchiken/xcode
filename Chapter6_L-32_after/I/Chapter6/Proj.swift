
//
//  Proj.swift
//  Chapter6
//
//  Created by mac on 2016/02/22.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import Foundation
import RealmSwift

import CoreLocation
import MapKit

class Proj {

    static func get_LastUploaded_At() -> String {
        
//        let r = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
//        
        let s_dbfile_name = CONS.s_Realm_FileName__Admin
        let s_sort_key = "modified_at"
        let b_ascend = false
        
        let query = "name == '\(CONS.s_AdminKey__LastBackup)'"
        
//        var aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
        let aPredicate = NSPredicate(format: query)

        let aryOf_Data_Filtered = DB.findAll_Data__Filtered(s_dbfile_name, predicate: aPredicate, sort_key: s_sort_key, ascend: b_ascend)
//        let ary = DB.findAll_Data(s_dbfile_name, sort_key: s_sort_key, ascend: b_ascend)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] aryOf_Data_Filtered.description => \(aryOf_Data_Filtered.description)")

        // return
        if aryOf_Data_Filtered.count < 1 {

            return "-1"
            
        } else {
            
            return aryOf_Data_Filtered[0].modified_at
            
        }
//        return "-1"
        
////        let r = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
//        let query = "name == '\(CONS.s_AdminKey__LastBackup)'"
//        
        //        print("[\(Methods.basename(__FILE__)):\(__LINE__)] query => \(query)")
//        
//        let aPredicate = NSPredicate(format: query)
//
//        // params
////        let s_sort_key = "modified_at"
//        let s_sort_key = "created_at"
//        let b_ascend = false
//        
//        let adminAry = DB.findAll_Admin__Filtered(CONS.s_Realm_FileName__Admin, predicate: aPredicate, sort_key: s_sort_key, ascend: b_ascend)
//        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] adminAry.count => \(adminAry.count)")
//        
//        // return
//        if adminAry.count < 1 {
//            
//            return "-1"
//            
//        } else {
//            
////            return adminAry[0].modified_at
//            return adminAry[0].created_at
//            
//        }
        
        
    }

    static func get_Latest_Diary_at() -> String {
        
        //        let r = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
        //
        let s_dbfile_name = CONS.s_Realm_FileName__Admin
        let s_sort_key = "modified_at"
        let b_ascend = false
        
        let query = "name == '\(CONS.s_AdminKey__Latest_Diary_at)'"
        
        //        var aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
        let aPredicate = NSPredicate(format: query)
        
        let aryOf_Data_Filtered = DB.findAll_Data__Filtered(s_dbfile_name, predicate: aPredicate, sort_key: s_sort_key, ascend: b_ascend)
        //        let ary = DB.findAll_Data(s_dbfile_name, sort_key: s_sort_key, ascend: b_ascend)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] aryOf_Data_Filtered.description => \(aryOf_Data_Filtered.description)")
        
        // return
        if aryOf_Data_Filtered.count < 1 {
            
            return "-1"
            
        } else {
            
            return aryOf_Data_Filtered[0].s_1
            
        }
        //        return "-1"
        
        ////        let r = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
        //        let query = "name == '\(CONS.s_AdminKey__LastBackup)'"
        //
        //        print("[\(Methods.basename(__FILE__)):\(__LINE__)] query => \(query)")
        //
        //        let aPredicate = NSPredicate(format: query)
        //
        //        // params
        ////        let s_sort_key = "modified_at"
        //        let s_sort_key = "created_at"
        //        let b_ascend = false
        //
        //        let adminAry = DB.findAll_Admin__Filtered(CONS.s_Realm_FileName__Admin, predicate: aPredicate, sort_key: s_sort_key, ascend: b_ascend)
        //
        //        //debug
        //        print("[\(Methods.basename(__FILE__)):\(__LINE__)] adminAry.count => \(adminAry.count)")
        //
        //        // return
        //        if adminAry.count < 1 {
        //
        //            return "-1"
        //            
        //        } else {
        //            
        ////            return adminAry[0].modified_at
        //            return adminAry[0].created_at
        //            
        //        }
        
        
    }
    
    static func copy_DB__Diaries__FromDefault
    (db_name_dst : String) -> Int {

//        /*
//            Diary --> from default
//        */
//        // デフォルトの Realm インスタンスを取得する
//        let realm = try! Realm()
//        
//        // DB 内の日記データが格納されるリスト(日付新しいもの順でソート：降順)。以降内容をアップデートするとリスト内は自動的に更新される。
//        //let dataArray = try! Realm().objects(Diary).sorted("date", ascending: false)
//        var dataArray = try! Realm().objects(Diary).sorted("created_at", ascending: false)
//
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray.count => \(dataArray.count)")
//
//        /*
//            Diary --> to dest db
//        */
//        let r_dst = Methods.get_RealmInstance(db_name_dst)
//        
//        let s_sort_key = "created_at"
//        let b_ascend = false
//        
////        let resOf_Diaries_New =  try! realm.objects(Admin).sorted(s_sort_key, ascending: b_ascend)
////
////        //debug
////        print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_Diaries_New.description => \(resOf_Diaries_New.description)")
//
//        // return
        return -1
        
    }

    //ref http://qiita.com/_ha1f/items/f6318e326434dbf83037
    static func lastId_Data() -> Int {

        // get realm
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)


//        if let user = realm.objects(BM).last {
        if let user = realm.objects(Data).last {

            return user.id + 1

        } else {

            return 1
            
        }
    }

    static func lastId_Hist() -> Int {
        
        // get realm
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
        
        
        //        if let user = realm.objects(BM).last {
        if let user = realm.objects(Hist).sorted("id", ascending: true).last {
            
            return user.id + 1
            
        } else {
            
            return 1
            
        }
    }

    static func lastId_Loc() -> Int {
        
        // get realm
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
        
        
        //        if let user = realm.objects(BM).last {
        if let user = realm.objects(Loc).sorted("id", ascending: true).last {
            
            return user.id + 1
            
        } else {
            
            return 1
            
        }
    }
    

    static func  get_LastBackup_Diary_ModifiedAt_String() -> String  {
        
        // get realm
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)

        let query = "name == '\(CONS.s_LatestBackup_Diary_ModifiedAt)'"
        
        let aPredicate = NSPredicate(format: query)
        
        //        let resOf_Data_LatestDiaryAt = try self.realm_admin.objects(Data).filter(aPredicate).sorted("created_at", ascending: false)
        let resOf_Data_LatestDiaryAt = try! realm.objects(Data).filter(aPredicate).sorted("created_at", ascending: false)

        //debug0
        if resOf_Data_LatestDiaryAt.count > 0 {
            
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_Data_LatestDiaryAt[0].description => (\(resOf_Data_LatestDiaryAt[0].description))")

            // return
            return resOf_Data_LatestDiaryAt[0].s_1

        } else {

            print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_Data_LatestDiaryAt.count => =< 0")

            // return
            return "-1"
            
        }
        
    }
 
    static func save_History(keywords : String) {
        
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
        
        let time_label = Methods.get_TimeLable()
        
        do {
            
            try! realm.write {

                let hist = Hist()

                hist.id = Proj.lastId_Hist()
                
                hist.created_at     = time_label
                hist.modified_at    = time_label
                hist.keywords       = keywords
                
                realm.add(hist, update: true)
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] hist saved => '\(keywords)'")

                
    //            self.diary.title = self.titleTextField.text!
    //            self.diary.body = self.bodyTextView.text
    //            self.diary.date = NSDate()
    //            self.realm.add(self.diary, update: true)

            }
            
        } catch let e as NSError! {
            
            // handle error
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] realm.write(keywords = \(keywords)) => error [\(e.description)]")
            
        }

        
    }

    static func find_Keywords_Last() -> String {
        
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
        
        let hist_last = try! realm.objects(Hist).sorted("created_at", ascending: true).last

        return hist_last!.keywords
        
    }

    /*
        @return
        1   => saved
        2   => exception
    */
    static func save_Loc(center : CLLocationCoordinate2D) -> Int {
        
//        let longi : CLLocationDegrees = center.longitude
//        let lat : CLLocationDegrees = center.latitude
        
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
        
        let time_label = Methods.get_TimeLable()
        
        do {
            
            try! realm.write {
                
                let loc = Loc()
                
                loc.id = Proj.lastId_Loc()
                
                loc.created_at     = time_label
                loc.modified_at    = time_label
                
                loc.longi       = Double(center.longitude.description)!
                loc.lat       = Double(center.latitude.description)!
                
                realm.add(loc, update: true)
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] loc saved => '\(loc.description)'")
                

            }
            
        } catch let e as NSError! {
            
            // handle error
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] realm.write(lat = \(center.latitude)) => error [\(e.description)]")
            
            // return
            return -1
            
        }
        
        // return
        return 1

        
    }

    static func get_Limit_on_NumOf_Diaries() -> Int {
        
        // get value
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //        var dfltVal_DebugMode = defaults.valueForKey(CONS.defaultKeys.key_Set_DebugMode)
        var lim = defaults.valueForKey(CONS.defaultKeys.key_Deault_LimitOn_NumOfCells)

        // validate
        if lim?.intValue < 1 || lim?.intValue > 10000 {
            
            lim = 10000
            
        }

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] limit --> \(lim?.intValue)")
        
        return Int((lim?.intValue)!)
//        return lim?.intValue
//        return 10000
//        return CONS.VC.limitOn_NumOf_Cells
        
    }

    static func get_NumOf__NewDiaries() -> Int {
        
        // realm
        let r = try! Realm()
        
        //        let resOf_Diaries = try! r.objects(Diary).sorted("created_at", ascending: false)
        let resOf_Diaries = r.objects(Diary).sorted("created_at", ascending: false)

        // last upload date
        var s_last_uploaded_at = Proj.get_LastBackup_Diary_ModifiedAt_String()
        
        if s_last_uploaded_at == "-1" {
            
            s_last_uploaded_at = "0000/00/00 00:00:00"
            //            s_last_uploaded_at = "2016/02/20 00:00:00"
            
            //debug0
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] s_last_uploaded_at => '-1'; re-setting to => \(s_last_uploaded_at)")

        } else {
            
            //debug0
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] s_last_uploaded_at => \(s_last_uploaded_at)")
            
        }

        // build
        // build list of diaries
//        var aryOf_Diaries = Array<Diary>()
        
        let lenOf_ResOf_Diaries = resOf_Diaries.count
        
        var i_count = 0
        
        for var i = 0; i < lenOf_ResOf_Diaries; i++ {
            
            let d = resOf_Diaries[i]
            
            let modified_at = Methods.conv_NSDate_2_DateString(d.date)
            
            if modified_at > s_last_uploaded_at {
                
//                aryOf_Diaries.append(d)
                
                i_count += 1
                
            }
            
            
            
        }
        
//        //debug0
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_Diaries => \(lenOf_ResOf_Diaries) / aryOf_Diaries.count => \(aryOf_Diaries.count)")

        // return
        if i_count < 1 {
            
            //debug0
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] i_count => less than 1")
            
            return 0
            
        } else {
            
            return i_count
            
        }

    }

    /*
        @return
        ok  => 1
        no  => -1
    */
    static func show_Dialog__Remind_NewDiaries
    (vc : UIViewController, num : Int) {
        
        //        let s_title = "Choices"
        let s_title = "New diaries exisits"
        
        let s_message = "\(num) new ones. Upload?"
        
        let refreshAlert = UIAlertController(title: s_title, message: s_message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let choice_0 = "OK"
        
        let choice_1 = "No"
        
        refreshAlert.addAction(UIAlertAction(title: choice_0, style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] chosen => 0")
            
            // execute  => close dialog

            
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: choice_1, style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] chosen => 1")
            

            
        }))
        
        // show view
        vc.presentViewController(refreshAlert, animated: true, completion: nil)

    }
    

}