//
//  InitialViewController.swift
//  Oliver Binns
//
//  Created by Oliver on 26/04/2015.
//  Copyright (c) 2015 Oliver Binns. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var meButton: UIButton!
    @IBOutlet weak var workButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var codeButton: UIButton!
    @IBOutlet weak var schoolButton: UIButton!
    @IBOutlet weak var oliverBinns: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //Remove name label from screen if the device is small, instead place name in Navigation bar!
        if(GlobalMethods.is4S()){
            oliverBinns.removeFromSuperview();
            self.navigationItem.title = "Oliver Binns";
        }
        
        //Make all the buttons round because it looks pretty!
        GlobalMethods.makeRound(meButton);
        GlobalMethods.makeRound(workButton);
        GlobalMethods.makeRound(musicButton);
        GlobalMethods.makeRound(codeButton);
        GlobalMethods.makeRound(schoolButton);
    }
    
    override func viewDidAppear(animated: Bool) {
        //Check if we've just opened! We don't want to display the animation upon RETURNING to the view.
        if(NSUserDefaults.standardUserDefaults().boolForKey("HasJustLaunched")){
            //For each of the buttons, animate their appearances on the screen!
            var array: [UIButton] = [meButton, workButton, musicButton, codeButton, schoolButton];
            for(var i = 0; i < array.count; i++){
                array[i].alpha = 0;
                array[i].imageView?.bounds = CGRectInset(array[i].imageView!.frame, -100, -100);
                
                UIView.animateWithDuration(0.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    array[i].alpha = 1;
                    array[i].imageView!.bounds = array[i].bounds;
                }, completion: nil);
            }
            //Set the just launched flag as false so that we don't reanimate on returning to this view.
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "HasJustLaunched");
            NSUserDefaults.standardUserDefaults().synchronize();
        }
    }

    //Button has been pressed! Open the Details in Paged View
    @IBAction func showDetail(sender: UIButton) {
        self.performSegueWithIdentifier("showDetail", sender: sender);
    }

    //Called upon pressing of a button, expands the button slightly.
    @IBAction func expandButton(sender: UIButton) {
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            sender.layer.cornerRadius = (sender.frame.height + 6) / 2;
            sender.bounds.size.height = sender.bounds.height + 6;
            sender.bounds.size.width = sender.bounds.width + 6;
        }, completion: nil)
    }
    
    //Called upon pressing of a button, contracts the button slightly.
    @IBAction func contractButton(sender: UIButton){
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            sender.layer.cornerRadius = (sender.frame.height - 6) / 2;
            sender.bounds.size.height = sender.bounds.height - 6;
            sender.bounds.size.width = sender.bounds.width - 6;
            }, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showDetail"){
            // Get the new view controller using segue.destinationViewController.
            var destController = segue.destinationViewController as! RootViewController;
            //Pass the appropriate data labels
            if(sender?.tag == 0){
                destController.dataSet = "Work";
            }
            else if(sender?.tag == 1){
                destController.dataSet = "Music";
            }
            else if(sender?.tag == 2){
                destController.dataSet = "Code";
            }
            else{
                destController.dataSet = "School";
            }
        }
    }
}
