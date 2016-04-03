//
//  BM.swift
//  avplayer
//
//  Created by mac on 2016/02/13.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

//import Foundation
import RealmSwift

class BM: Object {
    // 管理用 ID。プライマリーキー
    dynamic var id = 0
    
    // audio id
//    dynamic var audio_id = 0
    dynamic var audio_id = ""   //=>
    
    // タイトル
    dynamic var title = ""
    
    // 本文
    dynamic var memo = ""
    
    // time
    dynamic var bm_time = 0
    
    /// 最終更新日時
//    dynamic var modified_at = NSDate()
    dynamic var modified_at = ""
    
    //
//    dynamic var created_at = NSDate()
    dynamic var created_at = ""
    
    
    
    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func show_ClassName() ->Void {
        
        print("[\(Methods.basename(#file)):\(#line)] BM class")
        
    }

    
}
