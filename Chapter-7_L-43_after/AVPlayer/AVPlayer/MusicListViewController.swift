//
//  MusicListViewController.swift
//  AVPlayer
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit
import MediaPlayer
import RealmSwift
import MessageUI

class MusicListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate  {
  
    @IBAction func startVC_PH(sender: UIBarButtonItem) {

        performSegueWithIdentifier("segue_MusicList_2_PH",sender: nil)
        
    }
    
    @IBOutlet var tableView: UITableView!

//    var dataArray = try! Realm().objects(BM).sorted("created_at", ascending: false)
//    var dataArray = try! Realm().objects(BM_2).sorted("created_at", ascending: false)
    
  // MARK: funcs for experiments
    @IBAction func experiments(sender: UIBarButtonItem) {

        // dialog
        self._experiments__Choices()
        
        // experiments
//        Methods.experiments()
        
////        _experiments__SaveClips()
//        Methods.saveClips(self.songs)
//        
//        // backup realm files
//        Methods.realm_BackupFiles(CONS.s_Realm_FileName)
//        
//        // send emails
//        _experiments__SendEmails()

//        // file i/o
//        _experiments__FileIO()
        
//        let resOf_BMs = DB.findAll_BM(CONS.s_Realm_FileName, sort_key: "id", ascend: false)
//        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_BMs.count => \(resOf_BMs.count)")
        
        
//        /*
//            remove realm files
//        */
//        _experiments__RemoveRealmFiles("db_20160219_164456.realm")
        
//        let manager = NSFileManager.defaultManager()
//        
////        let realmPath = Realm.Configuration.defaultConfiguration.path as! NSString
//        
//        let realmPath2 = Realm.Configuration.defaultConfiguration.path
//        
//        let dpath_realm = Methods.dirname(realmPath2!)
//        
////        let fname_realm = Methods.basename(realmPath2!)
//        let fname_realm = "db_20160219_173550.realm"
//        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dpath_realm => \(dpath_realm) *** fname_realm => \(fname_realm)")
//        
////        let realmPath = String("dpath_realm" + "/" + fname_realm)
////        let realmPath = NSString.init("\(dpath_realm)/\(fname_realm)")
//        
////        let tmp = NSString()
////        
////        tmp.
//        
////        let realmPath = tmp.stringByAppendingString("\(dpath_realm)/\(fname_realm)")
//        let realmPath = "\(dpath_realm)/\(fname_realm)"
//        
//        let realmPaths = [
//            realmPath as String,
//            "\(realmPath).lock",
//            "\(realmPath).log_a",
//            "\(realmPath).log_b",
//            "\(realmPath).note"
////            realmPath.stringByAppendingPathExtension("lock")!,
////            realmPath.stringByAppendingPathExtension("log_a")!,
////            realmPath.stringByAppendingPathExtension("log_b")!,
////            realmPath.stringByAppendingPathExtension("note")!
//        ]
//        for path in realmPaths {
//            
//	        //debug
//	        print("[\(Methods.basename(__FILE__)):\(__LINE__)] path => \(path)")
//            
//            do {
//                try manager.removeItemAtPath(path)
//                
//                //debug
//                print("[\(Methods.basename(__FILE__)):\(__LINE__)] path removed => \(path)")
//                
//            } catch {
//                // handle error
//                //debug
//                print("[\(Methods.basename(__FILE__)):\(__LINE__)] remove path => error (\(path))")
//
//            }
//        }
        
//        //test
//        Methods.show_DirList__RealmFiles()
        
//        // D-3.s-1.#1/steps.1-3
//        DB.copy_BMs(CONS.s_Realm_FileName, dbname_new : CONS.s_Realm_FileName__New)
        
        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] experiments... (realm file = \(CONS.s_Realm_FileName))")
//
//        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
//
//        let dataArray = try! realm.objects(BM).sorted("created_at", ascending: false)
//
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray => \(dataArray.count)")
//        
//        // clips
//        let resOf_Clips = try! realm.objects(Clip).sorted("created_at", ascending: false)
//
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_Clips => \(resOf_Clips.count)")

        
    }
    
    func _experiments__Choices() {
        
        //        let s_title = "Choices"
        let s_title = "Experiments"
        
        //        let choice_0 = "(0) Cancel"
        
        let choice_1 = "(1) Save clips"
        let choice_2 = "(2) Backup realm files"
        let choice_3 = "(3) Show realm files"

        let choice_4 = "(4) Show backup files"
        let choice_5 = "(5) Show the number of PHs"
        let choice_6 = "(6) Refresh clips table"
        
        
        let s_message = "\(choice_1)\n\(choice_2)\n\(choice_3)\n\(choice_4)\n\(choice_5)\n\(choice_6)"
        
        let refreshAlert = UIAlertController(title: s_title, message: s_message, preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] chosen => cancel")
            
            // execute  => close dialog
            
            
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: "1", style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] chosen => 1")
            
            // start function
            self._experiments__Choices__1()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "2", style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] chosen => 2")
            
            // start function
            self._experiments__Choices__2()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "3", style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] chosen => 3")
            
            // start function
            self._experiments__Choices__3()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "4", style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] chosen => 4")
            
            // start function
            self._experiments__Choices__4()
            
        }))

        refreshAlert.addAction(UIAlertAction(title: "5", style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] chosen => 5")
            
            // start function
            self._experiments__Choices__5()
            
        }))

        refreshAlert.addAction(UIAlertAction(title: "6", style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] chosen => 6")
            
            // start function
            self._experiments__Choices__6()
            
        }))
        
        // show view
        presentViewController(refreshAlert, animated: true, completion: nil)
        
    }
    
    func _experiments__Choices__1() {
        
        // show list
//        Methods.saveClips(self.songs)
        Proj.save_Clips__MediaItems(self.songs)
        
    }
    
    func _experiments__Choices__2() {

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] _experiments__Choices__2")
        
        // backup
        Methods.backup_RealmFiles(CONS.RealmVars.s_Realm_FileName__Admin)

        
    }

    func _experiments__Choices__3() {
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] _experiments__Choices__3")
        
        // show list
