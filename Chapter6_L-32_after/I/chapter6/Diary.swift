//
//  Diary.swift
//  Chapter6
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import RealmSwift

class Diary: Object {
    // 管理用 ID。プライマリーキー
    dynamic var id = 0
    
    // タイトル
    dynamic var title = ""
    
    // 本文
    dynamic var body = ""
    
//    //test
//    //ref http://stackoverflow.com/questions/24137212/initialize-class-method-for-classes-in-swift
//    private var once = dispatch_once_t()
//    
//    required init () {
//        dispatch_once(&once) {
//            // Do stuff
//            
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] a Diary => inited")
//            
//            self.title   = ""
//            self.body    = ""
//            
//        }
//    }
    
    /// 最終更新日時
    dynamic var date = NSDate()
    
    //
    dynamic var created_at = NSDate()
    
    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func show_ClassName() ->Void {
        
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] Diary class")
        
    }
    
    
}
