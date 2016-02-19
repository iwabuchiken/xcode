//
//  BM_2.swift
//  avplayer
//
//  Created by mac on 2016/02/13.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

//import Foundation
import RealmSwift

class BM_2: Object {
    // 管理用 ID。プライマリーキー
    dynamic var id = 0
    
    dynamic var audio_id = ""   //=>
    
    // タイトル
    dynamic var title = ""
    
    // 本文
    dynamic var memo = ""
    
    // time
    dynamic var bm_time = 0
    
    /// 最終更新日時
//    dynamic var modified_at = NSDate()
    dynamic var modified_at = Methods.conv_NSDate_2_DateString(NSDate())
    
    //
    dynamic var created_at = Methods.conv_NSDate_2_DateString(NSDate())
    
    
    
    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func show_ClassName() ->Void {
        
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] BM class")
        
    }
    
    
}
