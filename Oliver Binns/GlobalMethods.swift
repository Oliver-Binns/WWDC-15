//
//  GlobalMethods.swift
//  
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
    
    class func is4S() -> Bool{
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            if UIScreen.mainScreen().nativeBounds.height == 960 {
                return true;
            }
        }
        return false;
    }
}
