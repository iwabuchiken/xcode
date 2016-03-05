//
//  VC_PH.swift
//  avplayer
//
//  Created by mac on 2016/03/05.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import UIKit
import MediaPlayer
import RealmSwift
import MessageUI

class VC_PH: UIViewController {

    // MARK: view-related funcs
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear
    (animated: Bool) {

        super.viewWillAppear(true)

    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] viewDidLoad")

    }

    
}
