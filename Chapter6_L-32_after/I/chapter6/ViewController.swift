//
//  ViewController.swift
//  Chapter6
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

//ref folding http://pinkstone.co.uk/how-to-bring-back-code-folding-in-xcode-7/

import UIKit
import RealmSwift
import MessageUI

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {

    /*
        vars
    */
    var message_email = ""
    
    var fpath_realm_csv = ""
    var fname_realm_csv = ""
    
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
    
// MARK: view-related
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
    

    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

//        //debug
//        Methods.set_Defaults("", key: CONS.key_SearchWords)
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] search words => set ''")
        
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] viewWillAppear")

//        //debug
//        Methods.set_Defaults("")

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] defaults set => ''")

        
        // get defaults
//        let tmp_s : String = Methods.get_Defaults(CONS.key_SearchWords)
        //debug
        let tmp_s : String = Methods.get_Defaults(CONS.key_SearchWords)
        
        //        let defaults = NSUserDefaults.standardUserDefaults()
        //
        ////        defaults.setValue(tmp_s, forKey: CONS.key_SearchWords)
        ////        let tmp_s : String? = (defaults.stringForKey(CONS.key_SearchWords))   //=> 'Optional(...)'
        //        let tmp_s : String = defaults.stringForKey(CONS.key_SearchWords)!   //=> '那覇'
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] search words (from defaults) => \(tmp_s)")

        // objects with conditions
        _test_Realm_Conditions__MultipleKeywords(tmp_s)

        
//        // objects with conditions
//        _test_Realm_Conditions(tmp_s)
        
        
        tableView.reloadData()
        
        //test
        //ref http://stackoverflow.com/questions/19640050/custom-uitableviewcell-add-margin-between-each-cell answered Sep 11 '15 at 12:50
//        tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0)
        
    }
    
