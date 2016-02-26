//
//  BMViewController.swift
//  avplayer
//
//  Created by mac on 2016/02/14.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import RealmSwift
import MediaPlayer

class BMViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lbl_CurrentTime: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbl_Title: UILabel!
    
    var song_title : String!
    
    var bmArray : Array<BM> = []
    
    var url : NSURL!
    
    var current_song : MPMediaItem?
    
    var current_time : Int = 0
    
    var start_PlayerView_From_ClickingOn_Label_CurrentTime : Bool = false

  // MARK: main methods
    @IBAction func start_PlayerView(sender: AnyObject) {
        
        let tmp_s = self.lbl_CurrentTime
        
        // start from label --> true
        self.start_PlayerView_From_ClickingOn_Label_CurrentTime = true
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] performing segue...")

        
//        performSegueWithIdentifier("bm2play_Segue",sender: nil)
//        performSegueWithIdentifier("segue_Label_2_PlayerView",sender: nil)
//        performSegueWithIdentifier("segue_CurrentTime_2_PlayerView",sender: nil)
        performSegueWithIdentifier("segue_BM_Label_2_PlayerView",sender: nil)

        
        
    }
    override func viewWillAppear(animated: Bool) {

        // set title to -> label
        lbl_Title.text = self.song_title
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] label set => \(lbl_Title.text)")
        
        // build: BM array
        _build_BMArray()
        
        // regresh -> table view
        self.tableView.reloadData()
        
        // current time
        self.show_CurrentTime()
        
        // add recognizer
        self.addGesture_2_Label_CurrentTime()
        
    }

    override func viewWillDisappear(animated: Bool) {

        super.viewWillDisappear(animated)
        
        // reset => current time
        self.current_time = 0
        
        // reset => current time (CONS.swift)
        CONS.current_time = 0
        
        // reset => start_PlayerView_From_ClickingOn_Label_CurrentTime
        // start from label --> true
        self.start_PlayerView_From_ClickingOn_Label_CurrentTime = true

        
    }

    func show_CurrentTime() {
        
//        let val = Methods.conv_Seconds_2_ClockLabel(self.current_time)
        let val = Methods.conv_Seconds_2_ClockLabel(CONS.current_time)
        
        self.lbl_CurrentTime.text = val
        
    }
    
    func _build_BMArray() {
        
        //    let query = "title == '\(title!)'"
//        let query = "title CONTAINS '\(self.song_title!)'"
        let query = "title == '\(self.song_title!)'"
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] query => \(query)")
        
        
        let aPredicate = NSPredicate(format: query)
        
        do {
            
            let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
            
            //        let dataArray = try realm.objects(BM).filter(aPredicate).sorted("created_at", ascending: false)
            let dataArray = try realm.objects(BM).filter(aPredicate).sorted("bm_time", ascending: true)
            
//            var bmArray = Array<BM>()
            
            self.bmArray.removeAll()
            
            for item in dataArray {
                
                self.bmArray.append(item)
                
            }
            
//            // put value
//            vc.bmArray = bmArray
            
            //        let dataArray = try Realm().objects(BM).filter(aPredicate).sorted("created_at", ascending: false)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray.count => \(dataArray.count)")
            
//            for item in dataArray {
//                
//                //            print("title = \(item.title) --> \(item.bm_time)")
//                print("title = \(item.title) --> \(Methods.conv_Seconds_2_ClockLabel(item.bm_time))")
//                
//            }
            
            
        } catch is NSException {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] NSException => \(NSException.description())")
            
            //ref https://www.bignerdranch.com/blog/error-handling-in-swift-2/
        } catch let error as NSError {
            
            //debug
            //                print("[\(Methods.basename(__FILE__)):\(__LINE__)] NSError => \(NSException.description())")  //=> build succeeded
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] NSError => \(error.description)")  //=> build succeeded
            
        }

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // hide => tab bar
        self.tabBarController?.tabBar.hidden = true
        
        
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
        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm_time => \(text)")

        
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

// MARK: segue-related
    override func prepareForSegue
    (segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] starting prepareForSegue...")

        //test
        let tmp = segue.destinationViewController
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] segue.destinationViewController => \(tmp.description)")
        
        
        // dispatch
//        if let vc = segue.destinationViewController as? PlayerViewController {
        if var vc = segue.destinationViewController as? PlayerViewController {

            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] segue.identifier => \(segue.identifier!)")
            
//            // segue identity
//            let iden = segue.identifier!
            
            // dispatch
