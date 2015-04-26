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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalMethods.makeRound(meButton);
        GlobalMethods.makeRound(workButton);
        GlobalMethods.makeRound(musicButton);
        GlobalMethods.makeRound(codeButton);
        GlobalMethods.makeRound(schoolButton);
        // Do any additional setup after loading the view.
    }

    @IBAction func showDetail(sender: UIButton) {
        self.performSegueWithIdentifier("showDetail", sender: sender);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showDetail"){
            var destController = segue.destinationViewController as! RootViewController;
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
