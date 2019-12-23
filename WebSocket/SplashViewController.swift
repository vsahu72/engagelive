//
//  SplashViewController.swift
//  WebSocket
//
//  Created by admin10.10 on 13/06/18.
//  Copyright © 2018 Aripra. All rights reserved.
//

import UIKit
var socketController:SocketController = SocketController()
class SplashViewController: UIViewController,SocketControllerDelegate {
    
    @IBOutlet weak var copyrightText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        socketController.delegate = self
        socketController.didConnect()
        copyrightText.text = socketController.getCopyrightString()
        let bundle = Bundle(identifier: "com.aripra.WebsocketFrameWork")
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
        socketController.delegate = viewController as? SocketControllerDelegate
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func applicationIsActive(isAppActive: ObjCBool) {
        
        /*  if  isAppActive.boolValue{
            print("ACTIVE")
            let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
            socketController.delegate = viewController as? SocketControllerDelegate
            navigationController?.pushViewController(viewController, animated: true)
        }else{
            print("INACTIVE")
           self.showAlertView()
            
        }*/
        
    }
    
    func showAlertView() {
        let alert = UIAlertController(title: "Warning!", message: "Support of this application has been expired, Please uninstall app.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { action in
            print("cancel")
            exit(0);
        }))
        self.present(alert, animated: true, completion: nil)
    } 
}
