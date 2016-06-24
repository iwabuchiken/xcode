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


import Photos

        //import UIKit
        //import CoreLocation
        //import MapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

//    UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate
    /*
        vars
    */
    var message_email = ""
    
    var fpath_realm_csv = ""
    var fname_realm_csv = ""

    var imageArray: Array<UIImage> = Array<UIImage>()
    
    // number of cells
    var numOf_Cells = 0
    
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

//    let realm_admin = try! Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
    let realm_admin = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
    
    // DB 内の日記データが格納されるリスト(日付新しいもの順でソート：降順)。以降内容をアップデートするとリスト内は自動的に更新される。
    var dataArray = try! Realm().objects(Diary).sorted("created_at", ascending: false)

    var dataArray_2 = try! Realm().objects(Diary).sorted("created_at", ascending: false)
    var dataArray_3 = try! Realm().objects(Diary).sorted("created_at", ascending: false)
    
    var aryOf_Diaries__2 = [Diary]()
    var aryOf_Diaries__3 = [Diary]()
    
    var aryOf_Diaries = [Diary]()

// MARK: funcs
    
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
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] search words (from defaults) => \(tmp_s)")
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    

    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(animated: Bool) {

        super.viewWillAppear(animated)

        //debug
        var tmp_s : String = Methods.get_Defaults(CONS.key_SearchWords)

        //debug
        print("[\(Methods.basename(#file)):\(#line)] search words (from defaults) => \(tmp_s)")

//        // validate
//        if (tmp_s == nil) {
//
//            tmp_s = ""
//            
//        } else {

            // trim string
        if (tmp_s != "") {
            
            tmp_s = Methods.trim_String(tmp_s)

        }
        
//        }
        
//        // trim string
//        tmp_s = Methods.trim_String(tmp_s)
        
//        // objects with conditions
//        _test_Realm_Conditions__MultipleKeywords(tmp_s)
        
        // build --> aryOf_Diaries
        _conv_Results_2_Array__Diaries()
        
        // buid dataArray --> new func
//         buid dataArray_2 --> new func
        _build_DataArray__With_Keywords(tmp_s)

        // build
        self.aryOf_Diaries = self.aryOf_Diaries__2
        
//        // build
//        dataArray = dataArray_2
//        
//        // build --> aryOf_Diaries
//        _conv_Results_2_Array__Diaries()

        
        // number of cells
        let limit = Proj.get_Limit_on_NumOf_Diaries()
        
//        if limit < self.dataArray.count {
        if limit < self.aryOf_Diaries.count {
        
            self.numOf_Cells = limit
            
        } else {
            
//            self.numOf_Cells = self.dataArray.count
            
            self.numOf_Cells = self.aryOf_Diaries.count
            
        }
        
        
        // reload data
        tableView.reloadData()
        
        // reind new diaries
        self._viewWillAppear__Remind_NewDiaries()
        
    }
    
    func _viewWillAppear__Remind_NewDiaries() {
        
        // default value
        let pref = Methods.getDefaults_Boolean(CONS.defaultKeys.key_Default__Remind_NewDiaries)
        
        if pref == true {
            
            let numOf_NewDiaries = Proj.get_NumOf__NewDiaries()
            
            let numOf_NewDiaries__Default = Methods.getDefaults_Integer(CONS.defaultKeys.key_Default__NumOf_NewDiaries)
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] numOf_NewDiaries => \(numOf_NewDiaries) / numOf_NewDiaries__Default => \(numOf_NewDiaries__Default)")

            // remind
//            if numOf_NewDiaries >= 10 {
            if numOf_NewDiaries >= numOf_NewDiaries__Default {
            
                let upload = self.show_Dialog__Remind_NewDiaries(numOf_NewDiaries)
                
            } else {

                //debug
                print("[\(Methods.basename(#file)):\(#line)] numOf_NewDiaries => \(numOf_NewDiaries); not reminding...")

            }
            
            
        }
        
    }
    
// MARK: realm-related
    func _test_Realm_Conditions__MultipleKeywords
    (tmp_s : String) -> Void {
        
        //debug
        if tmp_s == "" {

            // if the default is "" --> no filter
            dataArray = try! Realm().objects(Diary).sorted("created_at", ascending: false)
        
        } else if tmp_s == "@@@" {//if tmp_s == ""
        
            let query = "title == ''"
            
            let aPredicate = NSPredicate(format: query)
            
            do {
                
                dataArray = try Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)
                
            } catch is NSException {
                
                //debug
                print("[\(Methods.basename(#file)):\(#line)] NSException => \(NSException.description())")
                
                //ref https://www.bignerdranch.com/blog/error-handling-in-swift-2/
            } catch let error as NSError {
                
                //debug
                //                print("[\(Methods.basename(#file)):\(#line)] NSError => \(NSException.description())")  //=> build succeeded
                print("[\(Methods.basename(#file)):\(#line)] NSError => \(error.description)")  //=> build succeeded
                
            }
            
        } else {//if tmp_s == ""
            
            let tokens = tmp_s.componentsSeparatedByString(" ")
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] tokens.count => \(tokens.count)")
            
            //debug
            for item in tokens {

                print("item = '\(item)'")
                
            }
            
            // query
            var query = ""
            
            // search memo, too?
            // defaults
            let defaults = NSUserDefaults.standardUserDefaults()
            
            //        var dfltVal_DebugMode = defaults.valueForKey(CONS.defaultKeys.key_Set_DebugMode)
            let dfltVal_Search_MemoColumn = defaults.valueForKey(CONS.defaultKeys.key_Search_MemoColumn)

//            if dfltVal_Search_MemoColumn == nil || dfltVal_Search_MemoColumn == true {
            if dfltVal_Search_MemoColumn == nil {
            
                query = "title CONTAINS '\(tmp_s)' OR body CONTAINS '\(tmp_s)'"

//            } else if dfltVal_Search_MemoColumn == true {
            } else if dfltVal_Search_MemoColumn?.boolValue == true {

                query = "title CONTAINS '\(tmp_s)' OR body CONTAINS '\(tmp_s)'"
                
            } else {

                query = "title CONTAINS '\(tmp_s)'"
                
            }
            
//            var aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
            var aPredicate = NSPredicate(format: query)
            
            if tokens.count == 1 {

                //ref http://stackoverflow.com/questions/24037711/get-the-length-of-a-string answered Jun 4 '14 at 12:41
//                let len = count(tokens[0])
//                let len = tokens[0].characters.count
//                if len > 1 {

                    //ref http://stackoverflow.com/questions/32413247/swift-2-0-string-with-substringwithrange answered Sep 5 '15 at 13:01
                    //                print("[\(Methods.basename(#file)):\(#line)] tmp_s[0] => \(tmp_s.characters.first)")    //=> /Users/mac/Desktop/works/WS/xcode/
                    print("[\(Methods.basename(#file)):\(#line)] tmp_s[0] => \(String(tmp_s.characters.first!))")    //=> /Users/mac/Desktop/works/WS/xcode/

//                }
                
//                //ref http://stackoverflow.com/questions/32413247/swift-2-0-string-with-substringwithrange answered Sep 5 '15 at 13:01

                //debug
                print("[\(Methods.basename(#file)):\(#line)] predicate => building")

                if String(tmp_s.characters.first!) == "-" {
                    
                    //ref http://stackoverflow.com/questions/32575227/swift-2-0-substringwithrange answered Sep 15 '15 at 2:30
                    print("[\(Methods.basename(#file)):\(#line)] tmp_s[tmp_s.startIndex.advancedBy((1))..<tmp_s.startIndex.advancedBy(tmp_s.characters.count)] => ", tmp_s[tmp_s.startIndex.advancedBy((1))..<tmp_s.startIndex.advancedBy(tmp_s.characters.count)])
                    
                    aPredicate = NSPredicate(
                                    format: "NOT title CONTAINS %@",
//                        tmp_s[tmp_s.startIndex..<tmp_s.startIndex.advancedBy(tmp_s.characters.count - 1)]
                        tmp_s[tmp_s.startIndex.advancedBy(1)..<tmp_s.startIndex.advancedBy(tmp_s.characters.count)]


//                                tmp_s[tmp_s.startIndex..<tmp_s.characters.count - 1]
//                                    tmp_s
                    )
                    
                    print("[\(Methods.basename(#file)):\(#line)] NOT directive")
                    
                } else {

                    // no op ==> using aPredicate defined earlier
                    
//                    aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
                    
                }
                
                //debug
                print("[\(Methods.basename(#file)):\(#line)] predicate => built")
                
            } else if tokens.count > 1 {
                
//                query = "title CONTAINS \(tokens[0])"
                query = "title CONTAINS '\(tokens[0])'"
                
                for index in 1...(tokens.count - 1) {
                    
                    // validate: not blank
                    if tokens[index] == "" {
                        
                        //debug
                        print("[\(Methods.basename(#file)):\(#line)] tokens[\(index)] => blank")

                        continue
                        
                    }
                    
                    // '-' directive
                    if String(tokens[index].characters.first!) == "-" {
                        
//                        query += " AND NOT title CONTAINS '\(tokens[index])'"
                        query += " AND NOT title CONTAINS '\(tokens[index][tokens[index].startIndex.advancedBy((1))..<tokens[index].startIndex.advancedBy(tokens[index].characters.count)])'"

                     
                    } else {

                        query += " AND title CONTAINS '\(tokens[index])'"
                        
                    }
                    
//                    query += " AND title CONTAINS '\(tokens[index])'"
                    
                }
                
//                //debug
//                print("[\(Methods.basename(#file)):\(#line)] query => \(query)")
                
                //                let aPredicate = NSPredicate(query)
                //                aPredicate = query
                //                aPredicate = NSPredicate(query)
                aPredicate = NSPredicate(format: query)
                
            } else {
                
                aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
                
            }
            
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] query => \(query)")
            
            
//            aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
            
            //            dataArray = try! Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)
            //ref https://www.hackingwithswift.com/new-syntax-swift-2-error-handling-try-catch
            do {
                
                dataArray = try Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)
                