// MARK: realm-related
    func _test_Realm_Conditions__MultipleKeywords(tmp_s : String) -> Void {
        
        //debug
        if tmp_s == "" {

            // if the default is "" --> no filter
            dataArray = try! Realm().objects(Diary).sorted("created_at", ascending: false)
            
            
        } else {
            
            let tokens = tmp_s.componentsSeparatedByString(" ")
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] tokens.count => \(tokens.count)")
            
            // query
            var query = ""
            
            var aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
            
            if tokens.count == 1 {

                //ref http://stackoverflow.com/questions/24037711/get-the-length-of-a-string answered Jun 4 '14 at 12:41
//                let len = count(tokens[0])
                let len = tokens[0].characters.count
//                if len > 1 {

                    //ref http://stackoverflow.com/questions/32413247/swift-2-0-string-with-substringwithrange answered Sep 5 '15 at 13:01
                    //                print("[\(Methods.basename(__FILE__)):\(__LINE__)] tmp_s[0] => \(tmp_s.characters.first)")    //=> /Users/mac/Desktop/works/WS/xcode/
                    print("[\(Methods.basename(__FILE__)):\(__LINE__)] tmp_s[0] => \(String(tmp_s.characters.first!))")    //=> /Users/mac/Desktop/works/WS/xcode/

//                }
                
//                //ref http://stackoverflow.com/questions/32413247/swift-2-0-string-with-substringwithrange answered Sep 5 '15 at 13:01
////                print("[\(Methods.basename(__FILE__)):\(__LINE__)] tmp_s[0] => \(tmp_s.characters.first)")    //=> /Users/mac/Desktop/works/WS/xcode/
//                print("[\(Methods.basename(__FILE__)):\(__LINE__)] tmp_s[0] => \(String(tmp_s.characters.first!))")    //=> /Users/mac/Desktop/works/WS/xcode/

//                print("[\(Methods.basename(__FILE__)):\(__LINE__)] tmp_s[4] => \(String(tmp_s[tmp_s.startIndex.advancedBy(4)]))")    //=> /Users/mac/Desktop/works/WS/  //=> n.w.//=> n.w. :=> 'fatal error: Can't form a Character from an empty String (lldb) '

//                print("[\(Methods.basename(__FILE__)):\(__LINE__)] tmp_s[4] => \(tmp_s[tmp_s.startIndex.advancedBy(4)])")  //=> n.w. :=> 'fatal error: Can't form a Character from an empty String (lldb) '
                
//                print("[\(Methods.basename(__FILE__)):\(__LINE__)] tmp_s.startIndex.advancedBy(4) => \(tmp_s.startIndex.advancedBy(4))")
//                //=> '4'
                
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] predicate => building")

//                let q = "title NOT CONTAINS '\(tmp_s)'"
//                let q = "NOT title CONTAINS '\(tmp_s)'"   //=> works
              
                if String(tmp_s.characters.first!) == "-" {
                    
                    //ref http://stackoverflow.com/questions/32575227/swift-2-0-substringwithrange answered Sep 15 '15 at 2:30
//                    print("[\(Methods.basename(__FILE__)):\(__LINE__)] substring => \(tmp_s[tmp_s.startIndex..<tmp_s.startIndex.advancedBy(3)])")   //=> works
                    
//                    print("[\(Methods.basename(__FILE__)):\(__LINE__)] tmp_s[tmp_s.startIndex..<tmp_s.startIndex.advancedBy(tmp_s.characters.count - 1)] => %s", tmp_s[tmp_s.startIndex..<tmp_s.startIndex.advancedBy(tmp_s.characters.count - 1)])
                    print("[\(Methods.basename(__FILE__)):\(__LINE__)] tmp_s[tmp_s.startIndex.advancedBy((1))..<tmp_s.startIndex.advancedBy(tmp_s.characters.count)] => ", tmp_s[tmp_s.startIndex.advancedBy((1))..<tmp_s.startIndex.advancedBy(tmp_s.characters.count)])
                    
                    aPredicate = NSPredicate(
                                    format: "NOT title CONTAINS %@",
                        tmp_s[tmp_s.startIndex..<tmp_s.startIndex.advancedBy(tmp_s.characters.count - 1)]

//                                tmp_s[tmp_s.startIndex..<tmp_s.characters.count - 1]
//                                    tmp_s
                    )
                    
                    print("[\(Methods.basename(__FILE__)):\(__LINE__)] NOT directive")
                    
                } else {

                    aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
                    
                }
                
//                aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
//                aPredicate = NSPredicate(format: "title NOT CONTAINS %@", tmp_s)
//                aPredicate = NSPredicate(format: q)
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] predicate => built")
                
            } else if tokens.count > 1 {
                
//                query = "title CONTAINS \(tokens[0])"
                query = "title CONTAINS '\(tokens[0])'"
                
                for index in 1...(tokens.count - 1) {
                    
                    // '-' directive
                    if String(tokens[index].characters.first!) == "-" {
                        
//                        query += " AND NOT title CONTAINS '\(tokens[index])'"
                        query += " AND NOT title CONTAINS '\(tokens[index][tokens[index].startIndex.advancedBy((1))..<tokens[index].startIndex.advancedBy(tokens[index].characters.count)])'"

                     
                    } else {

                        query += " AND title CONTAINS '\(tokens[index])'"
                        
                    }
                    
//                    query += " AND title CONTAINS '\(tokens[index])'"
                    
                }
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] query => \(query)")
                
                //                let aPredicate = NSPredicate(query)
                //                aPredicate = query
                //                aPredicate = NSPredicate(query)
                aPredicate = NSPredicate(format: query)
                
            } else {
                
                aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
                
            }
            
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] query => \(query)")
            
            
//            aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
            
            //            dataArray = try! Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)
            //ref https://www.hackingwithswift.com/new-syntax-swift-2-error-handling-try-catch
            do {
                
                dataArray = try Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)
                
            } catch is NSException {
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] NSException => \(NSException.description())")
                
                //ref https://www.bignerdranch.com/blog/error-handling-in-swift-2/
            } catch let error as NSError {
                
                //debug
                //                print("[\(Methods.basename(__FILE__)):\(__LINE__)] NSError => \(NSException.description())")  //=> build succeeded
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] NSError => \(error.description)")  //=> build succeeded
                
            }
            
//            } catch let error as NSInvalidArgumentException {
//
//                print("[\(Methods.basename(__FILE__)):\(__LINE__)] NSError => \(error.description)")  //=> build succeeded
//
//                
//            }
            
            //            dataArray = try! Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)
            
        }
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray => \(String(dataArray.count))")

    }
    
    func _test_Realm_Conditions(tmp_s : String) -> Void {
        
//        let aPredicate = NSPredicate(format: "color = %@ AND name BEGINSWITH %@", "red", "BMW")
//        redCars = realm.objects(Car).filter(aPredicate)
//        let aPredicate = NSPredicate(format: "title LIKE %@", tmp_s)
        
//        //debug: defaults string => force to be "" (blank)
//        tmp_s = ""
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] tmp_s => forced to be ''")

        //debug
