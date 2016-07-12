//
//  DoneButtonDeleagate.swift
//  Bucket List
//
//  Created by Ahmadali Shakeri on 5/10/16.
//  Copyright © 2016 Ahmadali Shakeri. All rights reserved.
//

import Foundation


protocol DoneButtonDelegate: class {
    
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String)
    
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishEditingMission mission: Mission)
}
