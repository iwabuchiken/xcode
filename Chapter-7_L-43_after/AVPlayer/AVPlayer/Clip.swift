//
//  BM.swift
//  avplayer
//
//  Created by mac on 2016/02/13.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

//import Foundation
import RealmSwift

class Clip: Object {
    
    // 管理用 ID。プライマリーキー
    dynamic var id = 0
    
    dynamic var created_at = ""
    dynamic var modified_at = ""
    
    // audio id
//    dynamic var audio_id = 0
    dynamic var audio_id = ""
    
    dynamic var title = ""
    dynamic var memos = ""

    dynamic var current_time    = 0
    dynamic var length          = 0
    dynamic var numof_bms       = 0
    
    dynamic var removed_at      = ""
    dynamic var last_played_at  = ""
    
    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func show_ClassName() ->Void {
        
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] Clip class")
        
    }
    
    
}
