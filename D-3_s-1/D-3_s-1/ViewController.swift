//
//  ViewController.swift
//  D-3_s-1
//
//  Created by mac on 2016/01/29.
//  Copyright © 2016年 livetill150. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTextField: UITextField!
    @IBAction func tapHandler(sender: AnyObject) {
        
        myTextField.text = "Thanks";
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