//        Methods.show_DirList__BackupFiles()
        Methods.show_DirList__RealmFiles()
        
        
    }

    func _experiments__Choices__4() {
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] _experiments__Choices__4")
        
        // show list
        //        Methods.show_DirList__BackupFiles()
        Methods.show_DirList__BackupFiles()
        
        
    }

    func _experiments__Choices__5() {
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] _experiments__Choices__5")
        
        // show history
        let aryOf_phs = Proj.find_All_PHs()
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] aryOf_phs.count => \(aryOf_phs.count)")
        
    }

    func _experiments__Choices__6() {
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] _experiments__Choices__6")
        
        // show history
        let res : [Int] = Proj.refresh_Clips_Table()
        
        // update --> tableview
        self.getClips()
        
        self.tableView.reloadData()
        
        /*
            report
        */
        //        let s_title = "Choices"
        let s_title = "Experiments"
        
        //        let choice_0 = "(0) Cancel"
        
        let choice_1 = "clips in db => \(res[0])\naryOf_MediaItems.count =>  \(res[1])\n'removed_at' => \(res[2])\nelse => \(res[3])"

        let s_message = "\(choice_1)"
        
        let refreshAlert = UIAlertController(title: s_title, message: s_message, preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] chosen => OK")
            
            // execute  => close dialog
            
            
        }))
        
        // show view
        presentViewController(refreshAlert, animated: true, completion: nil)

//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] clips in db => \(aryOf_Clips.count) / aryOf_MediaItems.count =>  \(aryOf_MediaItems.count) / 'removed_at' => \(count_removed) / else => \(count)")

        
    }
    
    func _experiments__FileIO() {
        
        //ref http://www.learncoredata.com/how-to-save-files-to-disk/
        let realmPath = Realm.Configuration.defaultConfiguration.path
        
        let dpath_realm = Methods.dirname(realmPath!)

        let fpath_full = "\(dpath_realm)/realm_data_\(Methods.get_TimeLabel__Serial()).csv"
        
        do {

            try "yes".writeToFile(fpath_full, atomically: true, encoding: NSUTF8StringEncoding)

            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] file written => \(fpath_full)")

            // report
            Methods.show_DirList__RealmFiles()
            
        } catch {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] error occurred")

            
        }
        
    }
    
    /*
        _experiments__SendEmails
    
        <dependencies>
        configuredMailComposeViewController
        showSendMailErrorAlert
        mailComposeController
    
    */
    func _experiments__SendEmails() {
        
        let mailComposeViewController = configuredMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail() {
            
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            
        } else {
            
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["someone@somewhere.com"])
//        mailComposerVC.setSubject("Sending you an in-app e-mail...")

        mailComposerVC.setSubject("myself] xcode_Player \(Methods.get_TimeLable())")
        
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        
        // attach file
//        if let filePath = NSBundle.mainBundle().pathForResource("swifts", ofType: "wav") {
        let realmPath = Realm.Configuration.defaultConfiguration.path
        
        let dpath_realm = Methods.dirname(realmPath!)
        
//        let fpath_realm = "\(dpath_realm)/\(CONS.s_Realm_FileName)"
        let fpath_realm = "\(dpath_realm)/realm_data_20160220_155221.csv"

//        if let filePath = NSBundle.mainBundle().pathForResource("swifts", ofType: "wav") {
//        if let filePath = NSBundle.mainBundle().pathForResource(fpath_realm, ofType: "realm") {
        if let filePath = NSBundle.mainBundle().pathForResource("db_20160220_002443", ofType: "realm") {
        
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] path to attached file => \(filePath)")

//            print("File path loaded.")
        
        } else {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] can't generate path => \(fpath_realm)")

    
        }
        
        // load data
