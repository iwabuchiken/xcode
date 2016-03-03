//
//  VC_Hist.swift
//  Chapter6
//
//  Created by mac on 2016/03/03.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import UIKit
import RealmSwift
import MessageUI

class VC_Hist: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblview_Hist: UITableView!
    /*
        vars
    */
    var aryOf_Hists : [Hist] = Array<Hist>()
    
    
    @IBAction func backTo_SandboxView(sender: UIButton) {
        
//        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    // MARK: view-related
    override func viewDidLoad() {

        super.viewDidLoad()
        
        
    }
    
    
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] viewWillAppear")

        // build: hist list
        _viewWillAppear__Build_HistList()
        
    }

    func _viewWillAppear__Build_HistList() {
    
        // setup realm
        let realm_admin = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
        
        let resOf_Hists = try! realm_admin.objects(Hist).sorted("created_at", ascending: false)
        
        // build array
        // reset
        self.aryOf_Hists.removeAll()
        
        // iterate
        let len = resOf_Hists.count
        
        for var i = 0; i < len; i++ {
            
            let hist = resOf_Hists[i]
            
            self.aryOf_Hists.append(hist)
            
        }
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_Hists.count => \(resOf_Hists.count) / aryOf_Hists.count => \(aryOf_Hists.count)")
        
    }
    
    // MARK: UITableViewDataSource プロトコルのメソッド
    // TableView の各セクションのセルの数を返す
    func tableView
    (tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

//        return 10
        return self.aryOf_Hists.count
        
    }
    
    // 各セルの内容を返す
    func tableView
    (tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        // Cellに値を設定する.

//        cell.textLabel?.text = "row \(indexPath.row)"
        cell.textLabel?.text = self.aryOf_Hists[indexPath.row].keywords
        
        // date
        //        let currentDate = NSDate()
        
        
        return cell
        
    }//tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    
    // Delete ボタンが押された時の処理を行う
    func tableView
    (tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {

            let realm = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
            
            try! realm.write {
                
                realm.delete(self.aryOf_Hists[indexPath.row])
                
//                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                
                self._viewWillAppear__Build_HistList()
                
                self.tblview_Hist.reloadData()
                
            }

            
        }
    }
    
    // セルが削除が可能なことを伝える
    func tableView
    (tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle.Delete;
        
    }
    
    // 各セルを選択した時に実行される
    func tableView
    (tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] selected => \(indexPath.row), keywords => \(self.aryOf_Hists[indexPath.row].keywords)")
        
        // set defaults
        // set defaults
        Methods.set_Defaults(self.aryOf_Hists[indexPath.row].keywords)

        // back to Sandbox
        self.navigationController?.popViewControllerAnimated(true)

    }

    
}
