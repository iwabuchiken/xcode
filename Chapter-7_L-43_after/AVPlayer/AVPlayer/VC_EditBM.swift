//
//  VC_EditBM.swift
//  avplayer
//
//  Created by mac on 2016/02/29.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import RealmSwift
import MediaPlayer

class VC_EditBM: UIViewController {

    // realm
    let rl_tmp = Methods.get_RealmInstance(CONS.s_Realm_FileName)

    var clip_title : String = ""
    var bm_time : Int = 0
    
    @IBOutlet weak var lbl_BM_Time: UILabel!
    @IBOutlet weak var lbl_ClipTitle: UILabel!
    @IBOutlet weak var tf_Memo: UITextField!

    @IBAction func close_OSKeyboard(sender: UIButton) {
        
        //test
        //ref https://akira-watson.com/iphone/textfield.html "ボタン等でendEditing()"
        self.view.endEditing(true)
        
    }

    @IBAction func update_BM(sender: UIButton) {

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] update_BM")

        /*
            memo
        */
        let memo = self.tf_Memo.text
        
        let id = CONS.e_VC_EditBM.bm.id
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] new memo => '\(memo)' (bm id => '\(id)')")
        
        // update
        CONS.e_VC_EditBM.bm.memo = memo!
        
        self.update_BM_execute()
//        Proj.update_BM(CONS.e_VC_EditBM.bm)
        
        
//        //self.dismissViewControllerAnimated(true, completion: nil)
//        self.navigationController?.popViewControllerAnimated(true)

        // back
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    override func viewWillAppear(animated: Bool) {

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] viewWillAppear")

        // setup --> views
        viewWillAppear__Setup_Views()
        
    }
    
    func update_BM_execute() {

//        // realm
//        let rl_tmp = Methods.get_RealmInstance(CONS.s_Realm_FileName)

    //        try! realm.write {
    //            self.diary.title = self.titleTextField.text!
    //            self.diary.body = self.bodyTextView.text
    //            self.diary.date = NSDate()
    //            self.realm.add(self.diary, update: true)
    //        }
        
        // time -> meta
        let tmp_time = NSDate()

        let bm = CONS.e_VC_EditBM.bm
        
        bm.modified_at = Methods.conv_NSDate_2_DateString(tmp_time)

//        try! rl_tmp.write {
        try! CONS.RealmVars.realm!.write {

            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] 'write' block starting...)")

            //        self.realm.add(self.diary, update: true)
            
//            rl_tmp.add(bm, update: true)
//            self.rl_tmp.add(bm, update: true)
            CONS.RealmVars.realm!.add(bm, update: true)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm => updated (\(bm.description)")
            
        }

        
    }
    
    func viewWillAppear__Setup_Views() {
        
        // set vars
        self.bm_time = CONS.e_VC_EditBM.bm_time
        
//        self.clip_title = CONS.e_VC_EditBM.s_clip_title
        self.clip_title = CONS.e_VC_EditBM.bm.title
        
        // view: title
        self.lbl_ClipTitle.text = self.clip_title
        
        // view --> bm time
        self.lbl_BM_Time.text = Methods.conv_Seconds_2_ClockLabel(self.bm_time)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] viewWillAppear__Setup_Views => done")
        
    }
    
}