//        if let fileData = NSData(contentsOfFile: filePath) {
        if let fileData = NSData(contentsOfFile: fpath_realm) {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] data created")
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] data created => \(fileData.description)")
//            println("File data loaded.")

            // attach data
            //ref http://kellyegan.net/sending-files-using-swift/
            mailComposerVC.addAttachmentData(fileData, mimeType: "application/octet-stream", fileName: "swifts")

        } else {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] data created => NOT")

        }
    
        
//        mailComposerVC.a
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
//        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
//        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func _experiments__SaveClips() {
        
        var count = 0
        
        for item in self.songs {
            
	        //debug
	        print("[\(Methods.basename(__FILE__)):\(__LINE__)] item.title => \(item.title)")
            
            let clip = Clip()
            
            clip.id = Methods.lastId_Clip()
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] clip.id => \(clip.id)")
            
            clip.title = item.title!
            
            let url = item.valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL
            
            let str = url?.absoluteString
            
            clip.audio_id = str!
            
            // created_at, modified_at
            let tmp = Methods.conv_NSDate_2_DateString(NSDate())
            
            clip.created_at = tmp
            clip.modified_at = tmp
            
            // length
            //debug
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] item.valueForProperty(MPMediaItemPropertyPlaybackDuration) => \(item.valueForProperty(MPMediaItemPropertyPlaybackDuration))")
//            //=> Optional(641.227)
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] item.valueForProperty(MPMediaItemPropertyPlaybackDuration) => \(item.valueForProperty(MPMediaItemPropertyPlaybackDuration)!)")
            //=>
            
            clip.length = Int(item.valueForProperty(MPMediaItemPropertyPlaybackDuration)! as! NSNumber)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] clip.description => \(clip.description)")
            
            // is in db
            let res_b = DB.isInDb__Clip_Title(CONS.s_Realm_FileName, title: clip.title)
            
            if res_b == true {
                
                // save clip info
                
                
                count += 1
                
            }
            
        }
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] not in db => \(count) / total = \(self.songs.count)")
        
        
    }
    
    func _experiments__RemoveRealmFiles(fname : String) {
        
        let manager = NSFileManager.defaultManager()
        
        //        let realmPath = Realm.Configuration.defaultConfiguration.path as! NSString
        
        let realmPath2 = Realm.Configuration.defaultConfiguration.path
        
        let dpath_realm = Methods.dirname(realmPath2!)
        
        //        let fname_realm = Methods.basename(realmPath2!)
//        let fname_realm = "db_20160219_173550.realm"
        let fname_realm = fname
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dpath_realm => \(dpath_realm) *** fname_realm => \(fname_realm)")
        
        //        let realmPath = String("dpath_realm" + "/" + fname_realm)
        //        let realmPath = NSString.init("\(dpath_realm)/\(fname_realm)")
        
        //        let tmp = NSString()
        //
        //        tmp.
        
        //        let realmPath = tmp.stringByAppendingString("\(dpath_realm)/\(fname_realm)")
        let realmPath = "\(dpath_realm)/\(fname_realm)"
        
        let realmPaths = [
            realmPath as String,
            "\(realmPath).lock",
            "\(realmPath).log_a",
            "\(realmPath).log_b",
            "\(realmPath).note"
            //            realmPath.stringByAppendingPathExtension("lock")!,
            //            realmPath.stringByAppendingPathExtension("log_a")!,
            //            realmPath.stringByAppendingPathExtension("log_b")!,
            //            realmPath.stringByAppendingPathExtension("note")!
        ]
        for path in realmPaths {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] path => \(path)")
            
            do {
                try manager.removeItemAtPath(path)
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] path removed => \(path)")
                
            } catch {
                // handle error
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] remove path => error (\(path))")
                
            }
        }

        /*
            show dir list
        */
        Methods.show_DirList__RealmFiles()
        
    }
    
  // 曲情報
  var songs = Array<MPMediaItem>()
  
    var clips = Array<Clip>()
    
  // MARK: view-related funcs
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(animated: Bool) {

//        // test: migration
//        _test_Migration()
        
//        // test: realm
//        test_Realm()
        
//        //test: subarray
//        test_Subarrays()

        
    }
    
  override func viewDidLoad() {
    
        super.viewDidLoad()
    
        // setup --> music infos
        songs = getSongs()
    
        self.clips = self.getClips()
    
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] self.songs.count => \(self.songs.count) / self.clips.count => \(self.clips.count)")

    
        // refresh data
        tableView.reloadData()
    
