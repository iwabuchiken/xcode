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

}
