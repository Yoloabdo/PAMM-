//
//  TimeTableViewController.swift
//  Pamm
//
//  Created by Abdulrhman  eaita on 4/30/16.
//  Copyright © 2016 Abdulrhman eaita. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class TimeTableViewController: UITableViewController {
    
    var tableItems = [String]()
    
    
    
    // MARK: -Getting data 
    func watchData() -> Void {
        DataService.sharedInstance().REF_TABLE_THIRD_SEC4.observeEventType(.Value, withBlock: { (snapShot) in
            
            self.tableItems = []
            guard let snapShots = snapShot.children.allObjects as? [FDataSnapshot] else {
                "Couldn't parse data from firebase"
                return
            }
            
            for snap in snapShots {
                let title = snap.value as! String
                self.tableItems.append(title)
                self.tableView.reloadData()
//                guard let tableDict = snap.value as? Dictionary<String, AnyObject> else {
//                    print("wrong parsing snap value")
//                    return
//                }
                
                
            }
        })
    }

    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        watchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimeCell", forIndexPath: indexPath)

        cell.textLabel?.text = tableItems[indexPath.row]

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