////    // save songs data
//        Methods.save_SongsData(songs)

    
    //test
    //ref http://stackoverflow.com/questions/32290126/swift-add-gesture-recognizer-to-object-in-table-cell answered Aug 29 '15 at 21:00
//    var recognizer = UISwipeGestureRecognizer(target: self, action: "didSwipe")
//    self.tableView.addGestureRecognizer(recognizer)
    
        let recognizer = UIGestureRecognizer(target: self, action: "didSwipe")

        self.tableView.addGestureRecognizer(recognizer)
    
  }
  
////    func save_SongsData( data : Array<MPMediaItem> ) --> Void {
//    func save_SongsData( data : [MPMediaItem] ) -> Void {
//    
//        let s1 = data[0]
//        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] s1.title => \(s1.title)")
//        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] s1.lastPlayedDate => \(Methods.conv_NSDate_2_DateString(s1.lastPlayedDate!))")
//        
//        
//        
//    
//    
//    }
    
    
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

// MARK: ui-related
    @IBAction func handle_LongPress(sender: UILongPressGestureRecognizer) {
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] long pressed (\(Methods.get_TimeLable()))")
        
        //        //debug
        //        print("[\(Methods.basename(__FILE__)):\(__LINE__)] title => (\(Methods.get_TimeLable()))" + songs[(tableView.indexPathForSelectedRow?.row)!].title!)
        
        
        //ref http://stackoverflow.com/questions/30839275/how-to-select-a-table-row-during-a-long-press-in-swift answered Jun 15 '15 at 7:33
        let touchPoint = sender.locationInView(self.view)
        
        let indexPath = tableView.indexPathForRowAtPoint(touchPoint)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] indexPath?.item => \(indexPath?.item)" ) //=> works
        
        //        // get item at the index
        //        let currentCell = tableView.cellForRowAtIndexPath(indexPath!)! as UITableViewCell
        //
        //                print("[\(Methods.basename(__FILE__)):\(__LINE__)] currentCell => created" ) //=> english title --> "fatal error: unexpectedly found nil while unwrapping an Optional value"
        
        
        //        //debug
        ////        print("[\(Methods.basename(__FILE__)):\(__LINE__)] currentCell.textLabel!.text => \(currentCell.textLabel!.text)" ) //=> works
        //        print("[\(Methods.basename(__FILE__)):\(__LINE__)] currentCell.textLabel!.text => \(currentCell.textLabel?.text)" ) //=> works
        //
        //        //test
        //        print("[\(Methods.basename(__FILE__)):\(__LINE__)] tableView.indexPathForSelectedRow?.row => \(tableView.indexPathForSelectedRow?.row)" ) //=>
        //
        //        //test
        //        print("[\(Methods.basename(__FILE__)):\(__LINE__)] songs.count => \(songs.count)" ) //=>
        //        
        
    }
    
    func didSwipe(recognizer: UIGestureRecognizer) {
        
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] swiped!")
        
        //        if recognizer.state == UIGestureRecognizerState.Ended {
        //            let swipeLocation = recognizer.locationInView(self.tableView)
        //            if let swipedIndexPath = tableView.indexPathForRowAtPoint(swipeLocation) {
        //                if let swipedCell = self.tableView.cellForRowAtIndexPath(swipedIndexPath) {
        //                    // Swipe happened. Do stuff!
        //                    //debug
        //        print("[\(Methods.basename(__FILE__)):\(__LINE__)] swiped! => \(swipedCell.description)")
        //
        //                }
        //            }
        //        }
    }

  
  // MARK: UITableViewDataSource プロトコルのメソッド
  // TableView の各セクションのセルの数を返す
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
//    return songs.count
    return self.clips.count
    
  }
  
  // 各セルの内容を返す
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // 再利用可能な cell を得る
//    let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
    let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
    
    // Cellに値を設定する.
