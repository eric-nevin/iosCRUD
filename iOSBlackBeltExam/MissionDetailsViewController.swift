//
//  MissionDetailsViewController.swift
//  Bucket List
//
//  Created by Ahmadali Shakeri on 5/10/16.
//  Copyright © 2016 Ahmadali Shakeri. All rights reserved.
//

import UIKit

class MissionDetailsViewController: UITableViewController {
    // loads the mission details view controller
    
    @IBOutlet weak var newMissionTextField: UITextField!
    weak var delegate: DoneButtonDelegate?
    var missionToEdit: Mission?
    var missionToEditIndexPath: Int?
    weak var cancelButtonDelegate: CancelButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(missionToEdit != nil){
        newMissionTextField.text = missionToEdit?.details
        }
    }

    
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
        
    }
    @IBAction func DoneBarButtonPressed(sender: UIBarButtonItem) {
        if let mission = missionToEdit {
            mission.details = newMissionTextField.text!
         delegate?.missionDetailsViewController(self, didFinishEditingMission: mission)
            

        } else { 
                let mission = newMissionTextField.text!
                delegate?.missionDetailsViewController(self, didFinishAddingMission: mission)
            }
    }

}
    
    

    
   