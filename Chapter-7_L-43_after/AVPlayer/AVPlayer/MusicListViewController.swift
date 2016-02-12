//
//  MusicListViewController.swift
//  AVPlayer
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit
import MediaPlayer

class MusicListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
  
  @IBOutlet var tableView: UITableView!
  
  // 曲情報
  var songs = Array<MPMediaItem>()
  
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
    if let playerViewController = segue.destinationViewController as? PlayerViewController {
      let url = songs[(tableView.indexPathForSelectedRow?.row)!].valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL
        
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] url?.absoluteString => \(url?.absoluteString)")
      
        playerViewController.item_name = songs[(tableView.indexPathForSelectedRow?.row)!].title
        
        
      playerViewController.playMusic(url!)
    }
  }
}