//                //debug
//                print("[\(Methods.basename(#file)):\(#line)] dataArray.description => \(dataArray.description)")
//                
                
            } catch is NSException {
                
                //debug
                print("[\(Methods.basename(#file)):\(#line)] NSException => \(NSException.description())")
                
                //ref https://www.bignerdranch.com/blog/error-handling-in-swift-2/
            } catch let error as NSError {
                
                //debug
                //                print("[\(Methods.basename(#file)):\(#line)] NSError => \(NSException.description())")  //=> build succeeded
                print("[\(Methods.basename(#file)):\(#line)] NSError => \(error.description)")  //=> build succeeded
                
            }
            
        }//if tmp_s == ""
        
        
//        // convert Results<Diary> => Array<Diary>
//        _conv_Results_2_Array__Diaries()
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] dataArray => \(String(dataArray.count))")

    }//_test_Realm_Conditions__MultipleKeywords
    
    func _conv_Results_2_Array__Diaries() -> Void {
        
        aryOf_Diaries = [Diary]()
        
        for i in dataArray {
            
            aryOf_Diaries.append(i)
            
        }
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] dataArray.count => \(dataArray.count) / aryOf_Diaries.count => \(aryOf_Diaries.count)")
        
        
    }//_conv_Results_2_Array__Diaries
    
    
    func _build_DataArray__With_Keywords(tmp_s : String) -> Void {
        
        var query = _build_DataArray__With_Keywords__Build_Query(tmp_s);
        
        // validate
        if (query == "multiple") {
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] query => multiple")

    //            query = ""
                
//            var aPredicate = NSPredicate(format: query)
        
            //ref https://www.hackingwithswift.com/new-syntax-swift-2-error-handling-try-catch
            do {

                // count the total
                dataArray_3 = try Realm().objects(Diary).sorted("created_at", ascending: false)

                
                dataArray_2 = try Realm().objects(Diary).sorted("created_at", ascending: false)

//                dataArray_2 = try Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)
                
                //                //debug
                //                print("[\(Methods.basename(#file)):\(#line)] dataArray.description => \(dataArray.description)")
                //
                
                
                /*
                 *  filter
                 */
                // tokens
                let tokens = tmp_s.componentsSeparatedByString(" ")
                
                // new array
//                var aryOf_Diaries__2 = [Diary]()
                
                /*
                 
                    20160510 121847
                 
                    concern:
                        title= "abc", body="def"
                        --> whole="abc def"
                        --> if a token is " d"
                            => then, flag stays true
                            => whereas, neither title nor body
                                contains a string " d"
                    note to the concern:
                        tmp_s is sliced with the char " "
                        --> hence, tokens don't contain any char " "
 
                */
                
                // loop => build: aryOf_Diaries__2
                self.aryOf_Diaries__2.removeAll()
                
                for diary in dataArray_2 {
                    
                    let whole_string = "\(diary.title) \(diary.body)"
                    
                    var flag_contains = true
                    var flag_passed = true
                    
                    for token in tokens {
                        
                        let first_char = String(token.characters.first!)// == "-"
                        
                        
                        if (first_char == "-") {
                        
                            let target = token[token.startIndex.advancedBy((1))..<token.startIndex.advancedBy(token.characters.count)]
                            
                            if (whole_string.containsString(target) == true) {
                                
                                flag_passed = false
                                
                                break
                                
                            }
                            
                        } else {//if (first_char == "-")
                            
                            let target = token

                            if (whole_string.containsString(target) == false) {
                                
                                flag_passed = false
                                
                                break
                                
                            }

                            
                        }//if (first_char == "-")
                        
                        
//                        // judge
//                        if !(whole_string.containsString(token)) {
//                            
//                            flag_contains = false
//                            
//                            break
//                            
//                        }
                        
                    }//for token in tokens
                    
                    // if contains all --> push to a new array
//                    if (flag_contains == true) {
                    if (flag_passed == true) {

                    
                        //debug
//                        print("[\(Methods.basename(#file)):\(#line)] flag_contains => true (\(diary.title) [\(diary.body)])")
                        print("[\(Methods.basename(#file)):\(#line)] flag_passed => true (\(diary.title) [\(diary.body)])")


                        
                        aryOf_Diaries__2.append(diary)
                        
                    }
                    
                    
                }//for diary in dataArray
                
                //debug
                print("[\(Methods.basename(#file)):\(#line)] aryOf_Diaries__2.count => \(aryOf_Diaries__2.count)")
                
                
            } catch is NSException {
                
                //debug
                print("[\(Methods.basename(#file)):\(#line)] NSException => \(NSException.description())")
                
                //ref https://www.bignerdranch.com/blog/error-handling-in-swift-2/
            } catch let error as NSError {
                
                //debug
                //                print("[\(Methods.basename(#file)):\(#line)] NSError => \(NSException.description())")  //=> build succeeded
                print("[\(Methods.basename(#file)):\(#line)] NSError => \(error.description)")  //=> build succeeded
                
            }

        }
        
        else if (query == "") {
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] query => ''(blank)")
            
            
//            var aPredicate = NSPredicate(format: query)
            
            //ref https://www.hackingwithswift.com/new-syntax-swift-2-error-handling-try-catch
            do {
                
                // count the total
                dataArray_3 = try Realm().objects(Diary).sorted("created_at", ascending: false)
                
                
                dataArray_2 = try Realm().objects(Diary).sorted("created_at", ascending: false)
                
                // loop => build: aryOf_Diaries__2
                self.aryOf_Diaries__2.removeAll()
                
                for diary in self.dataArray_2 {
                    
                    self.aryOf_Diaries__2.append(diary)
                    
                }//for diary in dataArray
                
                
                
            } catch is NSException {
                
                //debug
                print("[\(Methods.basename(#file)):\(#line)] NSException => \(NSException.description())")
                
                //ref https://www.bignerdranch.com/blog/error-handling-in-swift-2/
            } catch let error as NSError {
                
                //debug
                //                print("[\(Methods.basename(#file)):\(#line)] NSError => \(NSException.description())")  //=> build succeeded
                print("[\(Methods.basename(#file)):\(#line)] NSError => \(error.description)")  //=> build succeeded
                
            }

        }//if (query == "multiple")
        
        else {//if (query == "multiple")

            //debug
            print("[\(Methods.basename(#file)):\(#line)] query => NOT multiple ('\(query)')")

            
            var aPredicate = NSPredicate(format: query)
            
            //ref https://www.hackingwithswift.com/new-syntax-swift-2-error-handling-try-catch
            do {
                
                // count the total
                dataArray_3 = try Realm().objects(Diary).sorted("created_at", ascending: false)

                
                dataArray_2 = try Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)
                
                // loop => build: aryOf_Diaries__2
                self.aryOf_Diaries__2.removeAll()
                
                for diary in self.dataArray_2 {
                    
                    self.aryOf_Diaries__2.append(diary)
                    
                }//for diary in dataArray
                

                
            } catch is NSException {
                
                //debug
                print("[\(Methods.basename(#file)):\(#line)] NSException => \(NSException.description())")
                
                //ref https://www.bignerdranch.com/blog/error-handling-in-swift-2/
            } catch let error as NSError {
                
                //debug
                //                print("[\(Methods.basename(#file)):\(#line)] NSError => \(NSException.description())")  //=> build succeeded
                print("[\(Methods.basename(#file)):\(#line)] NSError => \(error.description)")  //=> build succeeded
                
            }

        }//if (query == "multiple")
        

        //debug
        print("[\(Methods.basename(#file)):\(#line)] query => \(query)")

        //debug
        print("[\(Methods.basename(#file)):\(#line)] dataArray.count => \(dataArray.count) / dataArray_2.count => \(dataArray_2.count) / self.aryOf_Diaries__2.count => \(self.aryOf_Diaries__2.count) / toal => \(self.dataArray_3.count)")

        
        
    }//_build_DataArray__With_Keywords
    
    func _build_DataArray__With_Keywords__Build_Query(tmp_s : String) -> String {
        
        var query = ""
        
        //debug
        if tmp_s == "" {
            
            // if the default is "" --> no filter
//            dataArray = try! Realm().objects(Diary).sorted("created_at", ascending: false)
            
            // set => blank
            query = ""
            
        } else if tmp_s == "@@@" {//if tmp_s == ""
            
            query = "title == ''"
        
        } else {//if tmp_s == ""
            
            let tokens = tmp_s.componentsSeparatedByString(" ")
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] tokens.count => \(tokens.count)")
            
            //debug
            for item in tokens {
                
                print("item = '\(item)'")
                
            }

            // build query
            query = "multiple keywords"
            
            // search memo, too?
            // defaults
            let defaults = NSUserDefaults.standardUserDefaults()
            
            let dfltVal_Search_MemoColumn = defaults.valueForKey(CONS.defaultKeys.key_Search_MemoColumn)

            //debug
//            print("[\(Methods.basename(#file)):\(#line)] dfltVal_Search_MemoColumn => \(dfltVal_Search_MemoColumn?.description)")
            print("[\(Methods.basename(#file)):\(#line)] dfltVal_Search_MemoColumn => \(dfltVal_Search_MemoColumn?.boolValue)")

            // target string
//            let string_less_NegDirective = tmp_s[tmp_s.startIndex..<tmp_s.startIndex.advancedBy(tmp_s.characters.count - 1)]
            let string_less_NegDirective = tmp_s[tmp_s.startIndex.advancedBy(1)..<tmp_s.startIndex.advancedBy(tmp_s.characters.count)]

            print("[\(Methods.basename(#file)):\(#line)] string_less_NegDirective => \(string_less_NegDirective)")

            
            if tokens.count == 1 {
                
                let first_char = tmp_s.characters.first!
                
//                if String(tmp_s.characters.first!) == "-" {
                if String(first_char) == "-" {
                
                    if (dfltVal_Search_MemoColumn?.boolValue == true) {
                    
                        query = "NOT title CONTAINS '\(string_less_NegDirective)' AND NOT body CONTAINS '\(string_less_NegDirective)'"
                        
                    } else {
                        
                        query = "NOT title CONTAINS '\(string_less_NegDirective)'"
                        
                    }
                    
                    print("[\(Methods.basename(#file)):\(#line)] NOT directive")
                    
                } else {//if String(first_char) == "-"
                    
                    if (dfltVal_Search_MemoColumn?.boolValue == true) {
                        
//                        query = "title CONTAINS \(string_less_NegDirective) OR body CONTAINS \(string_less_NegDirective)"
                        query = "title CONTAINS '\(tokens[0])' OR body CONTAINS '\(tokens[0])'"
                        
                    } else {
                        
                        query = "title CONTAINS '\(tokens[0])'"
                        
                    }
                    
                    print("[\(Methods.basename(#file)):\(#line)] OR directive")
                    
                }//if String(first_char) == "-"
                
//                //debug
//                print("[\(Methods.basename(#file)):\(#line)] predicate => built")
                
            } else {//if tokens.count == 1
                
                //test
//                query = "tokens.count > 1"
                query = "multiple"
                
            }//if tokens.count == 1
            
        }//if tmp_s == ""
        
        
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] query => '\(query)'")
        
        
//        //test
//        let aPredicate = NSPredicate(format: query)
//        title CONTAINS
//        
//        let tmp_ary = try Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)

        
        // return
