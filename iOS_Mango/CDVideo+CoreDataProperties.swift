//
//  CDVideo+CoreDataProperties.swift
//  
//
//  Created by Joshua O'Connor on 5/19/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CDVideo {

    @NSManaged var mediaURI: String?
    @NSManaged var thumbnailURL: String?
    @NSManaged var videoid: NSNumber?
    @NSManaged var id: NSNumber?
    @NSManaged var username: String?
    @NSManaged var time: NSDate?

}
