//
//  db.swift
//  avplayer
//
//  Created by mac on 2016/02/16.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import Foundation

import AVKit
import AVFoundation
import RealmSwift


class DB {

    static func findAll_Admin
    (dbfile_name : String,
        sort_key : String = "created_at",
        ascend : Bool = true) -> Array<Admin> {

        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
        
        let dataArray =  try! realm.objects(Admin).sorted(sort_key, ascending: ascend)

        var adminArray = Array<Admin>()
    
        for item in dataArray {
    
            adminArray.append(item)
    
        }
    
        return adminArray

    }

    static func findAll_Admin__Filtered
        (dbfile_name : String,
        predicate : NSPredicate,
        sort_key : String = "created_at",
        ascend : Bool) -> Array<Admin> {
            
            let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
            
            let dataArray =  try! realm.objects(Admin).filter(predicate).sorted(sort_key, ascending: ascend)
            
            var adminArray = Array<Admin>()
            
            for item in dataArray {
                
                adminArray.append(item)
                
            }
            
            return adminArray
            
    }

    static func findAll_Diary
        (dbfile_name : String,
        sort_key : String = "created_at",
        ascend : Bool = true) -> Array<Diary> {
            
            let realm = Methods.get_RealmInstance(dbfile_name)
            
            let dataArray =  try! realm.objects(Diary).sorted(sort_key, ascending: ascend)
            
            var diaryArray = Array<Diary>()
            
            for item in dataArray {
                
                diaryArray.append(item)
                
            }
            
            return diaryArray
            
    }

    static func findAll_Data
        (dbfile_name : String,
        sort_key : String = "created_at",
        ascend : Bool = true) -> Array<Data> {
            
            let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
            
            let resOf_Data =  try! realm.objects(Data).sorted(sort_key, ascending: ascend)
            
            var aryOf_Data = Array<Data>()
            
            for item in resOf_Data {
                
                aryOf_Data.append(item)
                
            }
            
            return aryOf_Data
            
    }

    static func findAll_Data__Filtered
        (dbfile_name : String,
        predicate : NSPredicate,
        sort_key : String = "created_at",
        ascend : Bool) -> Array<Data> {
            
            let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
            
            let dataArray =  try! realm.objects(Data).filter(predicate).sorted(sort_key, ascending: ascend)
            
            var adminArray = Array<Data>()
            
            for item in dataArray {
                
                adminArray.append(item)
                
            }
            
            return adminArray
            
    }

}
