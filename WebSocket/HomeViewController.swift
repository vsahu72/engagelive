//
//  HomeViewController.swift
//  WebSocket
//
//  Created by vikash sahu on 13/12/19.
//  Copyright © 2019 Aripra. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
         let vc = self.storyboard?.instantiateViewController(withIdentifier: "ROOT")
     
        self.present(vc!, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
