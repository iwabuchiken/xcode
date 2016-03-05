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

class VC_PH: UIViewController, UITableViewDelegate, UITableViewDataSource {

    /*
        vars
    */
    var phs = Array<PH>()

    @IBAction func backTo_MusicList(sender: UIButton) {

        self.navigationController?.popViewControllerAnimated(true)
        
        
    }

    
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

        // hide => tab bar
        self.tabBarController?.tabBar.hidden = true

        // build --> PH list
        self.phs = Proj.find_All_PHs(ascend : false)
        
    }

    // MARK: UITableViewDataSource プロトコルのメソッド
    // TableView の各セクションのセルの数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //    return songs.count
        return self.phs.count
        
    }
    
    // 各セルの内容を返す
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        //    let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        // Cellに値を設定する.
//        cell.textLabel?.text = "row \(indexPath.row)"
        cell.textLabel?.text = self.phs[indexPath.row].title
        
        cell.detailTextLabel?.text = "\(Methods.conv_Seconds_2_ClockLabel(self.phs[indexPath.row].current_time))"
        
        //        cell.detailTextLabel?.text = clips[indexPath.row].memos
        
        /*
            validate: clip exists in the MediaItems
        */
        
        _tableView__CellForRow__ClipExists_InMediaItems(indexPath.row)
        
//        let res = Proj.mediaItem_Exists(self.phs[indexPath.row].title, audio_id: self.phs[indexPath.row].audio_id)
        
        
        return cell
        
    }
    
    func _tableView__CellForRow__ClipExists_InMediaItems
    (index : Int) -> Bool {
            
            let clip = self.phs[index]
            
            let title = clip.title
            let audio_id = clip.audio_id
            
            let query = "title == '\(title)' AND audio_id = '\(audio_id)'"
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] query => \(query)")
            
            let aPredicate = NSPredicate(format: query)
            
        let res_b = DB.findAll_Clips__Filtered(CONS.s_Realm_FileName, predicate : aPredicate, ascend: false)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] Proj.find_All_Clips => \(res_b)")
            aaa
            
            // return
            return true
            
    }
    

    // 各セルを選択した時に実行される
    func tableView
    (tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] selected => \(indexPath.row)")

            
    }

    
}
