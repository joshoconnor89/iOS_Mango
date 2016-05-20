//
//  TableViewController.swift
//  iOS_Mango
//
//  Created by Joshua O'Connor on 5/19/16.
//  Copyright © 2016 Joshua O'Connor. All rights reserved.
//

import UIKit
import CoreData
import Haneke

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var context: NSManagedObjectContext!

    @IBOutlet var videoTableView: UITableView!

    
    // MARK: Initialization
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let animalsFetchRequest = NSFetchRequest(entityName: "CDVideo")
        
        let coreDataStack =
            UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = coreDataStack.managedObjectContext
        
        let primarySortDescriptor = NSSortDescriptor(key: "time", ascending: false)
        animalsFetchRequest.sortDescriptors = [primarySortDescriptor]
       
        
        let frc = NSFetchedResultsController(
            fetchRequest: animalsFetchRequest,
            managedObjectContext: coreDataStack.managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        frc.delegate = self
        
        return frc
    }()
    
    override func viewDidLoad() {
        
        self.videoTableView.delegate = self;
        self.videoTableView.dataSource = self;
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("An error occurred")
        }
        player.isPaused = false;
        player.controlButtonTapped()
    }
    
    
    // MARK: TableView Delegate Methods
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section]
            return currentSection.numberOfObjects
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("cell") as? TableViewCell {

            let video = fetchedResultsController.objectAtIndexPath(indexPath) as! CDVideo
            cell.usernameLabel.text = video.username
            cell.videoidLabel.text = NSString(format:"Video ID: %@", (video.videoid)!) as String
            
            let formatter: NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = "MM-dd-yyyy',' hh:mm a"
            let stringFromDate: String = formatter.stringFromDate(video.time!)
            cell.timeLabel.text = stringFromDate

            let commonUI: CommonUI = CommonUI()
            cell.userImageView.image = UIImage(named: commonUI.getUserImage((video.username)!))
            
            cell.thumbnailImageView.hnk_setImageFromURL(NSURL(string: video.thumbnailURL!)!)

            return cell
        }
        
        return UITableViewCell()
        
    }

}
