//
//  ViewController.swift
//  Chapter5
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit

let calcHistoryKey: String = "calcHistoryUserdefaultKey"

class ViewController: UIViewController {
    
    // flags
    var usrInputting: Bool = false
    var currentOp: String = ""
    
    var result: Int = 0
    
    @IBAction func inputNumber(sender: UIButton) {
        
        var displayNum: String = "0"
        
        if !usrInputting {
            
            usrInputting = true
            
            displayNum = (sender.titleLabel?.text)!
            
        } else {
            
            displayNum = displayLabel.text!
            
            displayNum += (sender.titleLabel?.text)!
            
        }
        
        displayLabel.text = displayNum
        
    }

    @IBAction func clearDisplay(sender: UIButton) {
        
        displayLabel.text = "0"
        
        usrInputting = false
        
        // clear result
        result = 0
        
        // clear flag: currentOp
        currentOp = ""
        
    }
    @IBAction func addNumbers(sender: UIButton) {
        
        // operation
        //ref http://stackoverflow.com/questions/30739460/toint-removed-in-swift-2 answered Jun 9 '15 at 18:02
        //result += (displayLabel?.text)!
        result += Int(displayLabel.text!)!
        
        // clear display
        //displayLabel.text = "0"
        displayLabel.text = String(result)
        
        // clear flag
        usrInputting = false
        
        // set flag => currentOp
        currentOp = "+"
        
    }
    
    @IBOutlet weak var msgLabel: UILabel!
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBAction func getResult(sender: UIButton) {
        
        // get result
        //if currentOp == "+" {
        if currentOp == "+" && usrInputting == true {
            
            result += Int(displayLabel.text!)!
            
        }
        
        // display result
        displayLabel.text = String(result)
        
        // save history
        saveHistory(result)
        
        // clear result
        result = 0
        
        // clear flag => usrInputting
        usrInputting = false
        
        // clear flag: currentOp
        currentOp = ""
        
    }//@IBAction func getResult(sender: UIButton)
    
    // array of result values
    lazy var calcHistory: Array<Int> = []
    
    func saveHistory(result: Int) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        calcHistory.append(result)
        
        defaults.setObject(calcHistory, forKey: calcHistoryKey)
        
        defaults.synchronize()
        
        // message
        msgLabel.text = "synchronized!"
        
    }//saveHistory(result: Int)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let historyViewController: HistoryViewController = segue.destinationViewController as! HistoryViewController
        
        historyViewController.calcHistory = calcHistory
        
    }

}

