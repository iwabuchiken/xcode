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

    @IBOutlet weak var lbl_EditMode: UILabel!
    @IBOutlet weak var sw_EditMode: UISwitch!

    @IBOutlet weak var lbl_CurrentTime: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbl_Title: UILabel!
    
    var song_title : String!
    
    var bmArray : Array<BM> = []
    
    var url : NSURL!
    
    var current_song : MPMediaItem?

    var current_clip : Clip?
    
    var current_time : Int = 0
    
    var start_PlayerView_From_ClickingOn_Label_CurrentTime : Bool = false

  // MARK: main methods
    @IBAction func change_EditMode(sender: UISwitch) {
        
        // set preference
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // change view
        if self.sw_EditMode.on == true {
            
//            self.sw_EditMode.on = false
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] self.sw_EditMode => true")

            // set defaults
            defaults.setValue(true, forKey: CONS.defaultKeys.key_Pref_BM_EditMemo)
            
            // label color
            self.lbl_EditMode.textColor = CONS.Colors.col_Black
            
        } else {

//            self.sw_EditMode.on = true

            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] self.sw_EditMode => false")

            // set defaults
            defaults.setValue(false, forKey: CONS.defaultKeys.key_Pref_BM_EditMemo)

            // label color
            self.lbl_EditMode.textColor = CONS.Colors.col_White

        }
        
    }
    

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

    @IBAction func forwards(sender: UIButton) {
        
        // current
        let time_label_current = self.lbl_CurrentTime.text!
        
        // new 
        let time_label_new = Proj.timeLabel_Addup(time_label_current, addup: 20)
        
        self.lbl_CurrentTime.text = time_label_new
        
    }

    @IBAction func subtract(sender: UIButton) {
        
        // current
        let time_label_current = self.lbl_CurrentTime.text!
        
        // new
        let time_label_new = Proj.timeLabel_Subtract(time_label_current, subtract:  CONS.value_Per_OneStep_Backwards, min : 0)
        
        self.lbl_CurrentTime.text = time_label_new

    }

    @IBAction func add_BM(sender: UIButton) {
        
        // bm time
        let bm_time = Methods.conv_ClockLabel_2_Seconds(self.lbl_CurrentTime.text!)
        
        
        // audio url
//        let url = self.current_song!.valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL
//        let url = NSURL(fileReferenceLiteral: (self.current_clip?.audio_id)!)
        let url = NSURL(string : (self.current_clip?.audio_id)!)

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] nsurl => set")
        

        
        Proj.add_BM(self.song_title, bm_time: bm_time, audio_url: url!)
//        Proj.add_BM(self.song_title, bm_time: bm_time, audio_url: url)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] add bm => done")

        // rebuild BM array
        self._build_BMArray()
        
        // reload table view data
        self.tableView.reloadData()
        
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
        
        // switches
        viewWillAppear__Setup_Switches()
        
        // views
        _viewWillAppear__Setup_Views()
        
    }

    func _viewWillAppear__Setup_Views() {
    
        // "Edit mode" label
        if self.sw_EditMode.on == true {
            
            self.lbl_EditMode.textColor = CONS.Colors.col_Black
            
        } else {
            
            self.lbl_EditMode.textColor = CONS.Colors.col_White
            
        }
        
    }
    
    func viewWillAppear__Setup_Switches() {
        
        /*
            edit bm memos
        */
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // get defaults value
        
        //        var dfltVal_DebugMode = defaults.valueForKey(CONS.defaultKeys.key_Set_DebugMode)
        let dfltVal_Pref_BM_EditMemo = defaults.valueForKey(CONS.defaultKeys.key_Pref_BM_EditMemo)

        // validate
        if dfltVal_Pref_BM_EditMemo == nil {
            
            self.sw_EditMode.on = false

            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_Pref_BM_EditMemo => nil¥nself.sw_EditMode.on => false")

        } else {
            
            self.sw_EditMode.on = (dfltVal_Pref_BM_EditMemo?.boolValue)!

            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] self.sw_EditMode.on => \((dfltVal_Pref_BM_EditMemo?.boolValue)!)")
            
        }
        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_Pref_BM_EditMemo?.description => \(dfltVal_Pref_BM_EditMemo?.description)")

    }
    
    override func viewWillDisappear(animated: Bool) {

        super.viewWillDisappear(animated)
        
        // reset => current time
        self.current_time = 0
        
        // reset => current time (CONS.swift)
        CONS.current_time = 0
        
        // reset => start_PlayerView_From_ClickingOn_Label_CurrentTime
//        // start from label --> true
//        self.start_PlayerView_From_ClickingOn_Label_CurrentTime = true

        
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
            
//            let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
            CONS.RealmVars.realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
            
            //        let dataArray = try realm.objects(BM).filter(aPredicate).sorted("created_at", ascending: false)
//            let dataArray = try realm.objects(BM).filter(aPredicate).sorted("bm_time", ascending: true)
            let dataArray = try CONS.RealmVars.realm!.objects(BM).filter(aPredicate).sorted("bm_time", ascending: true)
            
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
//        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
//        
        let text = Methods.conv_Seconds_2_ClockLabel(bmArray[indexPath.row].bm_time)
        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] bm_time => \(text)")

        
        // Cellに値を設定する.