//        return "abc"
        return query
        
    }//_build_DataArray__With_Keywords__Build_Query
    
    func _test_Realm_Conditions(tmp_s : String) -> Void {
        
//        let aPredicate = NSPredicate(format: "color = %@ AND name BEGINSWITH %@", "red", "BMW")
//        redCars = realm.objects(Car).filter(aPredicate)
//        let aPredicate = NSPredicate(format: "title LIKE %@", tmp_s)
        
//        //debug: defaults string => force to be "" (blank)
//        tmp_s = ""
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] tmp_s => forced to be ''")

        //debug
//        if true     {
        if tmp_s == "" {
        
            // if the default is "" --> no filter
            dataArray = try! Realm().objects(Diary).sorted("created_at", ascending: false)

            
        } else {

            let tokens = tmp_s.componentsSeparatedByString(" ")
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] tokens.count => \(tokens.count)")
            
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
            print("[\(Methods.basename(#file)):\(#line)] query => \(query)")

            
            aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)

//            dataArray = try! Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)
            //ref https://www.hackingwithswift.com/new-syntax-swift-2-error-handling-try-catch
            do {

                dataArray = try Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)

            } catch is NSException {
                
                //debug
                print("[\(Methods.basename(#file)):\(#line)] NSException => \(NSException.description())")
                
            //ref https://www.bignerdranch.com/blog/error-handling-in-swift-2/
            } catch let error as NSError {
                
                //debug
//                print("[\(Methods.basename(#file)):\(#line)] NSError => \(NSException.description())")  //=> build succeeded
                print("[\(Methods.basename(#file)):\(#line)] NSError => \(error.description)")  //=> build succeeded
                
                
                
            }
            
//            dataArray = try! Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)

        }
        
//        let aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
        
//        redCars = realm.objects(Car).filter(aPredicate)
        
//        dataArray = try! Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)
//        let dataArray_2 = try! Realm().objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)
        
        //debug
//        print("[\(Methods.basename(#file)):\(#line)] dataArray_2 => \(String(dataArray_2.count))")
        print("[\(Methods.basename(#file)):\(#line)] dataArray => \(String(dataArray.count))")
        
    }//_test_Realm_Conditions(tmp_s : String) -> Void
    
// MARK: segue-related
    // segue で画面遷移するに呼ばれる
    override func prepareForSegue
    (segue: UIStoryboardSegue, sender: AnyObject?){

        // sandbox segue?
        if segue.identifier == "sandboxSegue" {
            
        } else if segue.identifier == "segue_Navi_2_Preference" {
        
        } else if segue.identifier == "segue_VC_2_Map" {

            //debug
            print("[\(Methods.basename(#file)):\(#line)] segueing to => segue_VC_2_Map")
        
        } else if segue.identifier == "segue_VC_2_LocList" {
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] segueing to => segue_VC_2_LocList")
            
        } else {
        
        
            let inputViewController:InputViewController = segue.destinationViewController as! InputViewController
        
            if segue.identifier == "cellSegue" {
                
                let indexPath = self.tableView.indexPathForSelectedRow
                
//                inputViewController.diary = dataArray[indexPath!.row]
                inputViewController.diary = self.aryOf_Diaries[indexPath!.row]
                
                
            } else {
                let diary = Diary()
//                diary.title = "タイトル"
//                diary.body = "本文"
                                diary.title = ""
                                diary.body = ""

                if dataArray.count != 0 {
                        diary.id = dataArray.max("id")! + 1
                }
            
                //debug
                print("[\(Methods.basename(#file)):\(#line)] setting diary...")
                
                inputViewController.diary = diary
            }
            
        }//if segue.identifier == "sandboxSegue"
        
    }
    
    // MARK: UITableViewDataSource プロトコルのメソッド
    // TableView の各セクションのセルの数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return dataArray.count
        return self.numOf_Cells
        
    }
    
    // 各セルの内容を返す
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        // Cellに値を設定する.
//        let object = dataArray[indexPath.row]
        let object = aryOf_Diaries[indexPath.row]
        
        
        
        cell.textLabel?.text = object.title
        
        // text colors
//        cell.detailTextLabel?.textColor = CONS.COLORS.gray_050505
        cell.detailTextLabel?.textColor = CONS.COLORS.gray_030303
        
        // date
