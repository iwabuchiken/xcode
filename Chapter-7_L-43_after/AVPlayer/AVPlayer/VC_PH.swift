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

    var current_ph : PH = PH()

    var current_clip : Clip = Clip()
    
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
        
        cell.detailTextLabel?.textColor = CONS.Colors.col_Gray_050505

        
        //        cell.detailTextLabel?.text = clips[indexPath.row].memos
        
        /*
            validate: clip exists in the MediaItems
        */
        
        let res_b = _tableView__CellForRow__ClipExists_InMediaItems(indexPath.row)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] item  => \(self.phs[indexPath.row].title) (exists in MediaItems => \(res_b)")

        /*
            text colors
        */
        if res_b == false {
        
            cell.textLabel?.textColor = CONS.Colors.col_Gray_050505
            
        } else {
            
            cell.textLabel?.textColor = CONS.Colors.col_Black
            
        }
        
        
        
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

        // return
        if res_b.count < 1 {
            
            return false
            
        }
        
        /*
            exists in MediaItems?

        */
        let media_items : [MPMediaItem] = Methods.get_Songs()
        
//        var aryOf_MediaTitles = Array<String>()
        
        var judge = false   // clip is in mediaitems
        
        for item in media_items {
            
            let title_media_items = item.title!
            
            let tmp = item.valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL

            let audio_id_media_items = (tmp?.absoluteString)!

            // judge
            if title == title_media_items && audio_id == audio_id_media_items {
                
                judge = true
                
                break
                
            }

        }
        
        
        // return
        return judge
        
    }
    

    // 各セルを選択した時に実行される
    func tableView
    (tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] selected => \(indexPath.row)")

        /*
            validate    --> mediaitem exists
        */
        let res_b = self._tableView__CellForRow__ClipExists_InMediaItems(indexPath.row)
        
        if res_b == false {

            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] clip doesn't exist in mediaitems => \(self.phs[indexPath.row].title)")

            // show dialog
            Methods.show_Dialog_OK(self, title: "Notice", message: "clip '\(self.phs[indexPath.row].title)' doesn't exist in mediaitems")
            
            return
            
        }
        
        // setup
        self.current_ph = self.phs[indexPath.row]

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] self.current_ph.description => \(self.current_ph.description)")

        
//        performSegueWithIdentifier("segue_PH_2_BMView",sender: nil)
//        segue_PH_2_BMView
        
    }


    // MARK: segue-related methods
    override func prepareForSegue
    (segue: UIStoryboardSegue, sender: AnyObject?) {
            
            if let vc = segue.destinationViewController as? BMViewController {
                
                _prepSegue__BMView(vc)
                
            }
            
            
    }
    
    func _prepSegue__BMView(vc : BMViewController) {
        
        // get title
//        let title = self.clips[(tableView.indexPathForSelectedRow?.row)!].title
        let title = self.current_ph.title
        
        // set title => for BMView
        vc.song_title = title
        
        // set: nsurl
//        let url = self.clips[(tableView.indexPathForSelectedRow?.row)!].audio_id
        let url = self.current_ph.audio_id
        
        vc.url = NSURL(string: url)
        
//        // MPMediaItem
//        vc.current_clip = self.clips[(tableView.indexPathForSelectedRow?.row)!]
//        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] title => \(title)")
//        
//        /*
//        build: BM list
//        
//        */
//        
//        let query = "title CONTAINS '\(title)'"
//        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] query => \(query)")
//        
//        
//        let aPredicate = NSPredicate(format: query)
//        
//        do {
//            
//            // find -> BMs
//            let bmArray = DB.findAll_BM__Filtered(
//                CONS.s_Realm_FileName,  predicate: aPredicate, sort_key: "created_at", ascend: false)
//            
//            // put value
//            vc.bmArray = bmArray
//            
//            //debug
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray.count => \(bmArray.count)")
//            
//        } catch is NSException {
//            
//            //debug
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] NSException => \(NSException.description())")
//            
//            //ref https://www.bignerdranch.com/blog/error-handling-in-swift-2/
//        } catch let error as NSError {
//            
//            //debug
//            //                print("[\(Methods.basename(__FILE__)):\(__LINE__)] NSError => \(NSException.description())")  //=> build succeeded
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] NSError => \(error.description)")  //=> build succeeded
//            
//        }
//        
    }


}
