//
//  VC_Edit_ClipMemo.swift
//  avplayer
//
//  Created by mac on 2016/03/07.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import UIKit

import RealmSwift
import MessageUI

import AudioToolbox

class VC_Edit_ClipMemo: UIViewController {

    var current_clip : Clip?
    
    @IBOutlet weak var tv_ClipMemo: UITextView!

    @IBOutlet weak var tv_ClipTitle: UITextView!
    
// MARK: uibuttons
    @IBAction func uib_Clear(sender: UIButton) {
        
        self.tv_ClipMemo.text = ""
        
    }
    
    @IBAction func uib_Save(sender: UIButton) {
        
        // update memo
        Proj.update_Clip__Memo(self.current_clip!, memo: self.tv_ClipMemo.text)
        
      
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] clip updated => \(self.current_clip?.description)")
        
        // vibrate
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)

    }
    
    @IBAction func uib_Back(sender: UIButton) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func uib_Close_OSKeyboard(sender: UIButton) {
        
        self.view.endEditing(true)
        
    }
    

    // MARK: view-related funcs
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear
        (animated: Bool) {
            
        super.viewWillAppear(true)
            
        // views
        _viewWillAppear__Setup_Views()
            
    }
    
    func _viewWillAppear__Setup_Views() {
    
        // clip title
        self.tv_ClipTitle?.text = self.current_clip?.title
        
        // clip memo
        self.tv_ClipMemo.text = self.current_clip?.memos
        
        // alignment
        self.tv_ClipMemo.textAlignment = NSTextAlignment.Left
        

    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
    }

}
