//
//  VC_Preference.swift
//  Chapter6
//
//  Created by mac on 2016/03/01.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import UIKit
import RealmSwift

class VC_Preference: UIViewController {

    @IBOutlet weak var sw_Search_MemoColumn: UISwitch!

// MARK: actions
    @IBAction func sw_Action_Search_MemoColumn(sender: UISwitch) {
        
        if self.sw_Search_MemoColumn.on == true {
            
            // set the global var
            CONS.Prefs.b_Search_MemoColumn = true
            
            // set preference
            let defaults = NSUserDefaults.standardUserDefaults()
            
            defaults.setValue(true, forKey: CONS.defaultKeys.key_Search_MemoColumn)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] key_Search_MemoColumn => set true")
            
            
        } else {
            
            // set the global var
            CONS.Prefs.b_Search_MemoColumn = false
            
            // set preference
            let defaults = NSUserDefaults.standardUserDefaults()
            
            defaults.setValue(false, forKey: CONS.defaultKeys.key_Search_MemoColumn)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] key_Search_MemoColumn => set false")
            
        }
        
        
        
    }
    

    // MARK: view-related
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)

        // switches
        self._setup_Switches()
        
        
    }

    func _setup_Switches() {
        
        // Search memo column
        self._setup_Switch__Search_MemoColumn()
        
    }
    
    func _setup_Switch__Search_MemoColumn() {
        
        // set switch to
        // set preference
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //        var dfltVal_DebugMode = defaults.valueForKey(CONS.defaultKeys.key_Set_DebugMode)
        let dfltVal_Search_MemoColumn = defaults.valueForKey(CONS.defaultKeys.key_Search_MemoColumn)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_AddBM?.description => \(dfltVal_Search_MemoColumn?.description)")
        
        // validate: nil
        if dfltVal_Search_MemoColumn == nil {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_Search_MemoColumn => nil")
            
            // set the switch --> on
            self.sw_Search_MemoColumn.on = true
            
            // set value --> true
            defaults.setValue(true, forKey: CONS.defaultKeys.key_Search_MemoColumn)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_Search_MemoColumn set => true")
            
        } else {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_AddBM => NOT nil (value => \(dfltVal_Search_MemoColumn?.description)")
            
            // set switch --> accor. to the default value
            if dfltVal_Search_MemoColumn?.boolValue == true {
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_Search_MemoColumn => true")
                
                self.sw_Search_MemoColumn.on = true
                
            } else {
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_Search_MemoColumn => NOT true")
                
                self.sw_Search_MemoColumn.on = false
                
            }
            
        }
        
    }


}
