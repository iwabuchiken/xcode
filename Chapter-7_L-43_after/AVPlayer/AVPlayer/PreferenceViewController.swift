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
            
        } else {

            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] debug mode => off (\(sw_DebugMode.on))")

            // set the global var
            CONS.b_DebugMode = false

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
