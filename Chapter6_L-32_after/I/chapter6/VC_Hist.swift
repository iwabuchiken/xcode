//
//  VC_Hist.swift
//  Chapter6
//
//  Created by mac on 2016/03/03.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import UIKit
import RealmSwift
import MessageUI

class VC_Hist: UIViewController {

    @IBAction func backTo_SandboxView(sender: UIButton) {
        
//        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    // MARK: view-related
    override func viewDidLoad() {

        super.viewDidLoad()
        
        
    }
    
    
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
    }

    
}
