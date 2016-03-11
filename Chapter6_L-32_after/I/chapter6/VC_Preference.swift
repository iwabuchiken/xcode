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

    @IBOutlet weak var sw_Vibrate_WhenSaved: UISwitch!
    @IBOutlet weak var sw_GoBack_WhenSaved: UISwitch!
    @IBOutlet weak var sw_Search_MemoColumn: UISwitch!

// MARK: actions

    @IBAction func sw_action_Vibrate_WhenSaved(sender: UISwitch) {
        
        if self.sw_Vibrate_WhenSaved.on == true {
            
            // set the global var
            //            CONS.Prefs.b_Search_MemoColumn = true
            CONS.Prefs.b_Vibrate_WhenSaved = true
            
            // set preference
            let defaults = NSUserDefaults.standardUserDefaults()
            
            //            defaults.setValue(true, forKey: CONS.defaultKeys.key_Search_MemoColumn)
            defaults.setValue(true, forKey: CONS.defaultKeys.key_Vibrate_WhenSaved)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] key_Vibrate_WhenSaved => set true")
            
            
        } else {
            
            // set the global var
            //            CONS.Prefs.b_Search_MemoColumn = true
            CONS.Prefs.b_Vibrate_WhenSaved = false
            
            // set preference
            let defaults = NSUserDefaults.standardUserDefaults()
            
            //            defaults.setValue(true, forKey: CONS.defaultKeys.key_Search_MemoColumn)
            defaults.setValue(false, forKey: CONS.defaultKeys.key_Vibrate_WhenSaved)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] key_Vibrate_WhenSaved => set false")
            
        }

    }

    @IBAction func sw_Action_GoBack_WhenSaved(sender: UISwitch) {
        
        if self.sw_GoBack_WhenSaved.on == true {
            
            // set the global var
//            CONS.Prefs.b_Search_MemoColumn = true
            CONS.Prefs.b_GoBack_WhenSaved = true
          
            // set preference
            let defaults = NSUserDefaults.standardUserDefaults()
            
//            defaults.setValue(true, forKey: CONS.defaultKeys.key_Search_MemoColumn)
            defaults.setValue(true, forKey: CONS.defaultKeys.key_GoBack_WhenSaved)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] key_GoBack_WhenSaved => set true")
            
            
        } else {
            
            // set the global var
            //            CONS.Prefs.b_Search_MemoColumn = true
            CONS.Prefs.b_GoBack_WhenSaved = false
            
            // set preference
            let defaults = NSUserDefaults.standardUserDefaults()
            
            //            defaults.setValue(true, forKey: CONS.defaultKeys.key_Search_MemoColumn)
            defaults.setValue(false, forKey: CONS.defaultKeys.key_GoBack_WhenSaved)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] key_GoBack_WhenSaved => set false")
            
        }

        
    }

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
        
        self._setup_Switch__GoBack_WhenSaved()
        
        self._setup_Switch__Vibrate_WhenSaved()
        
    }
    
    func _setup_Switch__Vibrate_WhenSaved() {
        
        // set switch to
        // set preference
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //        var dfltVal_DebugMode = defaults.valueForKey(CONS.defaultKeys.key_Set_DebugMode)
        let dfltVal_key_Vibrate_WhenSaved = defaults.valueForKey(CONS.defaultKeys.key_Vibrate_WhenSaved)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_AddBM?.description => \(dfltVal_key_Vibrate_WhenSaved?.description)")
        
        // validate: nil
        if dfltVal_key_Vibrate_WhenSaved == nil {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_key_Vibrate_WhenSaved => nil")
            
            // set the switch --> on
            self.sw_Vibrate_WhenSaved.on = true
            
            // set value --> true
            defaults.setValue(true, forKey: CONS.defaultKeys.key_Vibrate_WhenSaved)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_key_Vibrate_WhenSaved set => true")
            
        } else {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_key_Vibrate_WhenSaved => NOT nil (value => \(dfltVal_key_Vibrate_WhenSaved?.description)")
            
            // set switch --> accor. to the default value
            if dfltVal_key_Vibrate_WhenSaved?.boolValue == true {
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_key_Vibrate_WhenSaved => true")
                
                self.sw_Vibrate_WhenSaved.on = true
                
            } else {
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_Search_MemoColumn => NOT true")
                
                self.sw_Vibrate_WhenSaved.on = false
                
            }
            
        }
        
    }
    
    func _setup_Switch__GoBack_WhenSaved() {
        
        // set switch to
        // set preference
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //        var dfltVal_DebugMode = defaults.valueForKey(CONS.defaultKeys.key_Set_DebugMode)
        let dfltVal_key_GoBack_WhenSaved = defaults.valueForKey(CONS.defaultKeys.key_GoBack_WhenSaved)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_AddBM?.description => \(dfltVal_key_GoBack_WhenSaved?.description)")
        
        // validate: nil
        if dfltVal_key_GoBack_WhenSaved == nil {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_key_GoBack_WhenSaved => nil")
            
            // set the switch --> on
            self.sw_GoBack_WhenSaved.on = true
            
            // set value --> true
            defaults.setValue(true, forKey: CONS.defaultKeys.key_GoBack_WhenSaved)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_key_GoBack_WhenSaved set => true")
            
        } else {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_key_GoBack_WhenSaved => NOT nil (value => \(dfltVal_key_GoBack_WhenSaved?.description)")
            
            // set switch --> accor. to the default value
            if dfltVal_key_GoBack_WhenSaved?.boolValue == true {
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_key_GoBack_WhenSaved => true")
                
                self.sw_GoBack_WhenSaved.on = true
                
            } else {
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_Search_MemoColumn => NOT true")
                
                self.sw_GoBack_WhenSaved.on = false
                
            }
            
        }
        
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
