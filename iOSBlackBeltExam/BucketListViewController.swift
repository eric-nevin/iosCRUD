
//
//  ViewController.swift
//  Bucket List
//
//  Created by Ahmadali Shakeri on 5/9/16.
//  Copyright © 2016 Ahmadali Shakeri. All rights reserved.
//
import CoreData
import UIKit

class BucketListViewController: UITableViewController, CancelButtonDelegate, DoneButtonDelegate {
  // basicaly stating that this view controller is following these protocalls being the CancelButtonDelegate//DoneButtonDelegate
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // sets the initial udpate to be false
    var update = false
    var beast = [String]()
    
    @IBAction func beastButton(sender: UIButton) {
        let entityBeast = NSEntityDescription.entityForName("Beast", inManagedObjectContext: managedObjectContext)
        // entity in the BUCKETLIST.xcdatmodel// basically we have table  named Mission
        
        let beastCore = NSManagedObject(entity: entityBeast!, insertIntoManagedObjectContext: managedObjectContext)
        
        
        
        //Question why did i have to change mission to mission and why? //function for adding values to Column named details
        
        
        let button = sender
        let view = button.superview
        let cell = view!.superview as? UITableViewCell
        let indexPath = tableView.indexPathForCell(cell!)
        let newBeast = missions[indexPath!.row]
        let newBeastText = newBeast.details
        beast.append(newBeastText!)
        managedObjectContext.deleteObject(missions[indexPath!.row])
        missions.removeAtIndex(indexPath!.row)
        beastCore.setValue(newBeastText, forKey: "things")
        let dateFormat = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.FullStyle, timeStyle: NSDateFormatterStyle.NoStyle)
        let date = NSDate()
        
        print (dateFormat)
        
        beastCore.setValue(date, forKey: "date")
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


        
//        let entity2 = NSEntityDescription.entityForName("Beast", inManagedObjectContext: managedObjectContext)
        
        
        
    }
    // This Function will make it so the user is Able to Add Missions
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String){
        dismissViewControllerAnimated(true, completion: nil)
        
        let entity = NSEntityDescription.entityForName("Mission", inManagedObjectContext: managedObjectContext)
        // entity in the BUCKETLIST.xcdatmodel// basically we have table  named Mission
        
        let mission1 = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
       

      
       //Question why did i have to change mission to mission and why? //function for adding values to Column named details
        mission1.setValue(mission, forKey: "details")
       
        
        //Allowing us to save changes we made to the phone and save it in the phone memory
        do {
            try managedObjectContext.save()
            print("Success")
        } catch {
            print("\(error)")
        }
        //Displaying the save changes we made in Mission
        let userRequest = NSFetchRequest(entityName: "Mission")
        
        do {
            print("missions")
            let results = try managedObjectContext.executeFetchRequest(userRequest)
            missions = results as! [Mission]
        } catch {
            print("\(error)")
    }
        tableView.reloadData()
    }
    
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishEditingMission mission: Mission){
        dismissViewControllerAnimated(true, completion: nil)
         update = false
            if managedObjectContext.hasChanges {
                do {
                    try managedObjectContext.save()
                } catch {
                    let nserror = error as NSError
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
        }
        
        tableView.reloadData()
    }
   //delete function
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print("We Deleted Something")
        print (indexPath)
        managedObjectContext.deleteObject(missions[indexPath.row])
        missions.removeAtIndex(indexPath.row)
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
   // shows the details View when you press that (i)
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        update = true
        performSegueWithIdentifier("DetailsSegue", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    // redirects us back to the page we were on previously
    func cancelButtonPressedFrom(controller: UIViewController) {
        update = false
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       // basicaly saying what happens when we dont make changes take us back to page
        if segue.identifier == "DetailsSegue"{
        
            if update == false {
            
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! MissionDetailsViewController
            
            controller.cancelButtonDelegate = self
            controller.delegate = self
        }
        else if update == true {
            // when we do Make CHANGES go to that page with those changes that you made
            
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! MissionDetailsViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
            
                controller.missionToEdit = missions[indexPath.row]
                controller.missionToEditIndexPath = indexPath.row
                
                }
            }
        }
    }
    var missions = [Mission]() // an empty array we are using to store the values
    
    override func viewDidLoad() {
        
        
       
        let userRequest = NSFetchRequest(entityName: "Mission")// Grabs All the DATA from the table MISSIONS
      
        do {
            let results = try managedObjectContext.executeFetchRequest(userRequest)
            missions = results as! [Mission]
        } catch {
            print("\(error)")
        }
        super.viewDidLoad()
        update = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MissionCell")!
        cell.textLabel?.text = missions[indexPath.row].details
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return missions.count
    }
}