//        cell.textLabel?.text = Methods.conv_Seconds_2_ClockLabel(bmArray[indexPath.row].bm_time)
        cell.textLabel?.text = text
        
//        cell.detailTextLabel?.text = bmArray[indexPath.row].created_at
        cell.detailTextLabel?.text = bmArray[indexPath.row].memo
        
        let colorSelected = UIColor(red: 3/255, green: 134/255, blue: 27/255, alpha: 1)
        
//        cell.detailTextLabel?.backgroundColor = CONS.col_green_soft
        cell.detailTextLabel?.backgroundColor = colorSelected
        
//        cell.detailTextLabel?.text = songs[indexPath.row].albumTitle

//        cell.textLabel?.text = songs[indexPath.row].title
//        cell.detailTextLabel?.text = songs[indexPath.row].albumTitle
        
        return cell
    }
    
    // 各セルを選択した時に実行される
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
//        segue_BM_2_EditBM
        
        /*
            dispatch
        */
        if self.sw_EditMode.on == true {

            // set vars
            let bm_current = bmArray[indexPath.row]
            
            CONS.e_VC_EditBM.s_clip_title = self.song_title
            
            CONS.e_VC_EditBM.bm_time = bm_current.bm_time
            
            CONS.e_VC_EditBM.bm = bm_current
            
            // perform segue
            performSegueWithIdentifier("segue_BM_2_EditBM",sender: nil)
            
            // deselect row
            tableView.deselectRowAtIndexPath(indexPath, animated: true)

        } else {

            performSegueWithIdentifier("bm2play_Segue",sender: nil)
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)

        }
        
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
            
            // dispatch
            if self.start_PlayerView_From_ClickingOn_Label_CurrentTime == true {
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] calling => self.prepareForSegue__CurrentTime_2_PlayerView()")

                vc = self.prepareForSegue__CurrentTime_2_PlayerView(vc)
                
                // reset -->
                self.start_PlayerView_From_ClickingOn_Label_CurrentTime = false

            } else {
            
                // get cell text
                //ref http://stackoverflow.com/questions/26158768/how-to-get-textlabel-of-selected-row-in-swift answered Oct 2 '14 at 10:36
                let indexPath = tableView.indexPathForSelectedRow!

                let bm_current = bmArray[indexPath.row]
                    
                // set title
                vc.item_name = self.song_title

                vc.seekTime = CMTimeMake(Int64(bm_current.bm_time), 1)
                
                // song instance
                vc.current_song = self.current_song
                
                // clip
                vc.current_clip = self.current_clip
                
            }
            
            vc.playMusic(self.url)
            
        }//if let vc = segue.destinationViewController as? PlayerViewController
        
    }
    
    func prepareForSegue__CurrentTime_2_PlayerView
    (vc : PlayerViewController)  -> PlayerViewController {
        
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
        
        vc.seekTime = CMTimeMake(Int64(bm_time), 1)
        
        //            player?.seekToTime(seekTime)
        
        // song instance
        vc.current_song = self.current_song
        
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
