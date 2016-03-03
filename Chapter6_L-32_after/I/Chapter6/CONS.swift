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

//    static var s_Realm_FileName__Admin = "db_20160221_144128.admin.realm"
//    static var s_Realm_FileName__Admin = "db.admin.20160223_132200.realm"
//    static var s_Realm_FileName__Admin = "db.admin.20160223_140510.realm"
//    static var s_Realm_FileName__Admin = "db.admin.20160225_153543.realm"
    static var s_Realm_FileName__Admin = "db.admin.20160225_160544.realm"

    static var s_AdminKey__LastBackup = "admin_key_last_backup"
    
    static var s_AdminKey__Latest_Diary_at = "admin_key_latest_diary_at"
    
    static var s_LatestBackup_Diary_ModifiedAt = "s_LatestBackup_Diary_ModifiedAt"
    
//    static var s_Realm_FileName__New = "db_20160219_164456.realm"
//    static var s_Realm_FileName__New = "db_20160219_173550.realm"

    enum REALM {
    
        static var s_Realm_Backup_Directory_Name = "backups"

        static var s_Realm_FileName__Lock = "\(s_Realm_FileName__Admin).lock"

        static var s_Realm_FileName__Log = "\(s_Realm_FileName__Admin).log"

        static var s_Realm_FileName__Log_A = "\(s_Realm_FileName__Admin).log_a"

        static var s_Realm_FileName__Log_B = "\(s_Realm_FileName__Admin).log_b"

        static var s_Realm_FileName__Note = "\(s_Realm_FileName__Admin).note"

        static var s_Realm_Backup_Extension = "backup"

    }
    
    
    
    /* *************************************
        SandboxView-related
    ************************************* */
    static var keywords : [String] = [
    
        "start Memo", "end Memo",
        "start Player", "end Player",
        
        "start 琴", "end 琴",
        "start 仮眠", "end 仮眠",
        "plan today", "plan future",
        "plan today -DONE", "plan future -DONE",
        
        "start 歯磨き", "end 歯磨き",
    ]
    
    
    /* *************************************
        others
    ************************************* */
    static var s_Latest_Diary_at = ""
    
    
    /*

        preferences

    */
    static var b_DebugMode = false
 
    enum Prefs {
        
        static var b_Search_MemoColumn = false
        
    }
    
    /*
        keys
    */
    //ref http://stackoverflow.com/questions/28628225/how-do-you-save-local-storage-data-in-a-swift-application answered Feb 20 '15 at 12:15
    enum defaultKeys {
    
        static let key_Set_DebugMode = "key_Set_DebugMode"

        static let key_Search_MemoColumn = "key_Search_MemoColumn"

    }
    
    
    
}