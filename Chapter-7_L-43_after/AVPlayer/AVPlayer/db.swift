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

    static func findAll_BM
    (dbfile_name : String,
        sort_key : String = "created_at",
        ascend : Bool) -> Array<BM> {

        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
        
//        let dataArray =  try! realm.objects(BM).sorted("created_at", ascending: false)
        let dataArray =  try! realm.objects(BM).sorted(sort_key, ascending: ascend)

        var bmArray = Array<BM>()
    
        for item in dataArray {
    
            bmArray.append(item)
    
        }
    
        return bmArray

    }

    static func findAll_BM__Filtered
        (dbfile_name : String,
        predicate : NSPredicate,
        sort_key : String = "created_at",
        ascend : Bool) -> Array<BM> {
            
            let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
            
            //        let dataArray =  try! realm.objects(BM).sorted("created_at", ascending: false)
//            let dataArray =  try! realm.objects(BM).sorted(sort_key, ascending: ascend)
            let dataArray =  try! realm.objects(BM).filter(predicate).sorted(sort_key, ascending: ascend)
            
            var bmArray = Array<BM>()
            
            for item in dataArray {
                
                bmArray.append(item)
                
            }
            
            return bmArray
            
    }

    static func isInDb__Clip_Title
        (dbname : String,  title : String) -> Bool {
        
            let query = "title == '\(title)'"
            
//            //debug
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] query => \(query)")
            
            
            let aPredicate = NSPredicate(format: query)

            
            let realm = Methods.get_RealmInstance(dbname)
            
            //        let dataArray =  try! realm.objects(BM).sorted("created_at", ascending: false)
            //            let dataArray =  try! realm.objects(BM).sorted(sort_key, ascending: ascend)
            let dataArray =  try! realm.objects(Clip).filter(aPredicate).sorted("id", ascending: false)
            
            for item in dataArray {
                
                let tmp = item.title
                
                if tmp == title {
                    
                    return true
                    
                }
                
            }


        return false
            
    }

    static func copy_BMs
    (dbname_old : String, dbname_new : String) -> Int {
        
        let realm = Methods.get_RealmInstance(dbname_old)
        
        //        let dataArray =  try! realm.objects(BM).sorted("created_at", ascending: false)
        let resOf_BMs_old =  try! realm.objects(BM).sorted("id", ascending: true)

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_BMs_old.count => \(resOf_BMs_old.count)")
        
//        /*
//            new realm file
//        */
//        let realm_new = Methods.get_RealmInstance(dbname_new)
//        
//        //        let dataArray =  try! realm_new.objects(BM).sorted("created_at", ascending: false)
//        let resOf_BMs_new =  try! realm_new.objects(BM_2).sorted("id", ascending: true)
//        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_BMs_new.count => \(resOf_BMs_new.count)")
//
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_BMs_new[0].description => \(resOf_BMs_new[0].description)")
        
        
        /*
            copy
        */
//        for item in resOf_BMs_old {
//
//            //debug
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] item.title => \(item.title)")
//
//            
//        }
        
        // return
        return -1

    }
    
}
