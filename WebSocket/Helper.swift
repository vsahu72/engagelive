//
//  Helper.swift
//  WebsocketFrameWork
//
//  Created by vikash sahu on 16/12/19.
//  Copyright © 2019 Aripra. All rights reserved.
//

import UIKit

public class Helper {

    public init() {}
    
    public static  func getController() -> RootSocketNavigationViewController{
        
        let storyboardName = "Main"
        let storyboardBundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
        
       // let storyboard = UIStoryboard(name: "WebSocketMain", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ROOT") as! RootSocketNavigationViewController
    }
    
    public static  func getController1() -> RootSocketNavigationViewController{
           
           let bundle = Bundle(identifier: "com.aripra.WebsocketFrameWork")
           let storyboard = UIStoryboard(name: "Main", bundle: bundle)

           return storyboard.instantiateViewController(withIdentifier: "ROOT") as! RootSocketNavigationViewController
       }
}
