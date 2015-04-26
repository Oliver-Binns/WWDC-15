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
}