//        if true     {
        if tmp_s == "" {
        
            // if the default is "" --> no filter
            dataArray = try! Realm().objects(Diary).sorted("created_at", ascending: false)

            
        } else {

            let tokens = tmp_s.componentsSeparatedByString(" ")
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] tokens.count => \(tokens.count)")
            
            // query
            var query = ""
            
//            var aPredicate = ""
//            var aPredicate = nil
            
            var aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
            
            if tokens.count == 1 {
            
                aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
                
            } else if tokens.count > 1 {
                
                query = "title CONTAINS '\(tokens[0])'"
                
                for index in 1...(tokens.count - 1) {
                    
                    query += " AND title CONTAINS '\(tokens[index])'"
                    
                }
                
//                let aPredicate = NSPredicate(query)
//                aPredicate = query
//                aPredicate = NSPredicate(query)
                aPredicate = NSPredicate(format: query)
                
            } else {
                
                aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
                
            }
        
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] query => \(query)")

            
            aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)

//            dataArray = try! Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)
            //ref https://www.hackingwithswift.com/new-syntax-swift-2-error-handling-try-catch
            do {

                dataArray = try Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)

            } catch is NSException {
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] NSException => \(NSException.description())")
                
            //ref https://www.bignerdranch.com/blog/error-handling-in-swift-2/
            } catch let error as NSError {
                
                //debug
//                print("[\(Methods.basename(__FILE__)):\(__LINE__)] NSError => \(NSException.description())")  //=> build succeeded
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] NSError => \(error.description)")  //=> build succeeded
                
                
                
            }
            
//            dataArray = try! Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)

        }
        
//        let aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
        
//        redCars = realm.objects(Car).filter(aPredicate)
        
//        dataArray = try! Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)
//        let dataArray_2 = try! Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)
        
        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray_2 => \(String(dataArray_2.count))")
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] dataArray => \(String(dataArray.count))")
        
    }//_test_Realm_Conditions(tmp_s : String) -> Void
    
// MARK: segue-related
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

        
        return cell
    }//tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    
    func _tableView__Set_BGColor
    (cell : UITableViewCell, object : Diary) -> Void {
        
        //ref http://www.appcoda.com/nsdate/
//        let currentDate = object.date
        let currentDate = object.created_at
        
        
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
            
//            //debug
//            print("[\(Methods.basename(__FILE__)):\(__LINE__)] dateLabel_Diary => '\(s_DateLabel_Diary)' *** dateLabel_Now => '\(s_DateLabel_Today)' *** yesterday => '\(s_DateLabel_Yesterday)' *** \(diff) days ago => '\(s_DateLabel_XDaysAgo)'")

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

// MARK: navigation buttons
    @IBAction func experiments(sender: UIBarButtonItem) {

//        _experiments__Get_LastBackupAt()
        
//        _experiments__RegEx_Matching()
        
        _experiments__UIAlert()
        
    }
    
    func _experiments__UIAlert() {
    
        //ref http://stackoverflow.com/questions/25511945/swift-alert-view-ios8-with-ok-and-cancel-button-which-button-tapped answered Aug 26 '14 at 17:51
        // ref handler http://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift answered Jun 3 '14 at 18:48
        var refreshAlert = UIAlertController(title: "Refresh", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] clicked => Ok button")

        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
    }
    
    func _experiments__RegEx_Matching() {
        
        do {
//            let regex = try NSRegularExpression(pattern: "(<img.*?src=\")(.*?)(\".*?>)", options: [])
            
            //ref http://stackoverflow.com/questions/31406706/how-to-use-nsregularexpression-in-swift-2-0-in-xcode-7 answered Jul 14 '15 at 13:36
            let realmPath = Realm.Configuration.defaultConfiguration.path
            
            let dpath_realm = Methods.dirname(realmPath!)
            
            let fname = "realm_data_20160221_151229.csv"
            
            let fpath_full = "\(dpath_realm)/\(fname)"
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] fpath_full => \(fpath_full)")
            
            //        //debug
            //        print("[\(Methods.basename(__FILE__)):\(__LINE__)] tokens.count => \(tokens.count)")
            
            
            //        let lines = NSString(string: fpath_full)
            //        let content = NSString(contentsOfFile: fpath_full, encoding: NSUTF8StringEncoding, error: nil)
            //        let content = String(contentsOfFile: fpath_full, encoding: NSUTF8StringEncoding, error: nil)
            //ref https://www.hackingwithswift.com/read/5/2/reading-from-disk-contentsoffile
            let content = try? String(contentsOfFile: fpath_full, encoding: NSUTF8StringEncoding)
            
            
            if content != nil {

//                let str = Methods.conv_String_2_EscapedString(<#T##str: String##String#>)
                
                let regex = try NSRegularExpression(pattern: "¥d¥d¥d¥d/¥d¥d/¥d¥d ¥d¥d:¥d¥d:¥d¥d", options: [])
                
//                let res = regex.firstMatchInString(content, options:[],
//                    range: NSMakeRange(0, utf16.count)) != nil
                let res = regex.description

                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] res => \(res)")
                
            } else {
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] content => nil")

            }
            
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }

    func _experiments__Get_LastBackupAt() {
        
        let realmPath = Realm.Configuration.defaultConfiguration.path
        
        let dpath_realm = Methods.dirname(realmPath!)

        let fname = "realm_data_20160221_151229.csv"
        
        let fpath_full = "\(dpath_realm)/\(fname)"
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] fpath_full => \(fpath_full)")

