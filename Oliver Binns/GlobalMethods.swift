//
//  GlobalMethods.swift
//  
//  Static class with some basic methods that may be needed anywhere within the app!
//
//  Created by Oliver on 26/04/2015.
//
//

import UIKit

class GlobalMethods: NSObject {
    //Masks a UIButton into a round object.
    class func makeRound(button: UIButton){
        button.layer.cornerRadius = button.layer.frame.width / 2;
        button.layer.masksToBounds = true;
    }
    
    //Returns true if the device is an iPhone 4S.
    class func is4S() -> Bool{
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            if UIScreen.mainScreen().nativeBounds.height == 960 {
                return true;
            }
            else{
                return false;
            }
        }
        //iPads are the same ratio as 3.5 inch devices, we need to make the same adjustments
        return true;
    }
}
