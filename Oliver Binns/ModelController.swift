//
//  ModelController.swift
//  Oliver Binns
//
//  Created by Oliver on 26/04/2015.
//  Copyright (c) 2015 Oliver Binns. All rights reserved.
//

import UIKit

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class ModelController: NSObject, UIPageViewControllerDataSource {

    //Stores the array of data for this category
    var pageData = NSMutableArray();

    init(dataSet: String) {
        super.init();
        
        // Create the data model.
        var array = getDataArray(dataSet); //get the array of data for this category from the json file
        //For each item of data...
        for(var i = 0; i < array.count; i++){
            //Initialise a new data object to store the data
            var new = DataObject(index: i, dictionary: (array.objectAtIndex(i) as? NSDictionary)!);
            //Store this object in the page data array
            pageData.addObject(new);
        }
    }

    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        
        //There is no controller if the given index is higher than the number of data, or if there is no data at all
        if (self.pageData.count == 0) || (index >= self.pageData.count) {
            return nil;
        }

        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier("DataViewController") as! DataViewController
        dataViewController.dataObject = self.pageData[index] as? DataObject //Set the data for each page
        return dataViewController;
    }

    func indexOfViewController(viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        if let dataObject: AnyObject = viewController.dataObject {
            return self.pageData.indexOfObject(dataObject);
        } else {
            return NSNotFound
        }
    }

    // MARK: - Page View Controller Data Source

    //Returns the ViewController BEFORE a given ViewController
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController);
        if (index == 0) || (index == NSNotFound) {
            return nil;
        }
        
        index--;
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!);
    }

    //Returns the ViewController AFTER a given ViewController
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController);
        if index == NSNotFound {
            return nil;
        }
        
        index++;
        if index == self.pageData.count {
            return nil;
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!);
    }

    //Gets the data array for a given string category
    func getDataArray(type: String) -> NSArray{
        //The file path for the data
        var filePath = NSBundle.mainBundle().pathForResource("data", ofType: "json");
        //Gets the data from the file
        var data = NSData(contentsOfFile: filePath!);
        var e:NSError?;
        //Serialise the json data into a dictionary
        var json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: &e) as! NSDictionary;
        //Get the array for the given category
        var array : NSArray = json.objectForKey(type) as! NSArray;
        //Return!
        return array;
    }
}

