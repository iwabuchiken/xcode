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
//    static var s_Realm_FileName = "db.realm"
//    static var s_Realm_FileName = "db_20160219_173550.realm"
//    static var s_Realm_FileName = "db_20160219_182006.realm"
//    static var s_Realm_FileName = "db_20160219_210510.realm"
    static var s_Realm_FileName = "db_20160220_002443.realm"

    static var s_Realm_FileName__Admin = "db_20160221_144128.admin.realm"

    static var s_AdminKey__LastBackup = "admin_key_last_backup"
    
//    static var s_Realm_FileName__New = "db_20160219_164456.realm"
//    static var s_Realm_FileName__New = "db_20160219_173550.realm"
    
    
    
    /*

        preferences

    */
    static var b_DebugMode = false
 
    /*
        keys
    */
    //ref http://stackoverflow.com/questions/28628225/how-do-you-save-local-storage-data-in-a-swift-application answered Feb 20 '15 at 12:15
    enum defaultKeys {
    
        static let key_Set_DebugMode = "key_Set_DebugMode"
    
    }
    
    
    
}