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
    
    var clip_title : String = ""
    var bm_time : Int = 0
    
    @IBOutlet weak var lbl_BM_Time: UILabel!
    @IBOutlet weak var lbl_ClipTitle: UILabel!
    
    @IBAction func update_BM(sender: UIButton) {

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] update_BM")

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
    
    func viewWillAppear__Setup_Views() {
        
        // set vars
        self.bm_time = CONS.e_VC_EditBM.bm_time
        
        self.clip_title = CONS.e_VC_EditBM.s_clip_title
        
        // view: title
        self.lbl_ClipTitle.text = self.clip_title
        
        // view --> bm time
        self.lbl_BM_Time.text = Methods.conv_Seconds_2_ClockLabel(self.bm_time)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] viewWillAppear__Setup_Views => done")
        
    }
    
}
