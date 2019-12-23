//
//  ImageExtension.swift
//  WebsocketFrameWork
//
//  Created by vikash sahu on 19/12/19.
//  Copyright © 2019 Aripra. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
     func getAssetImage(assetIdentifier: String) -> UIImage {
        let bundle = Bundle(identifier: "com.aripra.WebsocketFrameWork")
        guard let image =  UIImage(named: assetIdentifier, in: bundle, compatibleWith: nil)else{
            return UIImage()
        }
        return image
    }
}
