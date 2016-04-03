//
//  PH.swift
//  avplayer
//
//  Created by mac on 2016/03/04.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import Foundation
import RealmSwift

// PH --> Play history

class PH: Object {
    // 管理用 ID。プライマリーキー
    dynamic var id = 0
    
    //
    dynamic var created_at = ""
    
    //
    dynamic var modified_at = ""
    
    dynamic var audio_id = ""
    
    dynamic var title = ""

    // memo --> memo attached to the clip
    dynamic var memo = ""
    
    dynamic var current_time    = 0
    
    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func show_ClassName() ->Void {
        
        print("[\(Methods.basename(#file)):\(#line)] PH class")
        
    }
    
    
}
