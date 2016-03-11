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
    
//    @IBOutlet weak var lbl_BM_Time: UILabel!
    @IBOutlet weak var lbl_ClipTitle: UILabel!
    @IBOutlet weak var tf_Memo: UITextField!

    @IBOutlet weak var tf_BM_Time: UITextField!

    @IBAction func delete_BM(sender: UIButton) {
        
        // confirm
        let s_title = "Alert"
        
        let choice_1 = "OK"
        let choice_2 = "Cancel"
        
        //        let s_message = "(1) show realm files list (2) B (3) C"
        //        let s_message = "\(choice_1) \(choice_2) \(choice_3)"
        let s_message = "Delete BM ?"
        
        let refreshAlert = UIAlertController(title: s_title, message: s_message, preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: choice_1, style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] chosen => 1")
            
            // execute
            self._delete_BM__OK()
            
        }))

        refreshAlert.addAction(UIAlertAction(title: choice_2, style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] chosen => 2")
            
            
        }))
        
        // show dialog
        // show view
        presentViewController(refreshAlert, animated: true, completion: nil)

        
    }

    func _delete_BM__OK() {
        
        try! CONS.RealmVars.realm!.write {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] 'write' block starting...)")
            
            //        self.realm.add(self.diary, update: true)
            
            //            rl_tmp.add(bm, update: true)
            //            self.rl_tmp.add(bm, update: true)
            CONS.RealmVars.realm!.delete(CONS.e_VC_EditBM.bm)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm => updated (\(CONS.e_VC_EditBM.bm.description)")
            
            // back
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
    }
    
    @IBAction func cancel_Controller(sender: UIButton) {

        // back
        self.dismissViewControllerAnimated(true, completion: nil)

    }

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

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] CONS.e_VC_EditBM.bm.memo => updating...")

//        // update
//        CONS.e_VC_EditBM.bm.memo = memo!
        
        let res = self.update_BM_execute()
//        Proj.update_BM(CONS.e_VC_EditBM.bm)
        
        // valid: valid format?
        if res == false {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] invalid bm time format --> exiting the method")

            // show message
            Methods.show_Dialog_OK(self, title: "Invlaid time format", message: self.tf_BM_Time.text!)
            
            return
            
        }
        
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
    
    func update_BM_execute() -> Bool {

        var result = true
        
        try! CONS.RealmVars.realm!.write {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] 'write' block starting...)")
            
            // time -> meta
            let tmp_time = NSDate()
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] CONS.e_VC_EditBM.bm.modified_at => modifying...")
            
            CONS.e_VC_EditBM.bm.modified_at = Methods.conv_NSDate_2_DateString(tmp_time)

            // update
//            CONS.e_VC_EditBM.bm.memo = memo!
            CONS.e_VC_EditBM.bm.memo = self.tf_Memo.text!

            // bm time
            let valid = Methods.validate_Format__ClockLabel((self.tf_BM_Time.text)!)

            if valid == false {

                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] invalid format => \((self.tf_BM_Time.text)!)")
                
//                return false
                
                result = false
                
                
                
            } else {
            
                // bm time
                let bm_time = Methods.conv_ClockLabel_2_Seconds((self.tf_BM_Time.text)!)
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] CONS.e_VC_EditBM.bm.modified_at => bm_time => \(bm_time)")

                CONS.e_VC_EditBM.bm.bm_time = bm_time
                
                //        self.realm.add(self.diary, update: true)
                
                //            rl_tmp.add(bm, update: true)
                //            self.rl_tmp.add(bm, update: true)
                CONS.RealmVars.realm!.add(CONS.e_VC_EditBM.bm, update: true)
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm => added (\(CONS.e_VC_EditBM.bm.description)")
                
            }//if valid == false
            
        }//try! CONS.RealmVars.realm!.write

        return result
        
    }

    func update_BM_execute__deprecated() {
        
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
        
//        // view --> bm time
//        self.lbl_BM_Time.text = Methods.conv_Seconds_2_ClockLabel(self.bm_time)
        self.tf_BM_Time.text = Methods.conv_Seconds_2_ClockLabel(self.bm_time)
        
        // memo
        self.tf_Memo.text = CONS.e_VC_EditBM.bm.memo
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] viewWillAppear__Setup_Views => done")
        
    }
    
}