//    cell.textLabel?.text = songs[indexPath.row].title
//    cell.detailTextLabel?.text = songs[indexPath.row].albumTitle
    cell.textLabel?.text = clips[indexPath.row].title
    cell.detailTextLabel?.text = clips[indexPath.row].memos
    
    return cell
    
  }
  
  // 各セルを選択した時に実行される
    func tableView
    (tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    /*
        if no BMs --> goto PlayerView, directly

    */
        // get title
//        let title = songs[(tableView.indexPathForSelectedRow?.row)!].title
        let title = self.clips[(indexPath.row)].title

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] title => \(title)")

//        let query = "title CONTAINS '\(title!)'"
        let query = "title == '\(title)'"
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] query => \(query)")
        
        
        let aPredicate = NSPredicate(format: query)

        let bmArray = DB.findAll_BM__Filtered(
            CONS.s_Realm_FileName,  predicate: aPredicate, sort_key: "created_at", ascend: false)

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] bmArray.count => \(bmArray.count)")

        // if no BMs --> goto 'cellSegue'
        if bmArray.count < 1 {

            // set current time --> 0
            CONS.current_time = 0

            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] CONS.current_time => set to 0")

//            //debug
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] no BMs => start cellSegue")
//            
//            performSegueWithIdentifier("cellSegue",sender: nil)
//            
//            return
            
        }
    
        /*
            debug mode: if on --> count BMs

        */
       let dfltVal_DebugMode = Methods.getDefaults_Boolean(CONS.defaultKeys.key_Set_DebugMode)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_DebugMode?.description => \(dfltVal_DebugMode.description)")
        
        
//    if b_flag {
    // ref boolValue http://stackoverflow.com/questions/28107051/convert-string-to-bool-in-swift-via-api-or-most-swift-like-approach answered Jan 23 '15 at 10:10
//    if dfltVal_DebugMode?.boolValue == true {
        if dfltVal_DebugMode == true {

            performSegueWithIdentifier("bmSegue",sender: nil)
        
        } else {
            
            performSegueWithIdentifier("cellSegue",sender: nil)
            
        }
    
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
  }

    func tableView__songs
    (tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        /*
        if no BMs --> goto PlayerView, directly
        
        */
        // get title
        //        let title = songs[(tableView.indexPathForSelectedRow?.row)!].title
        let title = songs[(indexPath.row)].title
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] title => \(title)")
        
        //        let query = "title CONTAINS '\(title!)'"
        let query = "title == '\(title!)'"
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] query => \(query)")
        
        
        let aPredicate = NSPredicate(format: query)
        
        let bmArray = DB.findAll_BM__Filtered(
            CONS.s_Realm_FileName,  predicate: aPredicate, sort_key: "created_at", ascend: false)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] bmArray.count => \(bmArray.count)")
        
        // if no BMs --> goto 'cellSegue'
        if bmArray.count < 1 {
            
            // set current time --> 0
            CONS.current_time = 0
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] CONS.current_time => set to 0")
            
            //            //debug
            //            print("[\(Methods.basename(__FILE__)):\(__LINE__)] no BMs => start cellSegue")
            //
            //            performSegueWithIdentifier("cellSegue",sender: nil)
            //
            //            return
            
        }
        
        /*
        debug mode: if on --> count BMs
        
        */
        
        //    let defaults = NSUserDefaults.standardUserDefaults()
        //
        //    //        var dfltVal_DebugMode = defaults.valueForKey(CONS.defaultKeys.key_Set_DebugMode)
        //    let dfltVal_DebugMode = defaults.valueForKey(CONS.defaultKeys.key_Set_DebugMode)
        //
        //        //debug
        //        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_DebugMode?.description => \(dfltVal_DebugMode?.description)")
        //        var dfltVal_DebugMode = defaults.valueForKey(CONS.defaultKeys.key_Set_DebugMode)
        let dfltVal_DebugMode = Methods.getDefaults_Boolean(CONS.defaultKeys.key_Set_DebugMode)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dfltVal_DebugMode?.description => \(dfltVal_DebugMode.description)")
        
        
        //    if b_flag {
        // ref boolValue http://stackoverflow.com/questions/28107051/convert-string-to-bool-in-swift-via-api-or-most-swift-like-approach answered Jan 23 '15 at 10:10
        //    if dfltVal_DebugMode?.boolValue == true {
        if dfltVal_DebugMode == true {
            
            //    if false {
            //    if PreferenceViewController().sw_DebugMode.on {
            
            performSegueWithIdentifier("bmSegue",sender: nil)
            
        } else {
            
            performSegueWithIdentifier("cellSegue",sender: nil)
            
        }
        //    performSegueWithIdentifier("cellSegue",sender: nil)
        
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
}

  // MARK: segue-related methods
  // PlayerViewController にURLを渡して再生を開始させる
    override func prepareForSegue
    (segue: UIStoryboardSegue, sender: AnyObject?) {
    
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] destinationViewController => (\(segue.destinationViewController.description))")

        if let playerViewController = segue.destinationViewController as? PlayerViewController {
            
//            let url = songs[(tableView.indexPathForSelectedRow?.row)!].valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL
            let url = self.clips[(tableView.indexPathForSelectedRow?.row)!].audio_id
            
//            //debug
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] url?.absoluteString => \(url?.absoluteString)")
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] url => \(url)")
          
            playerViewController.item_name = self.clips[(tableView.indexPathForSelectedRow?.row)!].title
            
            // set song
