
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
        let query = "name == '\(CONS.s_AdminKey__LastBackup)'"
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] query => \(query)")
        
        let aPredicate = NSPredicate(format: query)

        // params
//        let s_sort_key = "modified_at"
        let s_sort_key = "created_at"
        let b_ascend = false
        
        let adminAry = DB.findAll_Admin__Filtered(CONS.s_Realm_FileName__Admin, predicate: aPredicate, sort_key: s_sort_key, ascend: b_ascend)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] adminAry.count => \(adminAry.count)")
        
        // return
        if adminAry.count < 1 {
            
            return "-1"
            
        } else {
            
//            return adminAry[0].modified_at
            return adminAry[0].created_at
            
        }
        
        
    }

    static func copy_DB__Diaries__FromDefault
    (db_name_dst : String) -> Int {

        /*
            Diary --> from default
        */
        // デフォルトの Realm インスタンスを取得する
        let realm = try! Realm()
        
        // DB 内の日記データが格納されるリスト(日付新しいもの順でソート：降順)。以降内容をアップデートするとリスト内は自動的に更新される。
        //let dataArray = try! Realm().objects(Diary).sorted("date", ascending: false)
        var dataArray = try! Realm().objects(Diary).sorted("created_at", ascending: false)

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray.count => \(dataArray.count)")

        /*
            Diary --> to dest db
        */
        let r_dst = Methods.get_RealmInstance(db_name_dst)
        
        let s_sort_key = "created_at"
        let b_ascend = false
        
        let resOf_Diaries_New =  try! realm.objects(Admin).sorted(s_sort_key, ascending: b_ascend)

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_Diaries_New.description => \(resOf_Diaries_New.description)")

        // return
        return -1
        
    }

}