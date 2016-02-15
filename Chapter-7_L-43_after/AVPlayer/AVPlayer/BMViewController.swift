//
//  BMViewController.swift
//  avplayer
//
//  Created by mac on 2016/02/14.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import UIKit

class BMViewController: UIViewController {

    @IBOutlet weak var lbl_Title: UILabel!
    
    var song_title : String!
    
    override func viewWillAppear(animated: Bool) {

        // set title to -> label
        lbl_Title.text = self.song_title
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] label set => \(lbl_Title.text)")

        
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
