//
//  DataViewController.swift
//  Oliver Binns
//
//  Created by Oliver on 26/04/2015.
//  Copyright (c) 2015 Oliver Binns. All rights reserved.
//

import UIKit
import Foundation

class DataViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var dataObject: DataObject?
    var delayTimer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //When the view appears, set the content from the given DataObject.
        if let obj: DataObject = dataObject{
            self.dataLabel!.text = obj.name;
            
            imageView.image = obj.images[0];
            //Make image view transition through all images for this data!
            imageView.animationImages = obj.images;
            imageView.animationDuration = 10.0;
            imageView.startAnimating()
            
            //Set the text label
            self.textLabel.text = obj.text;
            
            if(obj.url != nil){
                //add the target for a button press
                self.detailButton.addTarget(self, action: "buttonPress", forControlEvents: .TouchUpInside);
            }
            else{
                //Remove the detail button if we have no url to load!
                self.detailButton.removeFromSuperview();
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        //flash the scroll bars every two seconds to let the user know that the text can be scrolled
        delayTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("flashScroll"), userInfo: nil, repeats: true);
    }
    
    //This function flashes the indicators of the scroll view, it is called by the timer.
    func flashScroll(){
        scrollView.flashScrollIndicators();
    }
    
    //The user has scrolled, we can stop flashing the scroll bars now!
    func scrollViewDidScroll(scrollView: UIScrollView) {
        delayTimer?.invalidate();
        delayTimer = nil;
    }
    
    
    //Called when the 'Find Out More' button is pressed to determine the appropriate site to open!
    func buttonPress(){
        //Series of if statements determine the appropriate prompt to display on the screen from the URL.
        if(dataObject!.url?.rangeOfString("youtube") != nil){
            openExternal("YouTube", url: (dataObject?.url)!);
        }
        else if(dataObject!.url?.rangeOfString("itunes") != nil){
            openExternal("App Store", url: (dataObject?.url)!);
        }
        else if(dataObject!.url?.rangeOfString("twitter") != nil){
            //IF the Twitter app is installed
            if(UIApplication.sharedApplication().canOpenURL(NSURL(string: "twitter://")!)){
                //Converts the Twitter URL into a url scheme so we can open it in the native Twitter app
                var index2 = dataObject?.url!.rangeOfString("/", options: .BackwardsSearch)?.endIndex;
                var substring2 = dataObject?.url!.substringFromIndex(index2!);
                var newurl = "twitter://status?id=" + substring2!;
                openExternal("Twitter", url: newurl);
            }
            else{
                openExternal("Safari", url: (dataObject?.url)!);
            }
        }
        else{
            openExternal("Safari", url: (dataObject?.url)!);
        }
    }
    
    //User has requested additional information, opens an external app for this.
    func openExternal(sitename: String, url: String){
        var alertController = UIAlertController(title: "Open " + sitename, message: "You will leave the current app, do you want to continue?", preferredStyle: UIAlertControllerStyle.Alert);
        //Cancel button, so user has the choice to stay in the app if they wish
        var cancel = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil);
        alertController.addAction(cancel);
        var okay = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {
            action in
            UIApplication.sharedApplication().openURL(NSURL(string: url)!);
        });
        alertController.addAction(okay);
        self.presentViewController(alertController, animated: true, completion: nil);
    }


}

