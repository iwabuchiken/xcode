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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = "Row \(indexPath.row)!!"
        
        cell.detailTextLabel?.text = "Subtitle \(indexPath.row)"
        
        return cell

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