//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] tokens.count => \(tokens.count)")
        
        
//        let lines = NSString(string: fpath_full)
//        let content = NSString(contentsOfFile: fpath_full, encoding: NSUTF8StringEncoding, error: nil)
//        let content = String(contentsOfFile: fpath_full, encoding: NSUTF8StringEncoding, error: nil)
        //ref https://www.hackingwithswift.com/read/5/2/reading-from-disk-contentsoffile
        let content = try? String(contentsOfFile: fpath_full, encoding: NSUTF8StringEncoding)

        
        if content != nil {

//            let tokens = content!.componentsSeparatedByString("\n")
            let tokens = content!.componentsSeparatedByString("\n")

//            if tokens != nil {
            
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] tokens.count => \(tokens.count)")

            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] tokens[0] => \(tokens[0])")

//            }
            
        } else {

            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] content => nil")

        }
        
//        let tokens = content.componentsSeparatedByString("\n")
        
        
        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] tokens.count => \(tokens.count)")

        
//        let tokens = content        
//        let tokens = lines.componentsSeparatedByString("\n")
        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] tokens.count => \(tokens.count)")

    }
    
    @IBAction func backupDiaries_ViaEmail(sender: UIBarButtonItem) {
      
        /*
            confirm dialog

        */
        let title = "Send data via email"
        let message = "Diary data in csv format"
        
//        var refreshAlert = UIAlertController(title: "Refresh", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.Alert)
        var refreshAlert = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] clicked => Ok button")
            
            // start email
            self.backupDiaries_ViaEmail__Ok()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] experiments")
        
//        // build csv
//        //ref http://www.learncoredata.com/how-to-save-files-to-disk/
//        let realmPath = Realm.Configuration.defaultConfiguration.path
//        
//        let dpath_realm = Methods.dirname(realmPath!)
//        
//        let fname = "realm_data_\(Methods.get_TimeLabel__Serial()).csv"
//        
//        let fpath_full = "\(dpath_realm)/\(fname)"
//        //        let fpath_full = "\(dpath_realm)/realm_data_\(Methods.get_TimeLabel__Serial()).csv"
//        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] fpath_full => \(fpath_full)")
//        
//        // build => CSV
//        //        _experiments__BuildCSV()
//        _experiments__BuildCSV(fpath_full)
//        
//        //debug
//        print("[\(Methods.basename(__FILE__)):\(__LINE__)] CONS.s_Latest_Diary_at => \(CONS.s_Latest_Diary_at)")
//        
//        
//        // email
//        self.fpath_realm_csv = fpath_full
//        self.fname_realm_csv = fname
//        
//        _experiments__SendEmails()
//        
//        //        dataArray = try! Realm().objects(Diary).sorted("created_at", ascending: false)
//        
//        
//        //        // dir list
//        //        let ary = Methods.show_DirList__RealmFiles()

    }

    func backupDiaries_ViaEmail__Ok() {
        
        // build csv
        //ref http://www.learncoredata.com/how-to-save-files-to-disk/
        let realmPath = Realm.Configuration.defaultConfiguration.path
        
        let dpath_realm = Methods.dirname(realmPath!)
        
        let fname = "realm_data_\(Methods.get_TimeLabel__Serial()).csv"
        
        let fpath_full = "\(dpath_realm)/\(fname)"
        //        let fpath_full = "\(dpath_realm)/realm_data_\(Methods.get_TimeLabel__Serial()).csv"
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] fpath_full => \(fpath_full)")
        
        // build => CSV
        //        _experiments__BuildCSV()
        _experiments__BuildCSV(fpath_full)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] CONS.s_Latest_Diary_at => \(CONS.s_Latest_Diary_at)")
        
        
        // email
        self.fpath_realm_csv = fpath_full
        self.fname_realm_csv = fname
        
        _experiments__SendEmails()
        
        //        dataArray = try! Realm().objects(Diary).sorted("created_at", ascending: false)
        
        
        //        // dir list
        //        let ary = Methods.show_DirList__RealmFiles()
    }
    
    func _experiments__BuildCSV(fpath_full : String) {
    
        let r = try! Realm()
        
//        let resOf_Diaries = try! r.objects(Diary).sorted("created_at", ascending: false)
        let resOf_Diaries = r.objects(Diary).sorted("created_at", ascending: false)
        
        // latest diary
        let tmp_Diaries = r.objects(Diary).sorted("date", ascending: false)
        let latest_diary = tmp_Diaries[0]
        
        CONS.s_Latest_Diary_at = Methods.conv_NSDate_2_DateString(latest_diary.date)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] resOf_Diaries.count => \(resOf_Diaries.count)")

        // convert Diaries --> csv : [String]
        let linesOf_Diaries = Methods.conv_Diaries_2_CSV(resOf_Diaries)

        
        // write to file