//            playerViewController.current_song = songs[(tableView.indexPathForSelectedRow?.row)!]
            playerViewController.current_clip = self.clips[(tableView.indexPathForSelectedRow?.row)!]
            
          playerViewController.playMusic(NSURL(fileReferenceLiteral: url))

        } else if let viewController = segue.destinationViewController as? BMViewController {

            _prepSegue__BMView(viewController)
            
        //        let title = songs[(tableView.indexPathForSelectedRow?.row)!].title
        //
        //        //debug
        //        print("[\(Methods.basename(__FILE__)):\(__LINE__)] title => \(title)")

        } else if let viewController = segue.destinationViewController as? VC_PH {

            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] segueing to => VC_PH")

            
        }
    
    
    }

//    override func prepareForSegue__songs
    func prepareForSegue__songs
    
        (segue: UIStoryboardSegue, sender: AnyObject?) {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] destinationViewController => (\(segue.destinationViewController.description))")
            
            if let playerViewController = segue.destinationViewController as? PlayerViewController {
                let url = songs[(tableView.indexPathForSelectedRow?.row)!].valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL
                
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] url?.absoluteString => \(url?.absoluteString)")
                
                playerViewController.item_name = songs[(tableView.indexPathForSelectedRow?.row)!].title
                
                // set song
                playerViewController.current_song = songs[(tableView.indexPathForSelectedRow?.row)!]
                
                playerViewController.playMusic(url!)
                
            } else if let viewController = segue.destinationViewController as? BMViewController {
                
                _prepSegue__BMView(viewController)
                
                //        let title = songs[(tableView.indexPathForSelectedRow?.row)!].title
                //
                //        //debug
                //        print("[\(Methods.basename(__FILE__)):\(__LINE__)] title => \(title)")
                
                
            }
            
            
    }

    func _prepSegue__BMView(vc : BMViewController) {
    
        // get title
        let title = self.clips[(tableView.indexPathForSelectedRow?.row)!].title
        
        // set title => for BMView
        vc.song_title = title
        
        // set: nsurl
        let url = self.clips[(tableView.indexPathForSelectedRow?.row)!].audio_id

        vc.url = NSURL(string: url)
        
        // MPMediaItem
        vc.current_clip = self.clips[(tableView.indexPathForSelectedRow?.row)!]
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] title => \(title)")
    
        /*
            build: BM list

        */

        let query = "title CONTAINS '\(title)'"

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] query => \(query)")


        let aPredicate = NSPredicate(format: query)
    
        do {
         
            // find -> BMs
            let bmArray = DB.findAll_BM__Filtered(
                CONS.s_Realm_FileName,  predicate: aPredicate, sort_key: "created_at", ascend: false)

            // put value
            vc.bmArray = bmArray
        
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray.count => \(bmArray.count)")

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
    
    func _prepSegue__BMView__songs(vc : BMViewController) {
        
        //    //test
        //    _test_RealmRecords__BM()
        
        // get title
        let title = songs[(tableView.indexPathForSelectedRow?.row)!].title
        
        // set title => for BMView
        vc.song_title = title
        
        // set: nsurl
        let url = songs[(tableView.indexPathForSelectedRow?.row)!].valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL
        
        vc.url = url!
        
        // MPMediaItem
        vc.current_song = songs[(tableView.indexPathForSelectedRow?.row)!]
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] title => \(title)")
        
        /*
        build: BM list
        
        */
        
        //    //debug
        //    print("[\(Methods.basename(__FILE__)):\(__LINE__)] title => \(title) / title! => \(title!)")  //=> title => Optional("「マイナンバー制度」人民支配へ不可欠な法整備 vol.1") / title! => 「マイナンバー制度」人民支配へ不可欠な法整備 vol.1
        
        
        //    let query = "title == '\(title!)'"
        let query = "title CONTAINS '\(title!)'"
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] query => \(query)")
        
        
        let aPredicate = NSPredicate(format: query)
        
        //    let aPredicate = NSPredicate(format: "title == %@", title!)
        
        //    let dataArray = try Realm().objects(BM).filter(aPredicate).sorted("created_at", ascending: false)
        do {
            
            //        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
            //
            ////        let dataArray = try realm.objects(BM).filter(aPredicate).sorted("created_at", ascending: false)
            //        let dataArray = try realm.objects(BM).filter(aPredicate).sorted("bm_time", ascending: true)
            //
            ////        //debug
            ////        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray.description => \(dataArray.description)")
            //
            //        var bmArray = Array<BM>()
            //
            //        for item in dataArray {
            //
            //            bmArray.append(item)
            //
            //        }
            
            // find -> BMs
            //        var bmArray = DB.findAll_BM(CONS.s_Realm_FileName, sort_key: "created_at", ascend: false)
            let bmArray = DB.findAll_BM__Filtered(
                CONS.s_Realm_FileName,  predicate: aPredicate, sort_key: "created_at", ascend: false)
            
            // put value
            vc.bmArray = bmArray
            
            //        let dataArray = try Realm().objects(BM).filter(aPredicate).sorted("created_at", ascending: false)
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray.count => \(bmArray.count)")
            
            //        for item in bmArray {
            //
            //            //            print("title = \(item.title) --> \(item.bm_time)")
            //            print("title = \(item.title) --> \(Methods.conv_Seconds_2_ClockLabel(item.bm_time))")
            //
            //        }
            
            //        //debug
            //        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray.count => \(dataArray.count)")
            //
            //        for item in dataArray {
            //
            ////            print("title = \(item.title) --> \(item.bm_time)")
            //            print("title = \(item.title) --> \(Methods.conv_Seconds_2_ClockLabel(item.bm_time))")
            //
            //        }
            
            
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
    
    func _test_RealmRecords__BM() {

        do {
            
            let dataArray = try Realm().objects(BM).sorted("created_at", ascending: false)
            
            for item in dataArray {
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] item.title => \(item.title)")  //=>
                
                
            }
            
        } catch is NSException {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] NSException => \(NSException.description())")
            
            //ref https://www.bignerdranch.com/blog/error-handling-in-swift-2/
        } catch let error as NSError {
            
            //debug
            //                print("[\(Methods.basename(__FILE__)):\(__LINE__)] NSError => \(NSException.description())")  //=> build succeeded
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] NSError => \(error.description)")  //=> build succeeded
            
        } catch {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] unknown error)")  //=> build succeeded

            
        }


    }

