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

    static func findAll_PHs__Filtered
        (dbfile_name : String,
        predicate : NSPredicate,
        sort_key : String = "created_at",
        ascend : Bool = true) -> Array<PH> {
            
            let realm = Methods.get_RealmInstance(CONS.RealmVars.s_Realm_FileName__Admin)
            
            //        let dataArray =  try! realm.objects(BM).sorted("created_at", ascending: false)
            //            let dataArray =  try! realm.objects(BM).sorted(sort_key, ascending: ascend)
            let dataArray =  try! realm.objects(PH).filter(predicate).sorted(sort_key, ascending: ascend)
            
            var bmArray = Array<PH>()
            
            for item in dataArray {
                
                bmArray.append(item)
                
            }
            
            return bmArray
            
    }

    static func findAll_Clips__Filtered
        (dbfile_name : String,
        predicate : NSPredicate,
        sort_key : String = "created_at",
        ascend : Bool = true) -> Array<Clip> {
            
//            let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
            let realm = Methods.get_RealmInstance(dbfile_name)
            
            let dataArray =  try! realm.objects(Clip).filter(predicate).sorted(sort_key, ascending: ascend)
            
            var bmArray = Array<Clip>()
            
            for item in dataArray {
                
                bmArray.append(item)
                
            }
            
            return bmArray
            
    }

    static func isInDb__Clip_Title
        (dbname : String,  title : String) -> Bool {
        
            let query = "title == '\(title)'"
            
//            //debug
//            print("[\(Methods.basename(#file)):\(#line)] query => \(query)")
            
            
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
        
//        //debug
//        print("[\(Methods.basename(#file)):\(#line)] defaultConfiguration.path => \(Realm.Configuration.defaultConfiguration.path as! NSString)")
        
        
        let realm = Methods.get_RealmInstance(dbname_old)
//        let realm = Methods.get_RealmInstance__Identifier(CONS.s_Realm_FileName)
        
        //        let dataArray =  try! realm.objects(BM).sorted("created_at", ascending: false)
        let resOf_BMs_old =  try! realm.objects(BM).sorted("id", ascending: true)

        //debug
        print("[\(Methods.basename(#file)):\(#line)] resOf_BMs_old.count => \(resOf_BMs_old.count)")
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] resOf_BMs_old[0].description => \(resOf_BMs_old[0].description)")
        
        /*
            migrate
        */
//        let config = Realm.Configuration(
//            // Set the new schema version. This must be greater than the previously used
//            // version (if you've never set a schema version before, the version is 0).
//            schemaVersion: 1,
//            
//            // Set the block which will be called automatically when opening a Realm with
//            // a schema version lower than the one set above
//            migrationBlock: { migration, oldSchemaVersion in
//                // We haven’t migrated anything yet, so oldSchemaVersion == 0
//                if (oldSchemaVersion < 1) {
//                    // Nothing to do!
//                    // Realm will automatically detect new properties and removed properties
//                    // And will update the schema on disk automatically
//                }
//        })
//        
//        // Tell Realm to use this new configuration object for the default Realm
//        Realm.Configuration.defaultConfiguration = config
//        
////        // Now that we've told Realm how to handle the schema change, opening the file
////        // will automatically perform the migration
////        let realm = try! Realm()
//        
//        /*
//            new realm file
//        */
//        let realmPath = Realm.Configuration.defaultConfiguration.path
//        
//        let dpath_realm = Methods.dirname(realmPath!)
//        
//        
//        //        let rl_tmp = try! Realm(path: "abc.realm")    //=> permission denied
//        //        return try! Realm(path: "\(dpath_realm)/abc.realm")   //=> works
//        let realm_new = try! Realm(path: "\(dpath_realm)/\(dbname_new)")   //=> works
//
////        let realm_new = Methods.get_RealmInstance(dbname_new)
//        
////            let dataArray =  try! realm_new.objects(BM).sorted("created_at", ascending: false)
//        let resOf_BMs_new =  try! realm_new.objects(BM_2).sorted("id", ascending: true)
//
//        //debug
//        print("[\(Methods.basename(#file)):\(#line)] resOf_BMs_new.count => \(resOf_BMs_new.count)")
//
//        //debug
//        print("[\(Methods.basename(#file)):\(#line)] resOf_BMs_new[0].description => \(resOf_BMs_new[0].description)")
        
        
        /*
            copy
        */
//        for item in resOf_BMs_old {
//
//            //debug
//            print("[\(Methods.basename(#file)):\(#line)] item.title => \(item.title)")
//
//            
//        }
        
        // return
        return -1

    }

    /*
        @return
        -1      => no bms
    */
    static func delete_BMs__ByTitle(title : String) -> Int {

        var count = 0   // num of deletion
        
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
        
        let query = "title == '\(title)'"
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] query => \(query)")
        
        
        let aPredicate = NSPredicate(format: query)
        
        let bmArray = DB.findAll_BM__Filtered(
            CONS.s_Realm_FileName,  predicate: aPredicate, sort_key: "created_at", ascend: false)
        
        // validate --> any entry?
        if bmArray.count < 1 {
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] no bms for --> \(title)")

            // return
            return -1
            
        } else {

            // temp array
            var tmpArray : [BM] = Array<BM>()
            
            var len = bmArray.count
            
//            for i in [0..<len] {
            for item in bmArray {
            
                tmpArray.append(item)
                
            }
            
            
//            for bm in bmArray {
//            for var i in [0..<len] {
//            for var i in 0...(len-1) {
            for var i in 1...(len-1) {
            
                let b = bmArray[i]
                
                do {
                
                    try! realm.write {

                        //debug
                        print("[\(Methods.basename(#file)):\(#line)] bm deleting... --> \(title) <\(Methods.conv_Seconds_2_ClockLabel(b.bm_time))>")
                        

                        realm.delete(b)
                        
                        //debug
                        print("[\(Methods.basename(#file)):\(#line)] bm deleted --> \(title) <\(Methods.conv_Seconds_2_ClockLabel(b.bm_time))>")
                        
                        count += 1
                        
                    }
                   
//                } catch let error as RLMException {
//                    
//                aaa
                    
                    
                } catch is NSException {
                    
                    //debug
                    print("[\(Methods.basename(#file)):\(#line)] NSException => \(NSException.description())")
                    
                        //ref https://www.bignerdranch.com/blog/error-handling-in-swift-2/
                } catch let error as NSError {
                    
                    //debug
                    //                print("[\(Methods.basename(#file)):\(#line)] NSError => \(NSException.description())")  //=> build succeeded
                    print("[\(Methods.basename(#file)):\(#line)] NSError => \(error.description)")  //=> build succeeded
                    
                }
            
            }//for bm in bmArray
            
        }

        //return
        return count
        
    }//delete_BMs__ByTitle
}