//                //ref http://www.learncoredata.com/how-to-save-files-to-disk/
//                let realmPath = Realm.Configuration.defaultConfiguration.path
//        
//                let dpath_realm = Methods.dirname(realmPath!)
//        
//                let fpath_full = "\(dpath_realm)/realm_data_\(Methods.get_TimeLabel__Serial()).csv"

        // write to csv
        Methods.writeTo_File__CSV_ForBackup(fpath_full, lines: linesOf_Diaries)
        
        // report
        Methods.show_DirList__RealmFiles()

        // email
        
        
        
    }

    // MARK: email-related
    /*
    _experiments__SendEmails
    
    <dependencies>
    configuredMailComposeViewController
    showSendMailErrorAlert
    mailComposeController
    
    */
    //ref http://kellyegan.net/sending-files-using-swift/
    func _experiments__SendEmails() {
        
        let mailComposeViewController = configuredMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail() {
            
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            
        } else {
            
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController()
        -> MFMailComposeViewController {
            
            let mailComposerVC = MFMailComposeViewController()
            
            mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
            
////            mailComposerVC.setToRecipients(["someone@somewhere.com"])
//            mailComposerVC.setToRecipients([""])

            //        mailComposerVC.setSubject("Sending you an in-app e-mail...")
            
            mailComposerVC.setSubject("myself] xcode_Memo \(Methods.get_TimeLable())")
            
//            mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
            mailComposerVC.setMessageBody(self.message_email, isHTML: false)
            
            // attach file
            //        if let filePath = NSBundle.mainBundle().pathForResource("swifts", ofType: "wav") {
            let realmPath = Realm.Configuration.defaultConfiguration.path
            
            let dpath_realm = Methods.dirname(realmPath!)
            
            //        let fpath_realm = "\(dpath_realm)/\(CONS.s_Realm_FileName)"
//            let fpath_realm = "\(dpath_realm)/realm_data_20160221_093611.csv"
            let fpath_realm = "\(self.fpath_realm_csv)"
            
            //        if let filePath = NSBundle.mainBundle().pathForResource("swifts", ofType: "wav") {
            //        if let filePath = NSBundle.mainBundle().pathForResource(fpath_realm, ofType: "realm") {
//            if let filePath = NSBundle.mainBundle().pathForResource("db_20160220_002443", ofType: "realm") {
//                
//                //debug
//                print("[\(Methods.basename(__FILE__)):\(__LINE__)] path to attached file => \(filePath)")
//                
//                //            print("File path loaded.")
//                
//            } else {
//                
//                //debug
//                print("[\(Methods.basename(__FILE__)):\(__LINE__)] can't generate path => \(fpath_realm)")
//                
//                
//            }
            
            // load data
            //        if let fileData = NSData(contentsOfFile: filePath) {
            if let fileData = NSData(contentsOfFile: fpath_realm) {
                
                //debug
                print("[\(Methods.basename(__FILE__)):\(__LINE__)] data created")
                //            print("[\(Methods.basename(__FILE__)):\(__LINE__)] data created => \(fileData.description)")
                //            println("File data loaded.")
                
                // attach data
                //ref http://kellyegan.net/sending-files-using-swift/
//                mailComposerVC.addAttachmentData(fileData, mimeType: "application/octet-stream", fileName: "realm_data_20160221_093611.csv")
                mailComposerVC.addAttachmentData(fileData, mimeType: "application/octet-stream", fileName: self.fname_realm_csv)
                
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
    
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] mailComposeController => called")

        
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    

}

