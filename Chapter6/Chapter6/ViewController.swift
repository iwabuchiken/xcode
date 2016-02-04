//
//  ViewController.swift
//  Chapter6
//
//  Created by mac on 2016/02/04.
//  Copyright © 2016年 livetill150. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //ref http://stackoverflow.com/questions/17735182/could-not-find-any-information-for-class-named-viewcontroller answered Dec 20 '14 at 9:02
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray: [Int] = []
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 10
        return dataArray.count
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
//        cell.textLabel?.text = "Row \(indexPath.row)!!"
        cell.textLabel?.text = "\(indexPath.row)"
        
        //cell.detailTextLabel?.text = "Subtitle \(indexPath.row)"
        //ref http://stackoverflow.com/questions/32552336/generating-random-numbers-with-swift-2 answered Sep 13 '15 at 17:26
        //cell.detailTextLabel?.text = "Subtitle \( Int(arc4random_uniform(3)) )"
        cell.detailTextLabel?.text = "Subtitle \( dataArray[indexPath.row] )"
        
        return cell

    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            dataArray.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    @IBAction func add(sender: UIBarButtonItem) {
    
        dataArray.append(dataArray.count)
        
        tableView.reloadData()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

