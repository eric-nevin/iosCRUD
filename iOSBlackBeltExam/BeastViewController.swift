//
//  BeastViewController.swift
//  BlackBeltExam
//
//  Created by Eric Nevin on 5/20/16.
//  Copyright © 2016 Ahmadali Shakeri. All rights reserved.
//

import UIKit
import CoreData

class BeastViewController: UITableViewController {
    var beast = [Beast]()
    var update = false
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewWillAppear(animated: Bool) {
            self.viewDidLoad()
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print("We Deleted Something")
        print (indexPath)
        managedObjectContext.deleteObject(beast[indexPath.row])
        beast.removeAtIndex(indexPath.row)
        tableView.reloadData()
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    override func viewDidLoad() {
        
        let userRequest = NSFetchRequest(entityName: "Beast")// Grabs All the DATA from the table MISSIONS
        
        do {
            let results = try managedObjectContext.executeFetchRequest(userRequest)
            beast = results as! [Beast]
            tableView.reloadData()
        } catch {
            print("\(error)")
        }
        super.viewDidLoad()
        update = false
        print ("here")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BeastCell")!
        cell.textLabel?.text = beast[indexPath.row].things
        if beast[indexPath.row].date != nil {
        cell.detailTextLabel?.text = String(beast[indexPath.row].date!)
        }
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beast.count
    }

}
