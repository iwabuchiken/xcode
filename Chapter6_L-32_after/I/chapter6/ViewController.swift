//
//  ViewController.swift
//  Chapter6
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

//ref folding http://pinkstone.co.uk/how-to-bring-back-code-folding-in-xcode-7/

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    //test: colors
    //ref http://makeapppie.com/2014/10/02/swift-swift-using-color-and-uicolor-in-swift-part-1-rgb/
    let myRedColor = UIColor(
        red:1.0,
        green:0.0,
        blue:0.0,
        alpha:1.0)
    
    // デフォルトの Realm インスタンスを取得する
    let realm = try! Realm()

    // DB 内の日記データが格納されるリスト(日付新しいもの順でソート：降順)。以降内容をアップデートするとリスト内は自動的に更新される。
    //let dataArray = try! Realm().objects(Diary).sorted("date", ascending: false)
    var dataArray = try! Realm().objects(Diary).sorted("created_at", ascending: false)
    //let dataArray = try! Realm().objects(Diary).sorted("id", ascending: false)
    
//    //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] Realm() => done")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //test
        //ref http://stackoverflow.com/questions/30679701/ios-swift-how-to-change-background-color-of-table-view answered Jun 6 '15 at 6:45
        self.tableView.backgroundColor = UIColor.lightGrayColor()
        
        // get defaults
        let tmp_s : String = Methods.get_Defaults(CONS.key_SearchWords)
        
//        let defaults = NSUserDefaults.standardUserDefaults()
//        
////        defaults.setValue(tmp_s, forKey: CONS.key_SearchWords)
////        let tmp_s : String? = (defaults.stringForKey(CONS.key_SearchWords))   //=> 'Optional(...)'
//        let tmp_s : String = defaults.stringForKey(CONS.key_SearchWords)!   //=> '那覇'
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] search words (from defaults) => \(tmp_s)")
        

        
        // Do any additional setup after loading the view, typically from a nib.
        
        //ref http://swift-salaryman.com/debug.php
//        print(self)
        
        //ref https://developer.apple.com/swift/blog/?id=15
//        print("\(self) =>  \(__FILE__):\(__LINE__)")

//        // show dir list
//        show_DirList()

//        //test
//        out_Message("abc/def")  // Methods.swift
        
//        //test 
//        Diary.show_ClassName()
       
        //test
//        Methods.out_Message("abc/def/ghi")
        
//        Methods().out_Message("abc/def/ghi")
//        Methods.basename("abc/def/ghi")
        
        
    }
    
    func show_DirList() {
        
        //ref http://stackoverflow.com/questions/26072796/get-list-of-files-at-path-swift answered Sep 27 '14 at 8:41
        let filemanager:NSFileManager = NSFileManager()
        let files = filemanager.enumeratorAtPath(NSHomeDirectory())
        while let file = files?.nextObject() {
            print(file)
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] viewWillAppear")
        
        // get defaults
        let tmp_s : String = Methods.get_Defaults(CONS.key_SearchWords)
        
        //        let defaults = NSUserDefaults.standardUserDefaults()
        //
        ////        defaults.setValue(tmp_s, forKey: CONS.key_SearchWords)
        ////        let tmp_s : String? = (defaults.stringForKey(CONS.key_SearchWords))   //=> 'Optional(...)'
        //        let tmp_s : String = defaults.stringForKey(CONS.key_SearchWords)!   //=> '那覇'
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] search words (from defaults) => \(tmp_s)")

        // objects with conditions
        _test_Realm_Conditions(tmp_s)
        
        
        tableView.reloadData()
        
        //test
        //ref http://stackoverflow.com/questions/19640050/custom-uitableviewcell-add-margin-between-each-cell answered Sep 11 '15 at 12:50
//        tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0)
        
    }
    
    func _test_Realm_Conditions(tmp_s : String) -> Void {
        
//        let aPredicate = NSPredicate(format: "color = %@ AND name BEGINSWITH %@", "red", "BMW")
//        redCars = realm.objects(Car).filter(aPredicate)
//        let aPredicate = NSPredicate(format: "title LIKE %@", tmp_s)
        

        if tmp_s == "" {
            
            // if the default is "" --> no filter
            dataArray = try! Realm().objects(Diary).sorted("created_at", ascending: false)

            
        } else {

            let aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)

            dataArray = try! Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)

        }
        
//        let aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
        
//        redCars = realm.objects(Car).filter(aPredicate)
        