//            if iden == CONS.segname_Segue_CurrentTime_2_PlayerView {
            if self.start_PlayerView_From_ClickingOn_Label_CurrentTime == true {
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] calling => self.prepareForSegue__CurrentTime_2_PlayerView()")

                vc = self.prepareForSegue__CurrentTime_2_PlayerView(vc)
                
//                self.prepareForSegue__CurrentTime_2_PlayerView(vc)
//                
//                return
                
                // reset -->
                self.start_PlayerView_From_ClickingOn_Label_CurrentTime == false
                
            } else {
            
//            //debug
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] segue.destinationViewController as? PlayerViewController => true")
            
//            let url = songs[(tableView.indexPathForSelectedRow?.row)!].valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL
//            
//            
//            //debug
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] url?.absoluteString => \(url?.absoluteString)")
//
//            vc.item_name = songs[(tableView.indexPathForSelectedRow?.row)!].title
            
            // get cell text
            //ref http://stackoverflow.com/questions/26158768/how-to-get-textlabel-of-selected-row-in-swift answered Oct 2 '14 at 10:36
            let indexPath = tableView.indexPathForSelectedRow!

            let bm_current = bmArray[indexPath.row]
            
//            // starting segue --> by clicking on the label "current time"
//            if self.start_PlayerView_From_ClickingOn_Label_CurrentTime == true {
////                segue_Label_2_PlayerView
//                //debug
//                print("[\(Methods.basename(__FILE__)):\(__LINE__)] CONS.current_time => \(CONS.current_time)")
//
//                bm_current.bm_time = CONS.current_time
//                
//                //debug
//                print("[\(Methods.basename(__FILE__)):\(__LINE__)] start_PlayerView_From_ClickingOn_Label_CurrentTime => true")
//
//                
//            } else {
//                
//                //debug
//                print("[\(Methods.basename(__FILE__)):\(__LINE__)] start_PlayerView_From_ClickingOn_Label_CurrentTime => false")
//
//            }
            
            
//            let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
            
            //        println(currentCell.textLabel!.text)

            
            
            
            // set title
            vc.item_name = self.song_title
            
            // set: seek time
//            vc.seekTime =
            
//            vc.presentViewController(vc, animated: true, completion: nil)
            
//            vc.seekTime = CMTimeMake(bm_current.bm_time as Int64, 1)  //=> n.w
            vc.seekTime = CMTimeMake(Int64(bm_current.bm_time), 1)
            
//            player?.seekToTime(seekTime)

            // song instance
            vc.current_song = self.current_song
            
            }
            
            vc.playMusic(self.url)
            
//            // reset --> 
//            self.start_PlayerView_From_ClickingOn_Label_CurrentTime == false
            
        }//if let vc = segue.destinationViewController as? PlayerViewController
        
    }
    
    func prepareForSegue__CurrentTime_2_PlayerView
    (vc : PlayerViewController)  -> PlayerViewController {
        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] vc.player.description => \(vc.player!.description)")
            //=>        fatal error: unexpectedly found nil while unwrapping an Optional value
        

        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] prepareForSegue__CurrentTime_2_PlayerView")
//
//        return

        // current time
        let s_current_time = self.lbl_CurrentTime.text!
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] lbl_current_time => \(s_current_time)")

        let bm_time = Methods.conv_ClockLabel_2_Seconds(self.lbl_CurrentTime.text!)

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm_time => \(bm_time)")

//        return
        
        // set title
        vc.item_name = self.song_title
        
        // set: seek time
        //            vc.seekTime =
        
        //            vc.presentViewController(vc, animated: true, completion: nil)
        
        //            vc.seekTime = CMTimeMake(bm_current.bm_time as Int64, 1)  //=> n.w
        vc.seekTime = CMTimeMake(Int64(bm_time), 1)
        
        //            player?.seekToTime(seekTime)
        
        // song instance
        vc.current_song = self.current_song
        
//        vc.playMusic(self.url)
    
        //return
        return vc

    }

    func addGesture_2_Label_CurrentTime() {
        
        //ref http://www.xcode-training-and-tips.com/xcode-and-swift-using-gesture-recognizers/
        
        let redSelector : Selector = "goRed:"
        
        let redGesture = UITapGestureRecognizer(target:self, action:redSelector)
        
        redGesture.numberOfTapsRequired = 1
        
        self.lbl_CurrentTime.addGestureRecognizer(redGesture)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] addGesture_2_Label_CurrentTime => done")
        
    }
    
    @IBAction func goRed(sender: AnyObject){
        
//        myLabel.textColor = UIColor.redColor()
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] goRed")
        
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