//        let currentDate = NSDate()
        
        // bg color
        _tableView__Set_BGColor(cell, object: object)

        _tableView__Set_BGColor_Yesterday(cell, object: object)

        _tableView__Set_BGColor_2DaysAgo(cell, object: object)
        
        return cell
    }//tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)

    func _tableView__Set_BGColor_2DaysAgo
    (cell : UITableViewCell, object : Diary) -> Void {
            
            //ref http://www.appcoda.com/nsdate/
//            let ns_CurrentDate = object.date
        let ns_CurrentDate = object.created_at
        
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

            // 2 days ago
            let ns_Date_2DaysAgo = Methods.get_Date_BeforeAfter_ByDate(ns_Date_Today, diff: -2)
            
            
            let s_DateLabel_2DaysAgo = dateFormatter.stringFromDate(ns_Date_2DaysAgo)
            
            let s_DayLabel_2DaysAgo = Methods.get_Date(s_DateLabel_2DaysAgo)
        
            // this week
            let ns_Date_ThisWeek = Methods.get_Date_BeforeAfter_ByDate(ns_Date_Today, diff: -7)
            
            
            let s_DateLabel_ThisWeek = dateFormatter.stringFromDate(ns_Date_ThisWeek)
            
            let s_DayLabel_ThisWeek = Methods.get_Date(s_DateLabel_ThisWeek)
        

            // X days ago
            //            let diff = -5
            
            //            let ns_Date_XDaysAgo = Methods.get_Date_BeforeAfter_ByDate(ns_Date_Today, diff: diff)
            
            
            //            let s_DateLabel_XDaysAgo = dateFormatter.stringFromDate(ns_Date_XDaysAgo)
            
            //            //debug
            //            print("[\(Methods.basename(#file)):\(#line)] dateLabel_Diary => '\(s_DateLabel_Diary)' *** dateLabel_Now => '\(s_DateLabel_Today)' *** yesterday => '\(s_DateLabel_Yesterday)' *** \(diff) days ago => '\(s_DateLabel_XDaysAgo)'")
            
            // change bg color
            if s_DateLabel_Diary >= s_DayLabel_Today {
                
                //                cell.backgroundColor = CONS.col_green_071000
                
            } else if s_DateLabel_Diary >= s_DayLabel_Yesterday {
                
                //                cell.backgroundColor = CONS.col_Blue_020510
//                cell.backgroundColor = CONS.col_Blue_020710
                
            } else if s_DateLabel_Diary >= s_DayLabel_2DaysAgo {
                
                //                cell.backgroundColor = CONS.col_Blue_020510
                cell.backgroundColor = CONS.COLORS.purple_080008
                
            } else if s_DateLabel_Diary >= s_DayLabel_ThisWeek {
                
                //                cell.backgroundColor = CONS.col_Blue_020510
                cell.backgroundColor = CONS.COLORS.gray_080808
                
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
            //                    //                print("[\(Methods.basename(#file)):\(#line)] time_Diary (\(time_Diary)) >= 12")
            //
            //                    cell.backgroundColor = CONS.col_green_071000
            //
            //                } else {
            //
            //                    //                print("[\(Methods.basename(#file)):\(#line)] time_Diary (\(time_Diary)) < 12")
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
//        // supplement text
//        let title = object.title
//        
//        //ref http://stackoverflow.com/questions/29575140/string-length-in-swift-1-2-and-swift-2-0 answered Apr 11 '15 at 7:18
//        let len = title.characters.count
//        
//        if len > CONS.General.limitLen_CellText {
//            
                //ref http://stackoverflow.com/questions/32575227/swift-2-0-substringwithrange answered Sep 15 '15 at 2:30
//            cell.detailTextLabel?.text = "\(convertedDate)"
//            myString[myString.startIndex..<myString.startIndex.advancedBy(3)]
//            
//        } else {
//
//            cell.detailTextLabel?.text = convertedDate
//            
//        }
        
        
        cell.detailTextLabel?.text = convertedDate
        
        // bg color
        //        let date_Today = dateFormatter.stringFromDate(NSDate())
        let tmp_s = dateFormatter.stringFromDate(NSDate())
        
        //        let date_Today = Methods.get_Date(dateFormatter.stringFromDate(NSDate()))
        let date_Today = Methods.get_Date(tmp_s)
//        let time_Today = Methods.get_Time(tmp_s)
        
        let date_Diary = Methods.get_Date(convertedDate)
        let time_Diary = Methods.get_Time(convertedDate)
        
        //        if currentDate <
        
        //ref http://stackoverflow.com/questions/30679701/ios-swift-how-to-change-background-color-of-table-view
        //        cell.backgroundColor = UIColor.clearColor()
        
        
        if date_Diary >= date_Today {
            
            // if the date is today
            // if before noon
            if time_Diary >= "12" {
                
                //                print("[\(Methods.basename(#file)):\(#line)] time_Diary (\(time_Diary)) >= 12")
                
                cell.backgroundColor = CONS.col_green_071000
                
            } else {
                
                //                print("[\(Methods.basename(#file)):\(#line)] time_Diary (\(time_Diary)) < 12")
                
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
//            let ns_CurrentDate = object.date
            let ns_CurrentDate = object.created_at
            
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
//            let diff = -5
            
//            let ns_Date_XDaysAgo = Methods.get_Date_BeforeAfter_ByDate(ns_Date_Today, diff: diff)
            
            
//            let s_DateLabel_XDaysAgo = dateFormatter.stringFromDate(ns_Date_XDaysAgo)
            
//            //debug
//            print("[\(Methods.basename(#file)):\(#line)] dateLabel_Diary => '\(s_DateLabel_Diary)' *** dateLabel_Now => '\(s_DateLabel_Today)' *** yesterday => '\(s_DateLabel_Yesterday)' *** \(diff) days ago => '\(s_DateLabel_XDaysAgo)'")

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
//                    //                print("[\(Methods.basename(#file)):\(#line)] time_Diary (\(time_Diary)) >= 12")
//                    
//                    cell.backgroundColor = CONS.col_green_071000
//                    
//                } else {
//                    
//                    //                print("[\(Methods.basename(#file)):\(#line)] time_Diary (\(time_Diary)) < 12")
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

            //debug
            print("[\(Methods.basename(#file)):\(#line)] deleteing cell...")

            try! realm.write {
                
                //debug
                print("[\(Methods.basename(#file)):\(#line)] realm process => started")

                self.realm.delete(self.dataArray[indexPath.row])

                //debug
                print("[\(Methods.basename(#file)):\(#line)] realm.delete => done")

                // update -> numOf_Cells
                self.numOf_Cells -= 1
                
                // validate
                if self.numOf_Cells < 0 {
                    
                    self.numOf_Cells = 0
                    
                }

                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)

                //debug
                print("[\(Methods.basename(#file)):\(#line)] row => deleted")

//                // update -> numOf_Cells
//                self.numOf_Cells -= 1
//                
//                // validate
//                if self.numOf_Cells < 0 {
//                    
//                   self.numOf_Cells = 0
//                    
//                }

                //debug
                print("[\(Methods.basename(#file)):\(#line)] realm process => ended")

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

// MARK: experiments
    @IBAction func experiments(sender: UIBarButtonItem) {

//        _experiments__Get_LastBackupAt()
        
//        _experiments__RegEx_Matching()
        
//        _experiments__UIAlert()
        _experiments__Choices()
        
    }
    
    func _experiments__Choices() {
        
//        let s_title = "Choices"
        let s_title = "Experiments"
        
        let choice_0 = "Cancel"
        
        let choice_1 = "(1) Show realm files list"
        let choice_2 = "(2) Delete csv files"
//        let choice_3 = "(3) Send email"
        let choice_4 = "(4) Copy db (Diary)"

//        let choice_5 = "(5) Update Data"
//        let choice_5 = "(5) Re-create: realm.data.realm"


        let choice_6 = "(6) backup realm files"
        let choice_7 = "(7) show backup files"
        let choice_8 = "(8) Delete backup files"

        let choice_9 = "(9) Show camera roll files"
        
//        let choice_9 = "(9) Map"
        
//        let s_message = "(1) show realm files list (2) B (3) C"
//        let s_message = "\(choice_1) \(choice_2) \(choice_3)"
//        let s_message = "\(choice_1) \(choice_2) \(choice_3) \(choice_4) \(choice_6) \(choice_7)\n \(choice_8) \(choice_0)"
//        let s_message = "\(choice_1)\n\(choice_2)\n\(choice_3)\n\(choice_4)\n\(choice_6)\n\(choice_7)\n\(choice_8)"
        let s_message = "what do you wanna do ?"
        
        let refreshAlert = UIAlertController(title: s_title, message: s_message, preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: choice_0, style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] chosen => 0")
            
            // execute  => close dialog
            
            
        }))
        

        refreshAlert.addAction(UIAlertAction(title: choice_1, style: .Default, handler: { (action: UIAlertAction!) in

            //debug
            print("[\(Methods.basename(#file)):\(#line)] chosen => 1")
         
            // start function
            self._experiments__Choices__1()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: choice_2, style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] chosen => 2")
            
            // start function
            self._experiments__Choices__2()
            
        }))
        
//        refreshAlert.addAction(UIAlertAction(title: choice_3, style: .Default, handler: { (action: UIAlertAction!) in
//            
//            //debug
//            print("[\(Methods.basename(#file)):\(#line)] chosen => 3")
//
//            // start function
//            self._experiments__Choices__3()
//
//        }))

        refreshAlert.addAction(UIAlertAction(title: choice_4, style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] chosen => 4")
            
            // start function
            self._experiments__Choices__4()
            
        }))