//        dataArray = try! Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)
//        let dataArray_2 = try! Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)
        
        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray_2 => \(String(dataArray_2.count))")
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray => \(String(dataArray.count))")
        
    }//_test_Realm_Conditions(tmp_s : String) -> Void
    
    // segue で画面遷移するに呼ばれる
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){

        // sandbox segue?
        if segue.identifier == "sandboxSegue" {
            
        } else {
        
        
            let inputViewController:InputViewController = segue.destinationViewController as! InputViewController
        
            if segue.identifier == "cellSegue" {
                let indexPath = self.tableView.indexPathForSelectedRow
                inputViewController.diary = dataArray[indexPath!.row]
            } else {
                let diary = Diary()
//                diary.title = "タイトル"
//                diary.body = "本文"
                                diary.title = ""
                                diary.body = ""

                if dataArray.count != 0 {
                        diary.id = dataArray.max("id")! + 1
                }
            
                inputViewController.diary = diary
            }
        }
    }
    
    // MARK: UITableViewDataSource プロトコルのメソッド
    // TableView の各セクションのセルの数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    // 各セルの内容を返す
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        // Cellに値を設定する.
        let object = dataArray[indexPath.row]
        cell.textLabel?.text = object.title
        
        // date
//        let currentDate = NSDate()
        
        // bg color
        _tableView__Set_BGColor(cell, object: object)

        _tableView__Set_BGColor_Yesterday(cell, object: object)

