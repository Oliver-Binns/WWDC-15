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

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var mailButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var linkedInButton: UIButton!
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "About Me";
        
        //sets the label text
        label.text = "I'm from the town of Halifax in sunny old England and this app is all about me!\n\nFor more information you can contact me below.";
        
        //Masks our buttons to be round - looks prettier
        GlobalMethods.makeRound(mailButton);
        GlobalMethods.makeRound(twitterButton);
        GlobalMethods.makeRound(linkedInButton);
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendMail(sender: UIButton) {
        if(MFMailComposeViewController.canSendMail()){
            var mailViewController = MFMailComposeViewController();
            mailViewController.mailComposeDelegate = self;
            mailViewController.setToRecipients(["mail@oliverbinns.co.uk"]);
            self.presentViewController(mailViewController, animated: true, completion: nil);
        }
        else{
            //device is not set up for mail
            var alertController = UIAlertController(title: "Oops!", message: "Your device is not set up for mail!\nYou can manually email me at mail@oliverbinns.co.uk.", preferredStyle: UIAlertControllerStyle.Alert);
            var okay = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
            alertController.addAction(okay);
            self.presentViewController(alertController, animated: true, completion: nil);
        }
    }

    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction func twitter(sender: UIButton) {
        var alertController = UIAlertController(title: "Open Twitter", message: "This will close the current app, do you want to continue?", preferredStyle: UIAlertControllerStyle.Alert);
        var cancel = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil);
            alertController.addAction(cancel);
        var okay = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {
            action in
            if(UIApplication.sharedApplication().canOpenURL(NSURL(string: "twitter://")!)){
                UIApplication.sharedApplication().openURL(NSURL(string: "twitter://user?screen_name=Oliver_Binns")!);
            }
            else{
                UIApplication.sharedApplication().openURL(NSURL(string: "https://www.twitter.com/Oliver_Binns")!);
            }
        });
        alertController.addAction(okay);
        self.presentViewController(alertController, animated: true, completion: nil);
    }
    
    @IBAction func openLinkedIn(sender: UIButton) {
        var alertController = UIAlertController(title: "Open LinkedIn", message: "This will close the current app, do you want to continue?", preferredStyle: UIAlertControllerStyle.Alert);
        var cancel = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil);
        alertController.addAction(cancel);
        var okay = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {
            action in
            UIApplication.sharedApplication().openURL(NSURL(string: "https://uk.linkedin.com/in/obinns")!);
        });
        alertController.addAction(okay);
        self.presentViewController(alertController, animated: true, completion: nil);
    }
    
    override func viewDidAppear(animated: Bool) {
        animateMap();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }

    //this function animates the map zoom when the View appears
    func animateMap(){
        //Sets the camera to coordinates of Halifax
        var camera = MKMapCamera(lookingAtCenterCoordinate: CLLocationCoordinate2D(latitude: 53.723682, longitude:  -1.856196), fromEyeCoordinate: CLLocationCoordinate2D(latitude: 53.723682, longitude:  -1.856196), eyeAltitude: CLLocationDistance(2500));
        //animates the camera change
        mapView.setCamera(camera, animated: true);
    }
}
