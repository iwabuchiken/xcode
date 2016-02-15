//
//  CONS.swift
//  Chapter6
//
//  Created by mac on 2016/02/08.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import Foundation
import UIKit

class CONS {

    static var col_green_soft = UIColor(
        red:0.2,
        green:1.0,
        blue:0.0,
        alpha:1.0)
    
    static var col_green_071000 = UIColor(
        red:0.7,
        green:1.0,
        blue:0.0,
        alpha:1.0)

    static var col_Blue_020510 = UIColor(
        red:    0.2,
        green:  0.5,
        blue:   1.0,
        alpha:  1.0)

    static var col_Blue_020710 = UIColor(
        red:    0.2,
        green:  0.7,
        blue:   1.0,
        alpha:  1.0)
    
    static var key_SearchWords = "key_SearchWords"
 
    static var s_DirSeparator = "/"
 
    /***********************************
    
        realm

     ***********************************/
//    static var s_Realm_FileName = "abc.realm"
    static var s_Realm_FileName = "db.realm"

    /*

        preferences

    */
    static var b_DebugMode = false
 
    /*
        keys
    */
    enum defaultKeys {
    
        static let key_Set_DebugMode = "key_Set_DebugMode"
    
    }
    
    
    
}