//        refreshAlert.addAction(UIAlertAction(title: "5", style: .Default, handler: { (action: UIAlertAction!) in
//            
//            //debug
//            print("[\(Methods.basename(#file)):\(#line)] chosen => 5")
//            
//            // start function
//            self._experiments__Choices__5()
//            
//        }))
//        

        refreshAlert.addAction(UIAlertAction(title: choice_6, style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] chosen => 6")
            
            // start function
            self._experiments__Choices__6()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: choice_7, style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] chosen => 7")
            
            // start function
            self._experiments__Choices__7()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: choice_8, style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] chosen => 8")
            
            // start function
            self._experiments__Choices__8()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: choice_9, style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] chosen => 9")
            
            // start function
            self._experiments__Choices__9()
            
        }))
        
        // show view
        presentViewController(refreshAlert, animated: true, completion: nil)
        
    }
    
    func _experiments__Choices__1() {
    
        // show list
        Methods.show_DirList__RealmFiles()
        
    }
    
    func _experiments__Choices__2() {
        
        // confirm
        let s_title = "!!!"
        
        let choice_1 = "Delete csv files?"
//        let choice_2 = "(2) Delete csv files\n"
//        let choice_3 = "(3) Send email"
        
        //        let s_message = "(1) show realm files list (2) B (3) C"
//        let s_message = "\(choice_1) \(choice_2) \(choice_3)"
        let s_message = "\(choice_1)"
        
        let refreshAlert = UIAlertController(title: s_title, message: s_message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let lbl_Choice_1 = "OK"
        let lbl_Choice_2 = "Cancel"
        
        refreshAlert.addAction(UIAlertAction(title: lbl_Choice_1, style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] chosen => 1")
            
            // start function
            self._experiments__Choices__2__OK()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: lbl_Choice_2, style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] chosen => 2")
            
            // start function
//            self._experiments__Choices__2__OK()
            
        }))
        

        // show view
        presentViewController(refreshAlert, animated: true, completion: nil)
        
//        // delete files
//        Methods.delete_Diary_CSVFiles()
        
    }
    
    func _experiments__Choices__2__OK() {

        // delete files
        Methods.delete_Diary_CSVFiles()

    }
    
    func _experiments__Choices__3() {
        
        // show list
//        Methods.delete_Diary_CSVFiles()

        self.backupDiaries_ViaEmail__Delegate()
        
    }
    
    func _experiments__Choices__4() {

        Proj.copy_DB__Diaries__FromDefault(CONS.s_Realm_FileName__Admin)
        
    }
    
    func _experiments__Choices__5() {
        
        let tmp_s = "2016/01/01 00:00:00"
        
//        self.updateData_Data__Latest_Diary_at(tmp_s)
        self.insertData_Data_Latest_Diary_at(tmp_s)
        
    }

    func _experiments__Choices__6() {

        Methods.backup_RealmFiles(CONS.s_Realm_FileName__Admin)
        
    }
    
    func _experiments__Choices__7() {
        
        Methods.show_DirList__BackupFiles()
        
    }
    
    func _experiments__Choices__8() {
        
        // confirm
        let s_title = "!!!"
        
        let choice_1 = "Delete backup files?"

        let s_message = "\(choice_1)"
        
        let refreshAlert = UIAlertController(title: s_title, message: s_message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let lbl_Choice_1 = "OK"
        let lbl_Choice_2 = "Cancel"
        
        refreshAlert.addAction(UIAlertAction(title: lbl_Choice_1, style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] chosen => 1")
            
            // start function
            self._experiments__Choices__8__OK()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: lbl_Choice_2, style: .Default, handler: { (action: UIAlertAction!) in
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] chosen => 2")
            
            // start function
            //            self._experiments__Choices__2__OK()
            
        }))
        
        
        // show view
        presentViewController(refreshAlert, animated: true, completion: nil)
        
    }

    func _experiments__Choices__8__OK() {
        
        // delete files
        Methods.delete_Realm_BackupFiles()
        
    }

    func _experiments__Choices__9() {

        // list
        let assets = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
        
        var results = Array<AnyObject>()
        
        assets.enumerateObjectsUsingBlock { (obj, idx, bool) -> Void in
            
            results.append(obj)
            
        }
        
        //debug
        if results.count > 0 {

            if results.count < 3 {
                
    //            let ast = results[0] as! PHAsset
                let ast = results.last as! PHAsset
                
                print("[\(Methods.basename(#file)):\(#line)] results.last => \(ast.description)")
                
                print("results.count => \(results.count)")
                    //results.count => 229
                
              
                print("results.last.mediaSubtypes => \(ast.mediaSubtypes)")
                    //            PHAssetMediaSubtype(rawValue: 0)
                
                print("ast.location?.description => \(ast.location?.description)")
                    //            Optional("<+35.33013833,+139.35009667> +/- 0.00m (speed 0.00 mps / course 159.75) @ 2001/01/01 9時00分00秒 日本標準時")

                print("ast.pixelHeight => \(ast.pixelHeight)")
                
            } else  {
            
//                for var i = 0; i < 3; i++ {
                for i in 0 ..< 3 {

                    let ast = results[i] as! PHAsset
                    
                    print("[\(Methods.basename(#file)):\(#line)] results[\(i)] => \(ast.description)")
                        //                    results[2] => <PHAsset: 0x1511b2bc0> CB40E44D-F630-4CD3-8256-4B603888EF75/L0/001 mediaType=1/0, sourceType=1, (4032x3024), creationDate=2016-02-16 08:57:48 +0000, location=1, hidden=0, favorite=0
                    
                    print("results.count => \(results.count)")
                        //results.count => 229
                    
                    
                    print("results.last.mediaSubtypes => \(ast.mediaSubtypes)")
                        //            PHAssetMediaSubtype(rawValue: 0)
                    
                    print("ast.location?.description => \(ast.location?.description)")
                        //            Optional("<+35.33013833,+139.35009667> +/- 0.00m (speed 0.00 mps / course 159.75) @ 2001/01/01 9時00分00秒 日本標準時")
                    
                    print("ast.pixelHeight => \(ast.pixelHeight) / ast.pixelWidth => \(ast.pixelWidth)")
                    //                    ast.pixelHeight => 3024 / ast.pixelWidth => 4032
                    
                    //ref
                    var retimage = UIImage()

                    let manager = PHImageManager.defaultManager()
                    
//                    manager.requestImageForAsset(ast, targetSize: CGSize(width: ast.pixelWidth, height: ast.pixelHeight), contentMode: .AspectFit, options: nil, resultHandler: {
//                    manager.requestImageForAsset(ast, targetSize: CGSize(width: ast.pixelWidth, height: ast.pixelHeight), contentMode: .AspectFill, options: nil, resultHandler: {
//                    manager.requestImageForAsset(ast as PHAsset, targetSize: CGSize(width: ast.pixelWidth, height: ast.pixelHeight), contentMode: PHImageContentMode.AspectFill, options: nil, resultHandler: {
                    
//                    let w = 200
//                    let h = 200
                    let w = 200 as CGFloat
                    let h = 200 as CGFloat
                    
                    manager.requestImageForAsset(ast as PHAsset, targetSize: CGSize(width: w, height: h), contentMode: PHImageContentMode.AspectFill, options: nil, resultHandler: {
                    
                        (result, info)->Void in
                        
                        retimage = result!
//                        println("This happens after")
//                        println(retimage)
//                        callReturnImage(retimage) // <- create this method
                        
                    })
                    
                    print("image => \(retimage.description)")

                    // save image
                    UIImageWriteToSavedPhotosAlbum(retimage, nil, nil, nil)
//
//                    print("image saved to => camera roll")
                    
                    print("")
                    
                }
                
            }
            
        } else {

            print("[\(Methods.basename(#file)):\(#line)] results => =< 0")

        }

        
        // segue
        self.performSegueWithIdentifier("segue_VC_2_Map", sender: nil)

    }
    

    func _experiments__UIAlert() {
    
        //ref http://stackoverflow.com/questions/25511945/swift-alert-view-ios8-with-ok-and-cancel-button-which-button-tapped answered Aug 26 '14 at 17:51
        // ref handler http://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift answered Jun 3 '14 at 18:48
        let refreshAlert = UIAlertController(title: "Refresh", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] clicked => Ok button")

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
            print("[\(Methods.basename(#file)):\(#line)] fpath_full => \(fpath_full)")
            
            //        //debug
            //        print("[\(Methods.basename(#file)):\(#line)] tokens.count => \(tokens.count)")
            
            
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
                print("[\(Methods.basename(#file)):\(#line)] res => \(res)")
                
            } else {
                
                //debug
                print("[\(Methods.basename(#file)):\(#line)] content => nil")

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
        print("[\(Methods.basename(#file)):\(#line)] fpath_full => \(fpath_full)")

//        //debug
//        print("[\(Methods.basename(#file)):\(#line)] tokens.count => \(tokens.count)")
        
        
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
                print("[\(Methods.basename(#file)):\(#line)] tokens.count => \(tokens.count)")

            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] tokens[0] => \(tokens[0])")

