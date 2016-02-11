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
class InputViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    let realm = try! Realm()
    var diary: Diary!
    
    //test
    //ref http://stackoverflow.com/questions/29839069/how-make-vibrate-twice-my-iphone-when-i-click-on-a-button-ios-swift-xcode answered Sep 9 '15 at 16:23
    var counter = 0
    var timer : NSTimer?
    
    @IBAction func copy_Title(sender: UIButton) {
    
        let title = titleTextField.text!
        
        UIPasteboard.generalPasteboard().string = title
        
        
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] copied => \(UIPasteboard.generalPasteboard().string!)")
        
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
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        
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
        self.navigationItem.setHidesBackButton(true, animated:false);
        
        titleTextField.text = diary.title
        bodyTextView.text = diary.body
//        titleTextField.text = ""
//        bodyTextView.text = ""
    
        // delegate
        titleTextField.delegate = self
        
        // Do any additional setup after loading the view.
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] diary.title => \(diary.title)")
//        print(Methods.basename(__FILE__))
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] diary.id => \(diary.id)")
        
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
        try! realm.write {
            self.diary.title = self.titleTextField.text!
            self.diary.body = self.bodyTextView.text
            self.diary.date = NSDate()
            self.realm.add(self.diary, update: true)
        }
        
        self.navigationController?.popViewControllerAnimated(true)
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
    
}
