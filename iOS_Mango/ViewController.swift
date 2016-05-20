//
//  ViewController.swift
//  iOS_Mango
//
//  Created by Joshua O'Connor on 5/18/16.
//  Copyright © 2016 Joshua O'Connor. All rights reserved.
//

import UIKit
import CoreData

var player: VideoPlayer!

class ViewController: UIViewController {

    var mediaURL: NSURL!
    private let videoBaseURL = NSURL(string: "https://www.mimri.io/v1/interv")
    var managedObject = [NSManagedObject]()
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    // MARK: Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
        self.getVideo()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(animated: Bool) {
        if (player != nil){
            player.playVideo()
        }
        
    }
    
    func setUpUI() {
        self.usernameLabel.text = ""
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        userImageView.clipsToBounds = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        activityIndicatorView.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.3)
        activityIndicatorView.layer.cornerRadius = 2;
        activityIndicatorView.hidden = true;
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.segueToTableViewController))
        leftSwipe.direction = .Left
        view.addGestureRecognizer(leftSwipe)
    }
    
    
    // MARK: Actions
    
    @IBAction func refreshVideo(sender: AnyObject) {
        player.terminateVideo()
        self.getVideo()
    }
    
    @IBAction func viewTableData(sender: AnyObject) {
        
        self.segueToTableViewController()
       
    }

    func segueToTableViewController() {
        player.pauseVideo()
        self.performSegueWithIdentifier("pushTableViewController", sender: self)
    }
    
    
    // MARK: Video Methods
    
    func getVideo() {
        
        activityIndicator.startAnimating()
        activityIndicatorView.hidden = false;
        let videoService = FetchVideo()
        
        videoService.getVideo(videoBaseURL!) {
            (let currentVideo) in
 
            dispatch_async(dispatch_get_main_queue()) {
                player = VideoPlayer.init(frame: self.videoView.bounds, contentURL: NSURL(string:(currentVideo?.mediaURI!)!)!);
                self.videoView.addSubview(player)
                self.usernameLabel.text = currentVideo?.username
                let commonUI: CommonUI = CommonUI()
                self.userImageView.image = UIImage(named: commonUI.getUserImage((currentVideo?.username)!))
                self.insertVideoInCoreData(currentVideo!)
                self.activityIndicator.stopAnimating()
                self.activityIndicatorView.hidden = true
            }
            
        }
    }
    
    func insertVideoInCoreData(currentVideo: Video) {
        
        let coreDataStack =
            UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = coreDataStack.managedObjectContext
        let entity =  NSEntityDescription.entityForName("CDVideo", inManagedObjectContext:managedContext)
        let video = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        video.setValue(currentVideo.mediaURI, forKey: "mediaURI")
        video.setValue(currentVideo.thumbnailURL, forKey: "thumbnailURL")
        video.setValue(currentVideo.username, forKey: "username")
        video.setValue(currentVideo.videoid, forKey: "videoid")
        video.setValue(currentVideo.id, forKey: "id")
        video.setValue(currentVideo.time, forKey: "time")
        
        do {
            try managedContext.save()
            managedObject.append(video)
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}














