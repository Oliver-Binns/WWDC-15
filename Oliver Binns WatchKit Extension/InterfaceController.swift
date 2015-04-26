//
//  InterfaceController.swift
//  Oliver Binns WatchKit Extension
//
//  BASIC Apple Watch app implementation.
//  Allows the user to keep reading about my accomplishments on the go!
//
//  Created by Oliver on 26/04/2015.
//  Copyright (c) 2015 Oliver Binns. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var storyTitle: WKInterfaceLabel!
    @IBOutlet weak var storyDescription: WKInterfaceLabel!

    @IBAction func generateNewStory() {
        //Set text to loading while generating a new story from iPhone.
        //This fixes an issue of the app not scrolling back to the top when a new story is presented.
        self.storyTitle.setText("Loading...");
        self.storyDescription.setText("");
        
        //Request a new story!
        getDataFromParentApp();
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context);
        //Request a new story when the app opens!
        getDataFromParentApp();
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func getDataFromParentApp() {
        //Tells the iPhone we want a random story! We could expand this in future for user to be able to request a story!
        let dictionary = ["type": "random"];
        WKInterfaceController.openParentApplication(dictionary) {
            (replyInfo, error) -> Void in
            if(error == nil && replyInfo != nil){ //check for error
                //Unwraps the returned data into an NSDictionary so we can access it.
                var test = replyInfo as NSDictionary;
                //displays data on the screen.
                var title = test.objectForKey("title") as? String;
                var description = test.objectForKey("description") as? String;
                self.storyTitle.setText(title);
                self.storyDescription.setText(description);
            }
            else if(error == nil && replyInfo == nil){
                //No error occured, but no data either?
                println("No data?!");
                self.storyTitle.setText("Ooops");
                self.storyDescription.setText("A problem occured! Please try loading a new story!");
            }
            else{
                //Oops! Error occured, lets try and handle it gracefully!
                println(error);
                self.storyTitle.setText("Ooops");
                self.storyDescription.setText("A problem occurred! Please try loading a new story!");
            }
        }
    }
}
