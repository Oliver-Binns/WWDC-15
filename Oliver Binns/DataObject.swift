//
//  DataObject.swift
//  Oliver Binns
//
//  Created by Oliver on 26/04/2015.
//  Copyright (c) 2015 Oliver Binns. All rights reserved.
//

import UIKit

class DataObject: NSObject {
    var index: Int?
    var name: String?
    var text: String?
    var images: [UIImage] = [];
    var url: String?
    
    init(index: Int, dictionary: NSDictionary){
        super.init();
        name = dictionary.objectForKey("name") as? String;
        text = dictionary.objectForKey("text") as? String;
        
        //Iterate through the array and get corresponding image for each item.
        var imgArr = dictionary.objectForKey("image") as! NSArray;
        for(var i = 0; i < imgArr.count; i++){
            var img = imgArr[i] as? String;
            images.append(UIImage(named: img!)!);
        }
        self.index = index;
        url = dictionary.objectForKey("url") as? String;
    }
}
