//
//  AboutMeViewController.swift
//  Oliver Binns
//
//  Created by Oliver on 26/04/2015.
//  Copyright (c) 2015 Oliver Binns. All rights reserved.
//

import UIKit
import MapKit
import MessageUI

class AboutMeViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var mapView: MKMapView!;
    
    @IBOutlet weak var mailButton: UIButton!;
    @IBOutlet weak var twitterButton: UIButton!;
    @IBOutlet weak var linkedInButton: UIButton!;
    
    @IBOutlet weak var label: UILabel!;
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.navigationItem.title = "About Me";
        
        //sets the label text
        label.text = "I'm from the town of Halifax, in sunny old England, and this app is all about me!\n\nFor more information you can contact me below.";
        
        //Sets the mapView to be show a HYBRID map
        mapView.mapType = MKMapType.Hybrid;
    }

    //Masks our buttons once view has finished laying out the subviews as until this point we do not know the SIZE of the button.
    override func viewDidLayoutSubviews() {
        //Masks our buttons to be round - looks prettier
        GlobalMethods.makeRound(mailButton);
        GlobalMethods.makeRound(twitterButton);
        GlobalMethods.makeRound(linkedInButton);
    }
    
    //Run when the send mail button is clicked
    @IBAction func sendMail(sender: UIButton) {
        //Determines whether an email account is set up on the device
        if(MFMailComposeViewController.canSendMail()){
            //If mail is set up, we present a mail compose view to the user
            var mailViewController = MFMailComposeViewController();
            mailViewController.mailComposeDelegate = self;
            mailViewController.setToRecipients(["mail@oliverbinns.co.uk"]);
            self.presentViewController(mailViewController, animated: true, completion: nil);
        }
        else{
            //device is not set up for mail - display an alert to prompt the user to email
            var alertController = UIAlertController(title: "Oops!", message: "Your device is not set up for mail!\nYou can manually email me at mail@oliverbinns.co.uk.", preferredStyle: UIAlertControllerStyle.Alert);
            var okay = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
            alertController.addAction(okay);
            self.presentViewController(alertController, animated: true, completion: nil);
        }
    }

    //Dismisses the mailview controller when user has finished!
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    //Twitter button has been pressed!
    @IBAction func twitter(sender: UIButton) {
        //Sets up an alert so user knows this will leave the current app!
        var alertController = UIAlertController(title: "Open Twitter", message: "You will leave the current app, do you want to continue?", preferredStyle: UIAlertControllerStyle.Alert);
        var cancel = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil);
            alertController.addAction(cancel);
        var okay = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {
            action in
            //Determines if the native Twitter app is installed!
            if(UIApplication.sharedApplication().canOpenURL(NSURL(string: "twitter://")!)){
                //if it is, open TWITTER
                UIApplication.sharedApplication().openURL(NSURL(string: "twitter://user?screen_name=Oliver_Binns")!);
            }
            else{
                //No Twitter app, open Twitter in Safari!
                UIApplication.sharedApplication().openURL(NSURL(string: "https://www.twitter.com/Oliver_Binns")!);
            }
        });
        alertController.addAction(okay);
        //Show the alert.
        self.presentViewController(alertController, animated: true, completion: nil);
    }
    
    //LinkedIn button has been pressed!
    @IBAction func openLinkedIn(sender: UIButton) {
        //Sets up an alert so user knows this will leave the current app!
        var alertController = UIAlertController(title: "Open LinkedIn", message: "You will leave the current app, do you want to continue?", preferredStyle: UIAlertControllerStyle.Alert);
        var cancel = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil);
        alertController.addAction(cancel);
        var okay = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {
            action in
            //No URL Scheme for native LinkedIn app- open Safari!
            UIApplication.sharedApplication().openURL(NSURL(string: "https://uk.linkedin.com/in/obinns")!);
        });
        alertController.addAction(okay);
        self.presentViewController(alertController, animated: true, completion: nil);
    }

    override func viewDidAppear(animated: Bool) {
        //Animate the map when the view appears - because it looks cool
        animateMap();
    }

    //this function animates the map zoom when the View appears
    func animateMap(){
        //Sets the camera to coordinates of Halifax
        var camera = MKMapCamera(lookingAtCenterCoordinate: CLLocationCoordinate2D(latitude: 53.723682, longitude:  -1.856196), fromEyeCoordinate: CLLocationCoordinate2D(latitude: 53.723682, longitude:  -1.856196), eyeAltitude: CLLocationDistance(2500));
        //animates the camera change
        mapView.setCamera(camera, animated: true);
    }
}
