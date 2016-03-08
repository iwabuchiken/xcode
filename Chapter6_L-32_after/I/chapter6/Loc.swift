//
//  Loc.swift
//  Chapter6
//
//  Created by mac on 2016/03/08.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import Foundation
import RealmSwift

class Loc: Object {
    // 管理用 ID。プライマリーキー
    dynamic var id = 0
    
    //
    dynamic var created_at = ""
    
    //
    dynamic var modified_at = ""
    
    //
    dynamic var lat : Double = 0
    
    //
    dynamic var longi : Double = 0
    
    // memo
    dynamic var memo = ""
    
    // memo
    dynamic var status = ""

    //
    dynamic var removed_at = ""
    

    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func show_ClassName() ->Void {
        
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] Hist class")
        
    }
    
    
}
