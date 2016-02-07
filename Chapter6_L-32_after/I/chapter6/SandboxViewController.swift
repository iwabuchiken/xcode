//
//  SandboxViewController.swift
//  Chapter6
//
//  Created by mac on 2016/02/06.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import UIKit

class SandboxViewController: UIViewController {

    @IBOutlet weak var main_label: UILabel!
    
    
    
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
        
        //ref http://www.appcoda.com/nsdate/
        let currentDate = NSDate()
        
        
        let dateFormatter = NSDateFormatter()

        dateFormatter.locale = NSLocale.currentLocale()

        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        let convertedDate = dateFormatter.stringFromDate(currentDate)
        
        main_label.text = convertedDate
        
//        main_label.text = dateFormatter.locale.description
        
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

}
