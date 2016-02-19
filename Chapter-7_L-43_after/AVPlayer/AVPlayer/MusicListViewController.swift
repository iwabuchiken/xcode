//
//  MusicListViewController.swift
//  AVPlayer
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit
import MediaPlayer
import RealmSwift

class MusicListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
  
  @IBOutlet var tableView: UITableView!

//    var dataArray = try! Realm().objects(BM).sorted("created_at", ascending: false)
//    var dataArray = try! Realm().objects(BM_2).sorted("created_at", ascending: false)
    
  // MARK: funcs for experiments
    @IBAction func experiments(sender: UIBarButtonItem) {

        let resOf_BMs = DB.findAll_BM(CONS.s_Realm_FileName, sort_key: "id", ascend: false)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_BMs.count => \(resOf_BMs.count)")
        
        
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
    
    
  // 曲情報
  var songs = Array<MPMediaItem>()
  
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
        
        let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName)
        
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
        var dataArray = try! rl_tmp.objects(BM).sorted("created_at", ascending: false)
        
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
    
  override func viewDidLoad() {
    super.viewDidLoad()
    songs = getSongs()
    tableView.reloadData()
    
//    // save songs data
//    Methods.save_SongsData(songs)

    
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
    
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // iPhone 内から曲情報を取得する
  func getSongs() -> Array<MPMediaItem> {
    
    var array = Array<MPMediaItem>()
    
    // アルバム情報を取得する
//    let albumsQuery: MPMediaQuery = MPMediaQuery.albumsQuery()
    let albumsQuery: MPMediaQuery = MPMediaQuery.songsQuery()

    let albumItems: [MPMediaItemCollection] = albumsQuery.collections!
    
    //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] albumItems.count => \(albumItems.count)")
    
    // アルバム情報から曲情報を取得する
    for album in albumItems {
      let albumItems: [MPMediaItem] = album.items
      for song in albumItems {
        array.append( song )
      }
    }
    
    return array
  }
  
  // MARK: UITableViewDataSource プロトコルのメソッド
  // TableView の各セクションのセルの数を返す
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return songs.count
  }
  
  // 各セルの内容を返す
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // 再利用可能な cell を得る
    let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
    
    // Cellに値を設定する.
    cell.textLabel?.text = songs[indexPath.row].title
    cell.detailTextLabel?.text = songs[indexPath.row].albumTitle
    
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
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] no BMs => start cellSegue")
            
            performSegueWithIdentifier("cellSegue",sender: nil)
            
            return
            
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
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    //debug
    print("[\(Methods.basename(__FILE__)):\(__LINE__)] destinationViewController => (\(segue.destinationViewController.description))")
    
    if let playerViewController = segue.destinationViewController as? PlayerViewController {
      let url = songs[(tableView.indexPathForSelectedRow?.row)!].valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL
        
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] url?.absoluteString => \(url?.absoluteString)")
      
        playerViewController.item_name = songs[(tableView.indexPathForSelectedRow?.row)!].title
        
        
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
            
        }


    }
    
}

