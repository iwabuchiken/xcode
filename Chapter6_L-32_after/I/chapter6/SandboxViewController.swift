//
//  SandboxViewController.swift
//  Chapter6
//
//  Created by mac on 2016/02/06.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import UIKit

class SandboxViewController: UIViewController {

    @IBOutlet weak var tf_SearchWords: UITextField!
    @IBOutlet weak var main_label: UILabel!

    @IBAction func close_OSKeyboard(sender: UIButton) {
        
        main_label.text = Methods.get_TimeLable()
        
        //test
        //ref https://akira-watson.com/iphone/textfield.html "ボタン等でendEditing()"
        self.view.endEditing(true)
        
    }
    

    @IBAction func set_SearchWords(sender: UIButton) {
    
//        tf_SearchWords.text = "search words"
        
        //ref http://egg-is-world.com/2016/01/29/swift2-uitextfield-text/
//        let tmp_s : String = tf_SearchWords.text ?? ""
        let tmp_s : String = tf_SearchWords.text!
        
//        // show message
//        tf_SearchWords.text = "search words are => \(tmp_s)"

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] search words are => \(tmp_s)")
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] calling => Methods.set_Defaults")
        
        // set defaults
        Methods.set_Defaults(tmp_s)
        
        // back to the original cont
        //self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] popViewControllerAnimated => done")
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        // Do any additional setup after loading the view.
 //       @IBAction func show(sender: AnyObject) {
   //         @IBAction func show(sender: UIButton) {
   //         }
   //     }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func show_Message(sender: UIButton) {
     
        //main_label.text = "thanks"

//        let date = NSDate.
//        main_label.text = NSDate().
        
//        let date = NSDate()
//        let calendar = NSCalendar.currentCalendar()
//        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
//        let hour = components.hour
//        let minutes = components.minute

        //ref http://www.appcoda.com/nsdate/
//        let dateComponents = NSDateComponents()
//        let day = dateComponents.day
//        let month = dateComponents.month
        
        //main_label.text = day + "/" + month
        //main_label.text = NSString(format: "%\(f)f", month)
        
        //main_label.text = String(day) + "/" + String(month)
//        main_label.text = NSDate().description
      
//        main_label.text = get_CurrentDate()
        
        // file i/o
        //ref http://stackoverflow.com/questions/29953612/swift-write-to-file-ios answered Apr 29 '15 at 20:54
        let docsPath = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask,
            true)[0] as! NSString
        
        main_label.text = docsPath as String
        
        //debug
        //ref http://stackoverflow.com/questions/30759158/using-the-split-function-in-swift-2 answered Jun 10 '15 at 14:27
        print("[\(__FILE__)] \(docsPath as String)")
        
        let tmp = (__FILE__).componentsSeparatedByString("/")
  
        let token_1 = tmp[0]
        
        print("[\(__FILE__):\(__LINE__)] file => '\(__FILE__)' || token_1 => '\(token_1)'")
        
        //debug
//        let str = "Hello Bob"
//        let strSplit = str.characters.split(" ")
//        String(strSplit.first!)
//        String(strSplit.last!)

        let str = __FILE__
//        let sp = str.characters.split("/")
        let sp = str.characters.split("/")
        
        print("first => '\(sp.first!)'")
        
        //debug
                let str_2 = "Hello Bob"
                let strSplit_2 = str_2.characters.split(" ")
                print("first! => '\(String(strSplit_2.first!))'")
//                String(strSplit_2.last!)
        
        
        //ref http://www.appcoda.com/nsdate/
//        let currentDate = NSDate()
//        
//        
//        let dateFormatter = NSDateFormatter()
//
//        dateFormatter.locale = NSLocale.currentLocale()
//
//        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
//        
//        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
//        
//        let convertedDate = dateFormatter.stringFromDate(currentDate)
//        
//        main_label.text = convertedDate
        
//        main_label.text = dateFormatter.locale.description
        

        
    }
    
    //ref return type https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html#//apple_ref/doc/uid/TP40014097-CH10-ID174
    func get_CurrentDate() ->String {

        let currentDate = NSDate()
        
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale.currentLocale()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        return dateFormatter.stringFromDate(currentDate)
        
//        let convertedDate = dateFormatter.stringFromDate(currentDate)

        
    }
    
    
    @IBAction func backTo_ViewController(sender: UIButton) {
        
        //self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] viewWillAppear")
        
        // get defaults
        let tmp_s : String = Methods.get_Defaults(CONS.key_SearchWords)
        
        //        let defaults = NSUserDefaults.standardUserDefaults()
        //
        ////        defaults.setValue(tmp_s, forKey: CONS.key_SearchWords)
        ////        let tmp_s : String? = (defaults.stringForKey(CONS.key_SearchWords))   //=> 'Optional(...)'
        //        let tmp_s : String = defaults.stringForKey(CONS.key_SearchWords)!   //=> '那覇'
        // set defaults to the label
        main_label.text = "'\(tmp_s)'"

        
    }

    
}