//            }
            
        } else {

            //debug
            print("[\(Methods.basename(#file)):\(#line)] content => nil")

        }
        
//        let tokens = content.componentsSeparatedByString("\n")
        
        
        
//        //debug
//        print("[\(Methods.basename(#file)):\(#line)] tokens.count => \(tokens.count)")

        
//        let tokens = content        
//        let tokens = lines.componentsSeparatedByString("\n")
        
//        //debug
//        print("[\(Methods.basename(#file)):\(#line)] tokens.count => \(tokens.count)")

    }
    
// MARK: backup diaries
    @IBAction func backupDiaries_ViaEmail
    (sender: UIBarButtonItem) {
      
        //        let s_title = "Choices"
        let s_title = "Features"

        let s_message = "see what you can do"
        
        let choice_0 = "Cancel"
        
        let choice_1 = "(1) send data via email"
        let choice_2 = "(2) Map"
        let choice_3 = "(3) Photo"

        let choice_4 = "(4) Loc list"

        // controller
        let refreshAlert = UIAlertController(title: s_title, message: s_message, preferredStyle: UIAlertControllerStyle.Alert)
        
        /*
            choices
        */
        // choice 0
        refreshAlert.addAction(UIAlertAction(title: choice_0, style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: choice_1, style: .Default, handler: { (action: UIAlertAction!) in
            
            // start function
            self.backupDiaries_ViaEmail__Ok()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: choice_2, style: .Default, handler: { (action: UIAlertAction!) in

            // start map
//            self._experiments__Choices__9()
            self._start_Map()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: choice_3, style: .Default, handler: { (action: UIAlertAction!) in
            
            // start map
            self.backupDiaries_ViaEmail__Choice_3()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: choice_4, style: .Default, handler: { (action: UIAlertAction!) in
            
            // start map
            self.backupDiaries_ViaEmail__Choice_4()
            
        }))
        
        // show view
        presentViewController(refreshAlert, animated: true, completion: nil)
        
    }

    func _start_Map() {
    
        // segue
        self.performSegueWithIdentifier("segue_VC_2_Map", sender: nil)

        
    }
    
    func backupDiaries_ViaEmail__Delegate() {
        
        let title = "Send data via email"
        let message = "Diary data in csv format"
        
        //        var refreshAlert = UIAlertController(title: "Refresh", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.Alert)
        let refreshAlert = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] clicked => Ok button")
            
            // start email
            self.backupDiaries_ViaEmail__Ok()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] experiments")
        
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
        print("[\(Methods.basename(#file)):\(#line)] fpath_full => \(fpath_full)")
        
        // build => CSV
        //        _experiments__BuildCSV()
        let tmp_i = _experiments__BuildCSV(fpath_full)
        
        // validate
        if tmp_i == -1 {
            
            self.backupDiaries_ViaEmail__Ok__Dlg_NoNewDiaries()
            
            // return
            return;
            
        }
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] CONS.s_Latest_Diary_at => \(CONS.s_Latest_Diary_at)")
        
        
        // email: setup vars
        self.fpath_realm_csv = fpath_full
        self.fname_realm_csv = fname
        
        //        //test
        //        self.mailComposeController__MailSent()
        
        // send email
        _experiments__SendEmails()
        
        //        dataArray = try! Realm().objects(Diary).sorted("created_at", ascending: false)
        
        
        //        // dir list
        //        let ary = Methods.show_DirList__RealmFiles()
    }
    
    func backupDiaries_ViaEmail__Ok__Dlg_NoNewDiaries() {
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] backupDiaries_ViaEmail__Ok => returning...")
        
        let title = "No new Diaries"
        let message = "Quitting the process"
        
        //        var refreshAlert = UIAlertController(title: "Refresh", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.Alert)
        let refreshAlert = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] clicked => Ok button")
            
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
    }
    

    func backupDiaries_ViaEmail__Choice_3() {
        
        // カメラが使えるか確認する
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            
            // ImagePicker を表示する
            let cameraPicker = UIImagePickerController()
            
            cameraPicker.sourceType = UIImagePickerControllerSourceType.Camera
//            cameraPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            cameraPicker.delegate = self
            self.presentViewController(cameraPicker, animated: true, completion: nil)
            
        }
        
    }

    func backupDiaries_ViaEmail__Choice_4() {

        //debug
        print("[\(Methods.basename(#file)):\(#line)] showing loc list...")
        
        // perfom
        performSegueWithIdentifier("segue_VC_2_LocList",sender: nil)
        
    }
    
// MARK: image picker
    func imagePickerController(imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // 画像用の配列にいれる
            imageArray.append(pickedImage)
        }
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] imageArray.count => \(self.imageArray.count)")

        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
        /*
            save image to file
        */
//        //debug
//        print("[\(Methods.basename(#file)):\(#line)] getDocumentsDirectory()! => \(Methods.getDocumentsDirectory())")

//        let doc_root = Methods.getDocumentsDirectory()
//        
//        //ref https://www.hackingwithswift.com/example-code/media/how-to-save-a-uiimage-to-a-file-using-uiimagepngrepresentation
//        let data = UIImagePNGRepresentation(imageArray[0])
//        
//        let fpath = doc_root.stringByAppendingPathComponent("image_\(Methods.get_TimeLabel__Serial()).png")
//        
//        var result = data!.writeToFile(fpath, atomically: true)
//        
//        //debug
//        print("[\(Methods.basename(#file)):\(#line)] result => \(result)")
//        
        // save to camera roll
        //ref http://iostechsolutions.blogspot.jp/2014/11/swift-take-pictures-and-save-to-camera.html
        UIImageWriteToSavedPhotosAlbum(imageArray[0], nil, nil, nil)

