# iOS_Mango

What this is
------------
A simple iOS application which uses NSURLSession, Core Data, NSFetchedResultsController, Haneke (CocoaPods), 
and a custom AVPlayer.  This is a project written in Swift 2.2.1 (Xcode 7.3.1). This app fetches a API
and stores the data into Core Data.  Core Data objects is presented as a video using a custom subclass
of the AVPlayer, and on the TableViewController using NSFetchedResultsController and Haneke for image
caching.  This project implements MVC (Model View Controller) architecture.

Installing 
----------

- If you don't have CocoaPods, install it ($ sudo gem install cocoapods)
- Run pod install on project directory to install Heneke CocoaPods.
- Open the .xcworkspace file with Xcode.  Enjoy

Work by 
----------
Josh O'Connor 2016