//        //ref http://www.appcoda.com/nsdate/
//        let currentDate = object.date
//        
//        
//        let dateFormatter = NSDateFormatter()
//        
//        dateFormatter.locale = NSLocale.currentLocale()
//        
//        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
//        
//        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
//        
//        let convertedDate = dateFormatter.stringFromDate(currentDate)
//
////        cell.detailTextLabel?.text = object.date.description
//        cell.detailTextLabel?.text = convertedDate
//        
//        // bg color
////        let date_Today = dateFormatter.stringFromDate(NSDate())
//        let tmp_s = dateFormatter.stringFromDate(NSDate())
//        
////        let date_Today = Methods.get_Date(dateFormatter.stringFromDate(NSDate()))
//        let date_Today = Methods.get_Date(tmp_s)
//        let time_Today = Methods.get_Time(tmp_s)
//        
//        let date_Diary = Methods.get_Date(convertedDate)
//        let time_Diary = Methods.get_Time(convertedDate)
//        
////        if currentDate < 
//        
//        //ref http://stackoverflow.com/questions/30679701/ios-swift-how-to-change-background-color-of-table-view
////        cell.backgroundColor = UIColor.clearColor()
//
//        
//        if date_Diary >= date_Today {
//
//            // if the date is today
//            // if before noon
//            if time_Diary >= "12" {
//                
////                print("[\(Methods.basename(__FILE__)):\(__LINE__)] time_Diary (\(time_Diary)) >= 12")
//                
//                cell.backgroundColor = CONS.col_green_071000
//                
//            } else {
//
////                print("[\(Methods.basename(__FILE__)):\(__LINE__)] time_Diary (\(time_Diary)) < 12")
//
//                cell.backgroundColor = CONS.col_green_soft
//                
//            }
////            cell.backgroundColor = myRedColor
////            cell.backgroundColor = CONS.col_green_soft
//
//            
//        } else {
//            
//            cell.backgroundColor = UIColor.whiteColor()
//            
//        }
//        cell.backgroundColor = myRedColor
        
        return cell
    }//tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    
    func _tableView__Set_BGColor
    (cell : UITableViewCell, object : Diary) -> Void {
        
        //ref http://www.appcoda.com/nsdate/
        let currentDate = object.date
        
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale.currentLocale()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        let convertedDate = dateFormatter.stringFromDate(currentDate)
        
        //        cell.detailTextLabel?.text = object.date.description
        cell.detailTextLabel?.text = convertedDate
        
        // bg color
        //        let date_Today = dateFormatter.stringFromDate(NSDate())
        let tmp_s = dateFormatter.stringFromDate(NSDate())
        
        //        let date_Today = Methods.get_Date(dateFormatter.stringFromDate(NSDate()))
        let date_Today = Methods.get_Date(tmp_s)
        let time_Today = Methods.get_Time(tmp_s)
        
        let date_Diary = Methods.get_Date(convertedDate)
        let time_Diary = Methods.get_Time(convertedDate)
        
        //        if currentDate <
        
        //ref http://stackoverflow.com/questions/30679701/ios-swift-how-to-change-background-color-of-table-view
        //        cell.backgroundColor = UIColor.clearColor()
        
        
        if date_Diary >= date_Today {
            
            // if the date is today
            // if before noon
            if time_Diary >= "12" {
                
                //                print("[\(Methods.basename(__FILE__)):\(__LINE__)] time_Diary (\(time_Diary)) >= 12")
                
                cell.backgroundColor = CONS.col_green_071000
                
            } else {
                
                //                print("[\(Methods.basename(__FILE__)):\(__LINE__)] time_Diary (\(time_Diary)) < 12")
                
                cell.backgroundColor = CONS.col_green_soft
                
            }
            //            cell.backgroundColor = myRedColor
            //            cell.backgroundColor = CONS.col_green_soft
            
            
        } else {
            
            cell.backgroundColor = UIColor.whiteColor()
            
        }
        
    }//_tableView__Set_BGColor

    func _tableView__Set_BGColor_Yesterday
        (cell : UITableViewCell, object : Diary) -> Void {
            
            //ref http://www.appcoda.com/nsdate/
            let ns_CurrentDate = object.date
            
//            let ns_Date_Today = NSDate()
            
            // formatter
            let dateFormatter = NSDateFormatter()
            
            dateFormatter.locale = NSLocale.currentLocale()
            
            dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
            
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
            
//            let convertedDate = dateFormatter.stringFromDate(currentDate)
//            let dateLabel_Diary = dateFormatter.stringFromDate(currentDate)
            let s_DateLabel_Diary = Methods.conv_NSDate_2_DateString(ns_CurrentDate)
            
            //
            let ns_Date_Today = NSDate()

            let s_DateLabel_Today = dateFormatter.stringFromDate(ns_Date_Today)
//            let dateLabel_Now = dateFormatter.stringFromDate(NSDate())
            
            let s_DayLabel_Today = Methods.get_Date(s_DateLabel_Today)
            
            // yesterday
            let ns_Date_Yesterday = Methods.get_Date_BeforeAfter_ByDate(ns_Date_Today, diff: -1)
            
            
            let s_DateLabel_Yesterday = dateFormatter.stringFromDate(ns_Date_Yesterday)
            
            let s_DayLabel_Yesterday = Methods.get_Date(s_DateLabel_Yesterday)
            
            // X days ago
            let diff = -5
            
            let ns_Date_XDaysAgo = Methods.get_Date_BeforeAfter_ByDate(ns_Date_Today, diff: diff)
            
            
            let s_DateLabel_XDaysAgo = dateFormatter.stringFromDate(ns_Date_XDaysAgo)
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dateLabel_Diary => '\(s_DateLabel_Diary)' *** dateLabel_Now => '\(s_DateLabel_Today)' *** yesterday => '\(s_DateLabel_Yesterday)' *** \(diff) days ago => '\(s_DateLabel_XDaysAgo)'")

            // change bg color
            if s_DateLabel_Diary >= s_DayLabel_Today {
                
//                cell.backgroundColor = CONS.col_green_071000
                
            } else if s_DateLabel_Diary >= s_DayLabel_Yesterday {
                
//                cell.backgroundColor = CONS.col_Blue_020510
                cell.backgroundColor = CONS.col_Blue_020710
                
            }
            
            
//            
//            //ref http://stackoverflow.com/questions/30679701/ios-swift-how-to-change-background-color-of-table-view
//            //        cell.backgroundColor = UIColor.clearColor()
//            
//            
//            if date_Diary >= date_Today {
//                
//                // if the date is today
//                // if before noon
//                if time_Diary >= "12" {
//                    
//                    //                print("[\(Methods.basename(__FILE__)):\(__LINE__)] time_Diary (\(time_Diary)) >= 12")
//                    
//                    cell.backgroundColor = CONS.col_green_071000
//                    
//                } else {
//                    
//                    //                print("[\(Methods.basename(__FILE__)):\(__LINE__)] time_Diary (\(time_Diary)) < 12")
//                    
//                    cell.backgroundColor = CONS.col_green_soft
//                    
//                }
//                //            cell.backgroundColor = myRedColor
//                //            cell.backgroundColor = CONS.col_green_soft
//                
//                
//            } else {
//                
//                cell.backgroundColor = UIColor.whiteColor()
//                
//            }
            
    }//_tableView__Set_BGColor

    // MARK: UITableViewDataSource プロトコルのメソッド
    // Delete ボタンが押された時の処理を行う
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            try! realm.write {
                self.realm.delete(self.dataArray[indexPath.row])
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
        }
    }
    
    // セルが削除が可能なことを伝える
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete;
    }
    
    // 各セルを選択した時に実行される
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("cellSegue",sender: nil)
    }
}