//        //debug
//        print("[\(Methods.basename(#file)):\(#line)] UIImageWriteToSavedPhotosAlbum  => done: result => \(result)")

        /*
            save diary
        */
        let realm = try! Realm()
        
        try! realm.write {
            
            let diary_new = Diary()
            
            diary_new.id = Methods.lastId_Diary()

//            let title = "@photo \(Methods.get_TimeLable())"
            let title = "@photo \(Methods.get_TimeLabel__Serial())"
            
            diary_new.title = title
            
            diary_new.body = ""
            
            let time = NSDate()
            
            diary_new.created_at = time
            diary_new.date = time
            
            //            self.realm.add(self.diary, update: false)
            self.realm.add(diary_new, update: true)
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] photo memo => created")

        }

        
    }
    
    // ImagePicker でキャンセルされた場合に呼ばれる
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    
    func _experiments__BuildCSV(fpath_full : String) -> Int {

        /*
            latest diary date
        */
        let tmp_s = Proj.get_LastBackup_Diary_ModifiedAt_String()
        
        //debug0
        print("[\(Methods.basename(#file)):\(#line)] Proj.get_LastBackup_Diary_ModifiedAt_String() => \(tmp_s)")

        
//        let r_admin = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
        
//        let query = "name = \(CONS.s_LatestBackup_Diary_ModifiedAt)"
//        let query = "name == \(CONS.s_LatestBackup_Diary_ModifiedAt)"
//        let query = "name == '\(CONS.s_LatestBackup_Diary_ModifiedAt)'"
        
//        let aPredicate = NSPredicate(format: query)
        
//        let resOf_Data_LatestDiaryAt = try self.realm_admin.objects(Data).filter(aPredicate).sorted("created_at", ascending: false)
//        let resOf_Data_LatestDiaryAt = try! self.realm_admin.objects(Data).filter(aPredicate).sorted("created_at", ascending: false)

//        //debug0
//        print("[\(Methods.basename(#file)):\(#line)] resOf_Data_LatestDiaryAt.count => \(resOf_Data_LatestDiaryAt.count) (\(resOf_Data_LatestDiaryAt.description))")

        //test => lastId
        let tmp_i = Methods.lastId_Data()
        
        //debug0
        print("[\(Methods.basename(#file)):\(#line)] Methods.lastId_Data() => \(tmp_i)")
        
//
//        let tmp = try! self.realm_admin.objects(Data).sorted("created_at", ascending: false)
//        
//        //debug0
//        print("[\(Methods.basename(#file)):\(#line)] tmp.count => \(tmp.count)")
//        
//        let tmp_2 = try! self.realm_admin.objects(Data).sorted("created_at", ascending: false).last
//        
//        //debug0
//        print("[\(Methods.basename(#file)):\(#line)] tmp_2.description (last) => \(tmp_2!.description)")
        
        /*
            get recores
        */
        let r = try! Realm()
        
//        let resOf_Diaries = try! r.objects(Diary).sorted("created_at", ascending: false)
        let resOf_Diaries = r.objects(Diary).sorted("created_at", ascending: false)

        // last upload date
//        var s_last_uploaded_at = Proj.get_LastUploaded_At()
        var s_last_uploaded_at = Proj.get_LastBackup_Diary_ModifiedAt_String()
        
        if s_last_uploaded_at == "-1" {
           
            s_last_uploaded_at = "0000/00/00 00:00:00"
//            s_last_uploaded_at = "2016/02/20 00:00:00"
            
        }

        //debug0
        print("[\(Methods.basename(#file)):\(#line)] s_last_uploaded_at => \(s_last_uploaded_at)")

        // build list of diaries
        var aryOf_Diaries = Array<Diary>()
        
        let lenOf_ResOf_Diaries = resOf_Diaries.count
        
        var i_count = 0
        
        for var i = 0; i < lenOf_ResOf_Diaries; i += 1 {
            
            let d = resOf_Diaries[i]
            
            let modified_at = Methods.conv_NSDate_2_DateString(d.date)

            if modified_at > s_last_uploaded_at {
            
                aryOf_Diaries.append(d)
                
                i_count += 1
                
            }
            
            
            
        }
        
        //debug0
        print("[\(Methods.basename(#file)):\(#line)] resOf_Diaries => \(lenOf_ResOf_Diaries) / aryOf_Diaries.count => \(aryOf_Diaries.count)")

        /*
            validate: any new Diary instance?
        
            @return
            -1      "aryOf_Diaries.count => less than 1"
        */
        if aryOf_Diaries.count < 1 {

            //debug0
            print("[\(Methods.basename(#file)):\(#line)] aryOf_Diaries.count => less than 1 --> qutting the process")

            return -1

        }
        
//        //test
//        let s_time_label = "2016/01/23 12:34:56"
////        let s_time_label = ""
//
//        let s_tmp = Methods.conv_DateString_2_NSDate(s_time_label, format: "yyyy/MM/dd HH:mm:ss")

//        let s_tmp = Methods.conv_DateString_2_NSDate(Methods.conv_NSDate_2_DateString(NSDate()), format: "yyyy/MM/dd HH:mm:ss")
        
//        //debug
//        print("[\(Methods.basename(#file)):\(#line)] time_label => \(s_time_label) *** s_tmp.description => \(s_tmp.description) *** s_tmp(converted) => \(Methods.conv_NSDate_2_DateString(s_tmp))")

        
        
        
//        let s_last_uploaded_at = Proj.get_LastUploaded_At()
        
//        var d = NSDate()
//        
//        d.
//
        
//        let query = "modified_at > \(s_last_uploaded_at)"
//        let query = "date > \(s_tmp)"
//        
//        let aPredicate = NSPredicate(format: query)
//        
//        let resOf_Diaries =  r.objects(Diary).filter(aPredicate).sorted("created_at", ascending: false)

        // latest diary
        let tmp_Diaries = r.objects(Diary).sorted("date", ascending: false)
        let latest_diary = tmp_Diaries[0]
        
        CONS.s_Latest_Diary_at = Methods.conv_NSDate_2_DateString(latest_diary.date)
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] resOf_Diaries.count => \(resOf_Diaries.count)")

        // convert Diaries --> csv : [String]
//        let linesOf_Diaries = Methods.conv_Diaries_2_CSV(resOf_Diaries)
        let linesOf_Diaries = Methods.conv_Diaries_2_CSV(aryOf_Diaries)

        
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
        
        // return
        return 1
        
        
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
        
        //test
        let res = Proj.get_LastUploaded_At()
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] Proj.get_LastUploaded_At::res => \(res)")

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
            
            // address
            mailComposerVC.setToRecipients(["iwabuchi.k.2010@gmail.com"])
            
//            mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
            mailComposerVC.setMessageBody(self.message_email, isHTML: false)
            
            // attach file
            //        if let filePath = NSBundle.mainBundle().pathForResource("swifts", ofType: "wav") {
//            let realmPath = Realm.Configuration.defaultConfiguration.path
            
//            let dpath_realm = Methods.dirname(realmPath!)
            
            //        let fpath_realm = "\(dpath_realm)/\(CONS.s_Realm_FileName)"
//            let fpath_realm = "\(dpath_realm)/realm_data_20160221_093611.csv"
            let fpath_realm = "\(self.fpath_realm_csv)"
            
            //        if let filePath = NSBundle.mainBundle().pathForResource("swifts", ofType: "wav") {
            //        if let filePath = NSBundle.mainBundle().pathForResource(fpath_realm, ofType: "realm") {
//            if let filePath = NSBundle.mainBundle().pathForResource("db_20160220_002443", ofType: "realm") {
//                
//                //debug
//                print("[\(Methods.basename(#file)):\(#line)] path to attached file => \(filePath)")
//                
//                //            print("File path loaded.")
//                
//            } else {
//                
//                //debug
//                print("[\(Methods.basename(#file)):\(#line)] can't generate path => \(fpath_realm)")
//                
//                
//            }
            
            // load data
            //        if let fileData = NSData(contentsOfFile: filePath) {
            if let fileData = NSData(contentsOfFile: fpath_realm) {
                
                //debug
                print("[\(Methods.basename(#file)):\(#line)] data created")
                //            print("[\(Methods.basename(#file)):\(#line)] data created => \(fileData.description)")
                //            println("File data loaded.")
                
                // attach data
                //ref http://kellyegan.net/sending-files-using-swift/
//                mailComposerVC.addAttachmentData(fileData, mimeType: "application/octet-stream", fileName: "realm_data_20160221_093611.csv")
                mailComposerVC.addAttachmentData(fileData, mimeType: "application/octet-stream", fileName: self.fname_realm_csv)
                
            } else {
                
                //debug
                print("[\(Methods.basename(#file)):\(#line)] data created => NOT")
                
            }
            
            
            //        mailComposerVC.a
            
            return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
                let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
                sendMailErrorAlert.show()
    }
    
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] mailComposeController => called")

        //ref http://stackoverflow.com/questions/24311073/mfmailcomposeviewcontroller-in-swift answered Aug 26 '15 at 17:04
        switch result.rawValue {

        case MFMailComposeResultSent.rawValue:
            
            print("Mail sent")
            
            // after sending mail => save latest backup time
            self.mailComposeController__MailSent()
            
            break
            
        case MFMailComposeResultCancelled.rawValue:
            
            print("Mail cancelled")
            
        case MFMailComposeResultSaved.rawValue:
            
            print("Mail saved")
            
            // confirm
            let s_title = "Reminder"
            
            let choice_1 = "last_backup_at => will not be recorded"
            //        let choice_2 = "(2) Delete csv files\n"
            //        let choice_3 = "(3) Send email"
            
            //        let s_message = "(1) show realm files list (2) B (3) C"
            //        let s_message = "\(choice_1) \(choice_2) \(choice_3)"
            let s_message = "\(choice_1)"
            
            let refreshAlert = UIAlertController(title: s_title, message: s_message, preferredStyle: UIAlertControllerStyle.Alert)
            
            let lbl_Choice_1 = "OK"
//            let lbl_Choice_2 = "Cancel"
            
            refreshAlert.addAction(UIAlertAction(title: lbl_Choice_1, style: .Default, handler: { (action: UIAlertAction!) in
                
                //debug
                print("[\(Methods.basename(#file)):\(#line)] chosen => 1")
                
//                // start function
//                self._experiments__Choices__2__OK()
                
                // dismiss view
                self.mailComposeController__DismissView()
                
                
            }))
            
            // show view
//            presentViewController(refreshAlert, animated: true, completion: nil)
            controller.presentViewController(refreshAlert, animated: true, completion: nil)
            
            return
//            break

        case MFMailComposeResultFailed.rawValue:
            print("Mail sent failure: \(error!.localizedDescription)")
        default:
            break
        }
        
        // dismiss view
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func mailComposeController__MailSent() {
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] CONS.s_Latest_Diary_at => \(CONS.s_Latest_Diary_at)")
        
        
        
        /*
            update value
        */

        self.updateData_Data__Latest_Diary_at(CONS.s_Latest_Diary_at)
        
        // get value from csv file => latest_diary_at
        let content = try? String(contentsOfFile: self.fpath_realm_csv, encoding: NSUTF8StringEncoding)
        
