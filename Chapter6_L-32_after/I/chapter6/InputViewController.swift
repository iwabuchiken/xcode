//
//  InputViewController.swift
//  Chapter6
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit
import RealmSwift

import AudioToolbox

//ref https://akira-watson.com/iphone/textfield.html "UITextFieldDelegate をViewControllerに設定して"
class InputViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    // controls
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!

    /*
        vars
    */
    var current_editor = ""     // "tv" (textview), "tf" (textfield)
    
    let realm = try! Realm()
    var diary: Diary!
    
    //test
    //ref http://stackoverflow.com/questions/29839069/how-make-vibrate-twice-my-iphone-when-i-click-on-a-button-ios-swift-xcode answered Sep 9 '15 at 16:23
    var counter = 0
    var timer : NSTimer?

    //ref http://stackoverflow.com/questions/30918732/how-to-determine-which-textfield-is-active-swift answered Jun 18 '15 at 14:56
    var activeTextField = UITextField()
    
    @IBAction func action_b_CloseOSKeyboard(sender: UIButton) {

        //ref https://akira-watson.com/iphone/textfield.html "ボタン等でendEditing()"
        self.view.endEditing(true)
    
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        
        self.activeTextField = textField

        // set value
        self.current_editor = "tf"
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] textFieldDidBeginEditing")

    }
    
    //ref http://stackoverflow.com/questions/29465025/how-do-you-run-a-section-of-code-when-the-user-taps-the-uitextview-in-swift answered Apr 6 '15 at 3:55
    var activeTextView = UITextView()
    
    func textViewDidBeginEditing(textView: UITextView) {
        
        self.activeTextView = textView
        
        // set value
        self.current_editor = "tv"

        //debug
        print("[\(Methods.basename(#file)):\(#line)] textViewDidBeginEditing")
        
    }
    
    // MARK: - Actions
    
    
    
    @IBAction func action_b_InputDateLabel(sender: UIButton) {

//        // get current text
//        let tf_active = self.activeTextField

        // validate
        if self.current_editor == "" {
            
            self.current_editor = "tv"  // default --> textview (body)
            
        }
        
        // dispatch
        if self.current_editor == "tv" {

            var text_current = self.bodyTextView.text
            
            text_current = text_current + Methods.get_TimeLabel__Serial()
            
            self.bodyTextView.text = text_current
            
        } else if self.current_editor == "tf" {
            
            var text_current = self.titleTextField.text
            
            text_current = text_current! + Methods.get_TimeLabel__Serial()
            
            self.titleTextField.text = text_current
            
        }
        
        // vib
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        
//        //debug
//        print("[\(Methods.basename(#file)):\(#line)] tf_active?.description => \(tf_active.description)")

        
        
    }

    @IBAction func copy_Title(sender: UIButton) {
    
        let title = titleTextField.text!
        
        UIPasteboard.generalPasteboard().string = title
        
        
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] copied => \(UIPasteboard.generalPasteboard().string!)")
        
    }
    
    
    @IBAction func userTappedBackground(sender: AnyObject) {
        
        titleTextField.text = "background tapped"
        
        titleTextField.resignFirstResponder()
        
        bodyTextView.resignFirstResponder()
        
//        firstTextField.resignFirstResponder()
//        secondTextField.resignFirstResponder()
//        
//        // ...more of the same...
//        
//        lastTextField.resignFirstResponder()
    }
    
    @IBAction func backTo_ViewController(sender: UIButton) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func pattern_Generic(sender: UIButton) {

        let text = titleTextField.text
        
        //ref http://stackoverflow.com/questions/26074239/how-to-get-label-name-from-button answered Sep 27 '14 at 11:43
        //        titleTextField.text += ":doing"
        titleTextField.text = text! + (sender.titleLabel?.text)!

        //test: vibrate
        //ref 	http://stackoverflow.com/questions/26455880/how-to-make-iphone-vibrate-using-swift        answered Nov 13 '15 at 12:45
        
        if (sender.titleLabel?.text)! == " " {
            
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            
        }
//        //test
//        counter = 0
//        timer = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: "vibratePhone", userInfo: nil, repeats: true)
        
        
    }
    
    @IBAction func pattern_End(sender: UIButton) {
        
        
        
        let text = titleTextField.text
        
        //        titleTextField.text += ":doing"
        titleTextField.text = text! + ":end"

    }
    @IBAction func pattern_Start(sender: UIButton) {
        
        let text = titleTextField.text
        
        //        titleTextField.text += ":doing"
        titleTextField.text = text! + ":start"
        
    }
    @IBAction func pattern_Doing(sender: UIButton) {
        
        let text = titleTextField.text
        
//        titleTextField.text += ":doing"
        titleTextField.text = text! + ":doing"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NavigationBar の戻るボタンを消す
//        self.navigationItem.setHidesBackButton(true, animated:false);
        
        titleTextField.text = diary.title
        bodyTextView.text = diary.body
//        titleTextField.text = ""
//        bodyTextView.text = ""
    
        // delegate
        titleTextField.delegate = self
        
        //delegate
        //ref http://stackoverflow.com/questions/29465025/how-do-you-run-a-section-of-code-when-the-user-taps-the-uitextview-in-swift answered Apr 6 '15 at 3:55
        self.bodyTextView.delegate = self
        
        // Do any additional setup after loading the view.
        print("[\(Methods.basename(#file)):\(#line)] diary.title => \(diary.title)")
//        print(Methods.basename(#file))
        print("[\(Methods.basename(#file)):\(#line)] diary.id => \(diary.id)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        
//        mLabel.text = textField.text
        
        // キーボードを閉じる
        titleTextField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func save(sender: UIButton) {

        /*
            go back?
        */
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //        var dfltVal_DebugMode = defaults.valueForKey(CONS.defaultKeys.key_Set_DebugMode)
        var dfltVal_key_GoBack_WhenSaved = defaults.valueForKey(CONS.defaultKeys.key_GoBack_WhenSaved)
        
        // validate
        if dfltVal_key_GoBack_WhenSaved == nil {
            
            // default --> true
            dfltVal_key_GoBack_WhenSaved = true
            
        }

        /*
            vibrate?
        */
        //        var dfltVal_DebugMode = defaults.valueForKey(CONS.defaultKeys.key_Set_DebugMode)
        var dfltVal_key_Vibrate_WhenSaved = defaults.valueForKey(CONS.defaultKeys.key_Vibrate_WhenSaved)
        
        // validate
        if dfltVal_key_Vibrate_WhenSaved == nil {
            
            // default --> true
            dfltVal_key_Vibrate_WhenSaved = true
            
        }
        
        try! realm.write {
            self.diary.title = self.titleTextField.text!
            self.diary.body = self.bodyTextView.text
            self.diary.date = NSDate()
            self.realm.add(self.diary, update: true)
            
            // vibrate
            
            if dfltVal_key_Vibrate_WhenSaved?.boolValue == true {
                
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                
            }
            
        }
        
        // go back to the source view
        if dfltVal_key_GoBack_WhenSaved?.boolValue == true {
        
            self.navigationController?.popViewControllerAnimated(true)
            
        }
        
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

    func vibratePhone() {
        counter++
        switch counter {
        case 1, 2:
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        default:
            timer?.invalidate()
        }
    }
    
// MARK: - others
    @IBAction func dup_Diary(sender: UIButton) {
        
        let s_title = "Duplicate Diary instance"
        
        let s_message = "same Diary instance"
        
//        self.realm.add(self.diary, update: true)
        let refreshAlert = UIAlertController(title: "\(s_title)", message: s_message, preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] clicked => Ok button")
            
            self.dup_Diary__OK()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
    }

    func dup_Diary__OK() {

//        self.diary.title = self.titleTextField.text!
//        self.diary.body = self.bodyTextView.text
//        self.diary.date = NSDate()
//        self.diary.created_at = NSDate()
//        
//        self.realm.add(self.diary, update: false)

        try! realm.write {
//            self.diary.title = self.titleTextField.text!
//            self.diary.body = self.bodyTextView.text
//            self.diary.date = NSDate()
//            self.diary.created_at = NSDate()
            
            let diary_new = Diary()
            
            diary_new.id = Methods.lastId_Diary()
            
            diary_new.title = self.diary.title
            diary_new.body = self.diary.body
            
            let time = NSDate()
            
            diary_new.created_at = time
            diary_new.date = time

//            self.realm.add(self.diary, update: false)
            self.realm.add(diary_new, update: true)
            
        }
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
}
