//
//  Beast+CoreDataProperties.swift
//  iOSBlackBeltExam
//
//  Created by Eric Nevin on 5/20/16.
//  Copyright © 2016 Eric Nevin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Beast {

    @NSManaged var things: String?
    @NSManaged var date: NSDate?

}