//        //test
//        let last_updated = Proj.get_LastUploaded_At()
//        
//        //debug
//        print("[\(Methods.basename(#file)):\(#line)] last_updated => \(last_updated)")
        
        
//        //test
////        let val : String = Methods.get_Defaults(CONS.s_AdminKey__LastBackup)
//        let val : String? = Methods.get_Defaults(CONS.s_AdminKey__LastBackup)
//        
//        //debug
//        print("[\(Methods.basename(#file)):\(#line)] Methods.get_Defaults => done")
//        
//        
//        //test
//        if val == nil {
//
//            //debug
//            print("[\(Methods.basename(#file)):\(#line)] val => nil")
//
//            
//        }
//        
//        //debug
//        do {
//
//            //debug
////            try print("[\(Methods.basename(#file)):\(#line)] defaults:CONS.s_AdminKey__LastBackup => \(val)")
//            print("[\(Methods.basename(#file)):\(#line)] defaults:CONS.s_AdminKey__LastBackup => \(val)")
//
//        } catch let e as NSError {
//            
//            //debug
//            print("[\(Methods.basename(#file)):\(#line)] error => \(e.description)")
//            
//            
//        }
        
//        if val == nil {
//            
//            print("[\(Methods.basename(#file)):\(#line)] defaults:CONS.s_AdminKey__LastBackup => \(val)")
//
//        } else {
//            
//            print("[\(Methods.basename(#file)):\(#line)] defaults:CONS.s_AdminKey__LastBackup => nil")
//            
//        }
        
        if content != nil {
            
            let tokens_lines = content!.componentsSeparatedByString("\n")

            if tokens_lines.count > 0 {

                let tokens_lines_0 = tokens_lines[0].componentsSeparatedByString(",")
                
                if tokens_lines_0.count > 0 {
                    
                    let tokens_lines_0_2 = tokens_lines_0[2].componentsSeparatedByString("=")
                    
                    if tokens_lines_0_2.count > 0 {
                        
                        //debug
                        print("[\(Methods.basename(#file)):\(#line)] tokens_lines_0_2[1] => \(tokens_lines_0_2[1])")
                        
                    } else {

                        //debug
                        print("[\(Methods.basename(#file)):\(#line)] tokens_lines_0_2.count => =< 0")

                    }
                    
                } else {

                    //debug
                    print("[\(Methods.basename(#file)):\(#line)] tokens_lines_0.count => =< 0")

                }

            } else {

                //debug
                print("[\(Methods.basename(#file)):\(#line)] tokens_lines.count => =< 0")

            }
            
        } else {
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] content => nil")
            
        }
        
    }
    
    func mailComposeController__DismissView() {
        
        // dismiss view
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    func insertData_Data_Latest_Diary_at(value : String) {
        
        let data = Data()

        let time_label = Methods.conv_NSDate_2_DateString(NSDate())

        data.id = Proj.lastId_Data()
        
        data.created_at = time_label
        data.modified_at = time_label

        data.name = CONS.s_AdminKey__Latest_Diary_at

        data.s_1 = value

        //debug
        print("[\(Methods.basename(#file)):\(#line)] writing to => realm_admin")


        try! realm_admin.write {

            self.realm_admin.add(data, update: false)

            //debug
            print("[\(Methods.basename(#file)):\(#line)] new data saved => \(data.description)")

        }

        
    }
    
    func updateData_Data__Latest_Diary_at(value : String) {
        
//        let r = Methods.get_RealmInstance(CONS.s_Realm_FileName__Admin)
        
        let data = Data()

        let time_label = Methods.conv_NSDate_2_DateString(NSDate())

        data.created_at = time_label
        data.modified_at = time_label

//        data.name = CONS.s_AdminKey__Latest_Diary_at
        data.name = CONS.s_LatestBackup_Diary_ModifiedAt

        data.s_1 = value

        let new_id = Methods.lastId_Data()
        
        
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] new_id => \(new_id)")

        data.id = Methods.lastId_Data()
//        data.id = 2
//        data.id = 4
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] writing to => realm_admin")

        try! realm_admin.write {

            self.realm_admin.add(data, update: false)

            //debug
            print("[\(Methods.basename(#file)):\(#line)] new data saved => \(data.description)")

        }


//
//                // already in db?
//                var query = "name == '\(CONS.s_AdminKey__Latest_Diary_at)'"
//        
//                //        var aPredicate = NSPredicate(format: "title CONTAINS %@", tmp_s)
//                var aPredicate = NSPredicate(format: query)
//        
//                let res = DB.findAll_Data__Filtered(CONS.s_Realm_FileName__Admin, predicate: aPredicate, sort_key: "created_at", ascend: false)
//        
//        //debug
//        print("[\(Methods.basename(#file)):\(#line)] res.count => \(res.count)")
//
//        
//                if res.count < 1 {
//        
//                    let data = Data()
//        
//                    let time_label = Methods.conv_NSDate_2_DateString(NSDate())
//        
//                    data.created_at = time_label
//                    data.modified_at = time_label
//        
//                    data.name = CONS.s_AdminKey__Latest_Diary_at
//        
//                    data.s_1 = value
//        
//                    //debug
//                    print("[\(Methods.basename(#file)):\(#line)] writing to => realm_admin")
//                    
//                    
//                    try! realm_admin.write {
//        
//                        self.realm_admin.add(data, update: false)
//        
//                        //debug
//                        print("[\(Methods.basename(#file)):\(#line)] new data saved => \(data.description)")
//        
//                    }
//        
//                } else {
//
//                    //debug
//                    print("[\(Methods.basename(#file)):\(#line)] res.count => more than 1")
//	
//                    let data = res[0]
//        
//                    let time_label = Methods.conv_NSDate_2_DateString(NSDate())
//        
//                    data.modified_at = time_label
//        
//                    data.s_1 = value
//        
//                    //debug
//                    print("[\(Methods.basename(#file)):\(#line)] writing to => realm_admin")
//
//                    try! realm_admin.write {
//                        
//                        self.realm_admin.add(data, update: true)
//                        
//                        //debug
//                        print("[\(Methods.basename(#file)):\(#line)] data updated => \(data.description)")
//                        
//                    }
//                    
//                    
//                }
    }

// MARK: orientation
    //ref http://stackoverflow.com/questions/29950456/how-to-lock-orientation-just-for-one-view-controller answered Apr 29 '15 at 17:25
//    override func supportedInterfaceOrientations() -> Int {
//        
//        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
//        
//    }
        ///Users/mac/Desktop/works/WS/xcode/Chapter6_L-32_after/I/Chapter6/ViewController.swift:2090:19: Method does not override any method from its superclass
    
    override func shouldAutorotate() -> Bool{
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] shouldAutorotate")

        
        return false
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.Portrait
    }


    func show_Dialog__Remind_NewDiaries(num : Int) {
            
            //        let s_title = "Choices"
            let s_title = "New diaries exisits"
            
            let s_message = "\(num) new ones. Upload?"
            
            let refreshAlert = UIAlertController(title: s_title, message: s_message, preferredStyle: UIAlertControllerStyle.Alert)
            
            let choice_0 = "OK"
            
            let choice_1 = "No"
            
            refreshAlert.addAction(UIAlertAction(title: choice_0, style: .Default, handler: { (action: UIAlertAction!) in
                
                //debug
                print("[\(Methods.basename(#file)):\(#line)] chosen => 0")
                
                // execute  => close dialog
                self.backupDiaries_ViaEmail__Ok()
                
            }))
            
            
            refreshAlert.addAction(UIAlertAction(title: choice_1, style: .Default, handler: { (action: UIAlertAction!) in
                
                //debug
                print("[\(Methods.basename(#file)):\(#line)] chosen => 1")
                
            }))
            
            // show view
            self.presentViewController(refreshAlert, animated: true, completion: nil)
            
    }


}

