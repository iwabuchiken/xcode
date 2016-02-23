
//
//  Proj.swift
//  Chapter6
//
//  Created by mac on 2016/02/22.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import Foundation
import RealmSwift

class Proj {

    static func get_LastUploaded_At() -> String {
        
//        let r = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
//        
        let s_dbfile_name = CONS.s_Realm_FileName__Admin
        let s_sort_key = "modified_at"
        let b_ascend = false
        
        var query = "name == '\(CONS.s_AdminKey__LastBackup)'"
        
//        var aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
        var aPredicate = NSPredicate(format: query)

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
        
        var query = "name == '\(CONS.s_AdminKey__Latest_Diary_at)'"
        
        //        var aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
        var aPredicate = NSPredicate(format: query)
        
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

    //    static func updateData_Data__Latest_Diary_at
//    (value : String) -> Bool {
//        
//        let r = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
//        
//        // already in db?
//        var query = "name == '\(CONS.s_AdminKey__Latest_Diary_at)'"
//        
//        //        var aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
//        var aPredicate = NSPredicate(format: query)
//
//        let res = DB.findAll_Data__Filtered(CONS.s_Realm_FileName__Admin, predicate: aPredicate, sort_key: "created_at", ascend: false)
//        
//        if res.count < 1 {
//
//            let data = Data()
//            
//            let time_label = Methods.conv_NSDate_2_DateString(NSDate())
//            
//            data.created_at = time_label
//            data.modified_at = time_label
//            
//            data.name = CONS.s_AdminKey__Latest_Diary_at
//            
//            data.s_1 = value
//            
//            try! r.write {
//                
//                r.add(data, update: false)
//                
//                //debug
//                print("[\(Methods.basename(__FILE__)):\(__LINE__)] new data saved => \(data.description)")
//
//            }
//
//        } else {
//
//            let data = res[0]
//            
//            let time_label = Methods.conv_NSDate_2_DateString(NSDate())
//            
//            data.modified_at = time_label
//            
//            data.s_1 = value
//            
//            try! r.write {
//                
////                r.add(data, update: true)
//
//                self.r.add(data, update: true)
//                
//                //debug
//                print("[\(Methods.basename(__FILE__)):\(__LINE__)] data updated => \(data.description)")
//                
//            }
//            
//            
//        }
//        
//        //return
//        return true
//        
//    }
    
}