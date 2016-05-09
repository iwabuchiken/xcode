//
//  Hist.swift
//  Chapter6
//
//  Created by mac on 2016/03/02.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import Foundation
import RealmSwift

class Hist: Object {
    // 管理用 ID。プライマリーキー
    dynamic var id = 0
    
    //
    dynamic var created_at = ""
    
    //
    dynamic var modified_at = ""
    
    //
    dynamic var keywords = ""
    
    // memo
    dynamic var memo = ""
    
    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func show_ClassName() ->Void {
        
        print("[\(Methods.basename(#file)):\(#line)] Hist class")
        
    }
    
    
}
