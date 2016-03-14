//
//  Admin.swift
//  Chapter6
//
//  Created by mac on 2016/02/21.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import RealmSwift

class Data: Object {
    // 管理用 ID。プライマリーキー
    dynamic var id = 0
    
    /// 最終更新日時
    dynamic var date = ""
    
    //
    dynamic var created_at = ""
    
    //
    dynamic var modified_at = ""
    
    //
    dynamic var name = ""
    
    //
    dynamic var s_1 = ""
    
    //
    dynamic var s_2 = ""
    
    //
    dynamic var i_1 = 0
    
    //
    dynamic var i_2 = 0
    
    // memo
    dynamic var memo = ""
    
    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func show_ClassName() ->Void {
        
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] Admin class")
        
    }
    
    
}
