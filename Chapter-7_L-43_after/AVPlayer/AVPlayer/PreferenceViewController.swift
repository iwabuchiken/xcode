//
//  PreferenceViewController.swift
//  avplayer
//
//  Created by mac on 2016/02/14.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import UIKit

class PreferenceViewController: UIViewController {

//    @IBOutlet weak var sw_DebugMode: UISwitch!
    @IBOutlet weak var sw_DebugMode: UISwitch!
    

    @IBAction func setPref_DebugMode(sender: UISwitch) {
        
        if sw_DebugMode.on {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] debug mode => on (\(sw_DebugMode.on))")
            
            // set the global var
            CONS.b_DebugMode = true
            
            // set preference
            let defaults = NSUserDefaults.standardUserDefaults()
            
            defaults.setValue(true, forKey: CONS.defaultKeys.key_Set_DebugMode)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] key_Set_DebugMode => true")

            
        } else {

            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] debug mode => off (\(sw_DebugMode.on))")

            // set the global var
            CONS.b_DebugMode = false

            // set preference
            let defaults = NSUserDefaults.standardUserDefaults()
            
            defaults.setValue(false, forKey: CONS.defaultKeys.key_Set_DebugMode)

            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] key_Set_DebugMode => false")

        }
        
    }
    
    override func viewWillAppear(animated: Bool) {

        _setup_Switch()

    }
    
    func _setup_Switch() {
        
        // set switch to
        // set preference
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //        var dfltVal_DebugMode = defaults.valueForKey(CONS.defaultKeys.key_Set_DebugMode)
        let dfltVal_DebugMode = defaults.valueForKey(CONS.defaultKeys.key_Set_DebugMode)
        
        //        dfltVal_DebugMode = dfltVal_DebugMode?.boolValue
        
//        //debug
//        //        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_DebugMode => \(dfltVal_DebugMode)")
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_DebugMode => \(dfltVal_DebugMode)")
        
        // judge
        if dfltVal_DebugMode?.boolValue == true {
            
//            //debug
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_DebugMode => true")
            
            // set swith => on
            sw_DebugMode.setOn(true, animated: true)
            
        } else {
            
//            //debug
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_DebugMode => false")
//            
            // set swith => off
            sw_DebugMode.setOn(false, animated: true)
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
