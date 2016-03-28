//
//  VC_LocList.swift
//  Chapter6
//
//  Created by mac on 2016/03/28.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class VC_LocList: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: view-related
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
    }
    
    
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] viewWillAppear")

        
    }

    // MARK: UITableViewDataSource プロトコルのメソッド
    // TableView の各セクションのセルの数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //        return dataArray.count
        return 10
        
    }
    
    // 各セルの内容を返す
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = "cell is \(indexPath.description)"
        
        return cell
        
    }//tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] deleteing cell...")
            
        }
    }
    
    // セルが削除が可能なことを伝える
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle.Delete;
        
    }
    
    // 各セルを選択した時に実行される
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        performSegueWithIdentifier("cellSegue",sender: nil)
        
    }
    
    // MARK: segue-related
    // segue で画面遷移するに呼ばれる
    override func prepareForSegue
        (segue: UIStoryboardSegue, sender: AnyObject?){

    }

    
}
