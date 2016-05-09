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

// MARK: vars
    var locs = Proj.find_All_Locs(ascend : false)

    var loc_chosen : Loc?
    
    // MARK: view-related
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
    }
    
    
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] viewWillAppear")

        //debug
        print("[\(Methods.basename(#file)):\(#line)] locs => \(self.locs.count)")
        
    }

    // MARK: UITableViewDataSource プロトコルのメソッド
    // TableView の各セクションのセルの数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //        return dataArray.count
//        return 10
        return self.locs.count
        
    }
    
    // 各セルの内容を返す
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
//        cell.textLabel?.text = "lat=\(locs[indexPath.row].lat.value)/longi=\(locs[indexPath.row].longi.value)"
//        cell.textLabel?.text = "lat=\(Double(locs[indexPath.row].lat.description)!)/longi=\(Double(locs[indexPath.row].longi.description)!)"
//        cell.textLabel?.text = "lat=\(String(format : "%.4f", Double(locs[indexPath.row].lat.description)!))/longi=\(Double(locs[indexPath.row].longi.description)!)"
        //ref http://stackoverflow.com/questions/24051314/precision-string-format-specifier-in-swift answered Jun 5 '14 at 8:55
        //ref(also) http://stackoverflow.com/questions/27338573/rounding-a-double-value-to-x-number-of-decimal-places-in-swift answered Dec 7 '14 at 8:34
        cell.textLabel?.text = "\(String(format : "%.5f", Double(locs[indexPath.row].longi.description)!)) / \(String(format : "%.5f", Double(locs[indexPath.row].lat.description)!))"
        
//        Double(loc.latitude.description)!
        // description
        cell.detailTextLabel?.text = "\(locs[indexPath.row].created_at)"
        
        return cell
        
    }//tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
//            //debug
//            print("[\(Methods.basename(#file)):\(#line)] deleteing cell --> lat=\(locs[indexPath.row].lat.value)/longi=\(locs[indexPath.row].longi.value)")
            
        }
    }
    
    // セルが削除が可能なことを伝える
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle.Delete;
//        return UITableViewCellEditingStyle.Insert;
        
    }
    
    // 各セルを選択した時に実行される
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        //debug
//        print("[\(Methods.basename(#file)):\(#line)] path=\(indexPath.row) --> lat=\(locs[indexPath.row].lat.value)/longi=\(locs[indexPath.row].longi.value)")

        // set loc
        self.loc_chosen = self.locs[indexPath.row]
        
        // segue
        performSegueWithIdentifier("segue_LocList_2_ShowLoc",sender: nil)
        
    }
    
    // MARK: segue-related
    // segue で画面遷移するに呼ばれる
    override func prepareForSegue
    (segue: UIStoryboardSegue, sender: AnyObject?){

        if segue.identifier == "segue_LocList_2_ShowLoc" {
            
            // get vc
            let vc_target : VC_ShowLoc = segue.destinationViewController as! VC_ShowLoc

            // set loc
            vc_target.loc = self.loc_chosen!
            
        }
    }

    
}