// MARK: others
    // iPhone 内から曲情報を取得する
    func getSongs() -> Array<MPMediaItem> {
        
        var array = Array<MPMediaItem>()
        
        // アルバム情報を取得する
        //    let albumsQuery: MPMediaQuery = MPMediaQuery.albumsQuery()
//        let albumsQuery: MPMediaQuery = MPMediaQuery.songsQuery()
        let albumsQuery: MPMediaQuery = MPMediaQuery.songsQuery()
        
        //ref https://stackoverflow.duapp.com/questions/32696647/swift-sort-artistsquery-by-album answered Feb 20 at 22:12
        albumsQuery.groupingType = MPMediaGrouping.Title
        
        let albumItems: [MPMediaItemCollection] = albumsQuery.collections!
        
        //ref https://stackoverflow.duapp.com/questions/32696647/swift-sort-artistsquery-by-album answered Oct 14 '15 at 15:18
//        var artistsItemsSortedByAlbum = NSMutableArray()
//        
////        for var i = 0; i < artists.count; i++ {
//        for var i = 0; i < albumItems.count; i++ {
//        
////            let collection:MPMediaItemCollection = artists[i] as! MPMediaItemCollection
//            let collection:MPMediaItemCollection = albumItems[i]
//            
//            let rowItem = collection.representativeItem!
//            
//            let albumsQuery = MPMediaQuery.albumsQuery()
//            
//            let albumPredicate:MPMediaPropertyPredicate = MPMediaPropertyPredicate(value: rowItem.valueForProperty((MPMediaItemPropertyAlbumArtist)), forProperty: MPMediaItemPropertyAlbumArtist)
//            
//            albumsQuery.addFilterPredicate(albumPredicate)
//            
//            let artistAlbums = albumsQuery.collections
//            
//            artistsItemsSortedByAlbum.addObject(artistAlbums!)
//            
//        }
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] albumItems.count => \(albumItems.count)")
        
        // sort
//        myCustomerArray.sortInPlace {(customer1:Customer, customer2:Customer) -> Bool in
//            customer1.id < customer2.id
//        }
//        albumItems.sortInPlace {(i1: MPMediaItem, i2:MPMediaItem) -> Bool in
//            i1.title < i2.title
//        }

