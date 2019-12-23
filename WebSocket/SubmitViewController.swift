//
//  SubmitViewController.swift
//  WebSocket
//
//  Created by admin10.10 on 13/06/18.
//  Copyright © 2018 Aripra. All rights reserved.
//

import UIKit

class SubmitViewController: UIViewController {

    var ackText = ""
    @IBOutlet weak var copyrightText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        copyrightText.text = socketController.getCopyrightString()
        //submittedText.text = segmentCont
    }
    
    override func viewWillAppear(_ animated: Bool) {
         print("sucessfull submit");
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(30), execute: {
            print("dissmiss")
            self.dismiss(animated: true, completion: nil)
        })
    }
}
