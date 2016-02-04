//
//  HistoryViewController.swift
//  Chapter5
//
//  Created by mac on 2016/02/01.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var textview: UITextView!
    
    
    //var calcHistory: Array<Double> = []
    var calcHistory: Array<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //for result: Double in calcHistory {
        for result: Int in calcHistory {
            
            textview.text = textview.text + ("\(result)\n")
            
        }
        
    }

    @IBAction func back(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
