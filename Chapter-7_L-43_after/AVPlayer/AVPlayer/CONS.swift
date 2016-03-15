//
//  CONS.swift
//  Chapter6
//
//  Created by mac on 2016/02/08.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class CONS {

    enum Colors {

        static var col_White = UIColor(
            red:1.0,
            green:1.0,
            blue:1.0,
            alpha:1.0)
        
        static var col_Gray_050505 = UIColor(
            red:0.5,
            green:0.5,
            blue:0.5,
            alpha:1.0)
        
        static var col_Black = UIColor(
            red:0.0,
            green:0.0,
            blue:0.0,
            alpha:1.0)

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
    }
    
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

    static var s_Realm_FileName__Admin = "db.admin.20160314_093539.realm"
    
    static var s_LatestBackup_BM_ModifiedAt = "s_LatestBackup_BM_ModifiedAt"
    
//    static var s_Realm_FileName__New = "db_20160219_164456.realm"
//    static var s_Realm_FileName__New = "db_20160219_173550.realm"
    
    enum RealmVars {
        
        static var realm : Realm?
        
        static let s_Realm_FileName__Admin = "db.admin.20160304_235307.realm"

        static var s_Realm_Backup_Directory_Name = "backups"
        
        static var s_Realm_FileName__Lock = "\(s_Realm_FileName__Admin).lock"
        static var s_Realm_FileName__Log = "\(s_Realm_FileName__Admin).log"
        static var s_Realm_FileName__Log_A = "\(s_Realm_FileName__Admin).log_a"
        static var s_Realm_FileName__Log_B = "\(s_Realm_FileName__Admin).log_b"
        static var s_Realm_FileName__Note = "\(s_Realm_FileName__Admin).note"
        
        static var s_Realm_Backup_Extension = "backup"

    }
    
    
    /*

        preferences

    */
    static var b_DebugMode = false
 
 
    enum PrefValues {
        
        static var b_AddBM = false

        static var b_BMView_EditMode = false

    }
    /*
        keys
    */
    //ref http://stackoverflow.com/questions/28628225/how-do-you-save-local-storage-data-in-a-swift-application answered Feb 20 '15 at 12:15
    //ref tut http://appventure.me/2015/10/17/advanced-practical-enum-examples/#sec-1-1
    enum defaultKeys {
    
        static let key_Set_DebugMode = "key_Set_DebugMode"
        
        static let key_Pref_AddBM = "key_Pref_AddBM"

        static let key_Pref_BM_EditMemo = "key_Pref_BM_EditMemo"
    
    }
    
    /*
        BMView-related
    */
    static var current_time : Int = 0
    
    static var value_Per_OneStep_Forwards   = 20  // unit=seconds
    static var value_Per_OneStep_Backwards  = -20  // unit=seconds

    /*
        VC_EditBM-related
    */
    enum e_VC_EditBM {
        
        static var s_clip_title = ""

        static var bm_time = 0
        
        static var bm : BM = BM()
        
    }
    
    /*
        segue-related
    */
    static let segname_Segue_CurrentTime_2_PlayerView = "segue_CurrentTime_2_PlayerView"
 
    /* *************************************
    others
    ************************************* */
//    static var s_Latest_Diary_at = ""
    static var s_Latest_BM_at = ""      // to be saved in the defaults

    
}