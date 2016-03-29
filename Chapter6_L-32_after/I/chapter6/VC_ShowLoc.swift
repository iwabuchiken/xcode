//
//  VC_ShowLoc.swift
//  Chapter6
//
//  Created by mac on 2016/03/29.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class VC_ShowLoc: UIViewController {

    // MARK: vars
    var loc : Loc?
//    var longi : Double! = 0;
//    var lat : Double! = 0;
    
    // MARK: view-related
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
    }
    
    
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] viewWillAppear")
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] self.loc?.description => \(self.loc?.description)")
        
        
    }

}