//        albumItems.sort{$0.title < $1.title}
        
        
        // アルバム情報から曲情報を取得する
        for album in albumItems {
            let albumItems: [MPMediaItem] = album.items
            for song in albumItems {
                array.append( song )
            }
        }
        
        //sort
        //ref http://stackoverflow.com/questions/31729337/swift-2-0-sorting-array-of-objects-by-property Rob Nov 10 '15 at 18:00
        array.sortInPlace{$0.title < $1.title}
        
        return array
    }
    
    func getClips() -> Array<Clip> {

        // setup
        let sort_column = "title"
        
        let ascend = true

        // filter
        let query = "removed_at == ''"
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] query => \(query)")
        
        
        let aPredicate = NSPredicate(format: query)

        
        // find clips
        let resOf_Clips = Proj.find_All_Clips(sort_column, ascend: ascend, pred: aPredicate)
//        return Proj.find_All_Clips()
        
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_Clips.count => \(resOf_Clips.count)")
        
        return resOf_Clips

    }
    
    func _test_Migration() {
        
        //ref https://realm.io/docs/swift/latest/#adding-objects
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
//        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] Realm(path: \"abc.realm\") => done¥n migration => done")
        
        
    }
    
    func test_Realm() {
        
        /*
        
        new realm file
        
        */
        
        //        let realmPath = Realm.Configuration.defaultConfiguration.path
        //
        //        let dpath_realm = Methods.dirname(realmPath!)
        //
        //
        ////        let rl_tmp = try! Realm(path: "abc.realm")    //=> permission denied
        //        let rl_tmp = try! Realm(path: "\(dpath_realm)/abc.realm")   //=> works
        
        let rl_tmp = Methods.get_RealmInstance("abc.realm")
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] Realm(path: \"abc.realm\") => done")
        
        //        var dataArray = try! Realm().objects(BM).sorted("created_at", ascending: false)
        let dataArray = try! rl_tmp.objects(BM).sorted("created_at", ascending: false)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray => \(dataArray.count)")
        //debug
        if dataArray.count > 0 {
            
            let bm = dataArray.first
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray => \(bm?.title) (\(bm?.bm_time))")
            
        }
        
        
        
        //        Methods.show_DirList(dpath_realm)
        
        //        //debug
        //        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray => \(dataArray.count)")
        
        
        //        //test
        //        _ = try! Realm()
        
        //        let realmPath = Realm.Configuration.defaultConfiguration.path as! NSString
        //        let realmPath = Realm.Configuration.defaultConfiguration.path
        
        //        //debug
        //        print("[\(Methods.basename(__FILE__)):\(__LINE__)] realmPath => \(realmPath)")
        //
        //
        //        // files list
        //        Methods.show_DirList(realmPath!)
        
        // files list
        //        let dpath_realm = Methods.dirname(realmPath!)
        
        
        
        //        default.realm
        //        default.realm.lock
        //        default.realm.note
        
        //        try! realm.write {
        //
        //            //ref https://realm.io/docs/swift/latest/ "You can also delete all objects "
        //            realm.deleteAll()
        //
        //            //debug
        //            print("[\(Methods.basename(__FILE__)):\(__LINE__)] deleteAll => done")
        //
        ////            //test
        ////            realm.delete(BM)
        //                ///Users/mac/Desktop/works/WS/xcode/Chapter-7_L-43_after/AVPlayer/AVPlayer/MusicListViewController.swift:41:25: Cannot convert value of type '(BM).Type' (aka 'BM.Type') to expected argument type 'Object'
        //
        //            //debug
        //            print("[\(Methods.basename(__FILE__)):\(__LINE__)] BM => deleted")
        //
        //
        //        }     //=> works
        
    }
    
    func test_Subarrays() {
        
        let tmp = "/Library/abc/def/xyz.txt"
        
        let tokens = tmp.componentsSeparatedByString(CONS.s_DirSeparator)
        
        //        let ary_tmp = tokens[2...3]
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] tokens[2] => \(tokens[2])")
        
        let len = tokens.count
        
        let s_tmp = tokens[0...(len - 2)].joinWithSeparator(CONS.s_DirSeparator)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] tmp => \(tmp) *** s_tmp => \(s_tmp)")
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] tmp => \(tmp) *** Methods.dirname(tmp) => \(Methods.dirname(tmp))")
        
        
        //        let tmp2 = Methods.dirname(tmp)
        //        
        //        //debug
        //        print("[\(Methods.basename(__FILE__)):\(__LINE__)] tmp => \(tmp) *** tmp2 => \(tmp2)")
        
    }
    

}

