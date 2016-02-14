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
    
    
  // 曲情報
  var songs = Array<MPMediaItem>()
  
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(animated: Bool) {

        // test: realm
        test_Realm()
        

        
    }
    
    func test_Realm() {

//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray => \(dataArray.count)")
        
        
//        //test
//        _ = try! Realm()
        
        //        let realmPath = Realm.Configuration.defaultConfiguration.path as! NSString
        let realmPath = Realm.Configuration.defaultConfiguration.path
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] realmPath => \(realmPath)")
        
        
        // files list
        Methods.show_DirList(realmPath!)
        
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
    
    //test
    //ref http://stackoverflow.com/questions/32290126/swift-add-gesture-recognizer-to-object-in-table-cell answered Aug 29 '15 at 21:00
//    var recognizer = UISwipeGestureRecognizer(target: self, action: "didSwipe")
//    self.tableView.addGestureRecognizer(recognizer)
    
    let recognizer = UIGestureRecognizer(target: self, action: "didSwipe")
    
    self.tableView.addGestureRecognizer(recognizer)
    
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
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("cellSegue",sender: nil)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
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
    }
  }
}

