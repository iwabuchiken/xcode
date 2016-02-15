//
//  BMViewController.swift
//  avplayer
//
//  Created by mac on 2016/02/14.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import UIKit
import RealmSwift

class BMViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbl_Title: UILabel!
    
    var song_title : String!
    
    var bmArray : Array<BM> = []
    
    var url : NSURL!

  // MARK: main methods
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
    
  // MARK: UITableViewDataSource プロトコルのメソッド
    // TableView の各セクションのセルの数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return songs.count
        return bmArray.count

    }
    
    // 各セルの内容を返す
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        let text = Methods.conv_Seconds_2_ClockLabel(bmArray[indexPath.row].bm_time)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm_time => \(text)")

        
        // Cellに値を設定する.
        cell.textLabel?.text = Methods.conv_Seconds_2_ClockLabel(bmArray[indexPath.row].bm_time)
//        cell.detailTextLabel?.text = songs[indexPath.row].albumTitle

//        cell.textLabel?.text = songs[indexPath.row].title
//        cell.detailTextLabel?.text = songs[indexPath.row].albumTitle
        
        return cell
    }
    
    // 各セルを選択した時に実行される
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("bm2play_Segue",sender: nil)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // dispatch
        if let vc = segue.destinationViewController as? PlayerViewController {
//            let url = songs[(tableView.indexPathForSelectedRow?.row)!].valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL
//            
//            
//            //debug
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] url?.absoluteString => \(url?.absoluteString)")
//            
//            vc.item_name = songs[(tableView.indexPathForSelectedRow?.row)!].title
            // set title
            vc.item_name = self.song_title
            
            // set: seek time
//            vc.seekTime =
            
//            vc.presentViewController(vc, animated: true, completion: nil)
            
            vc.playMusic(self.url)
            
        }
        
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
