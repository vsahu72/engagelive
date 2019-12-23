//
//  WebViewController.swift
//  WebSocket
//
//  Created by admin10.10 on 28/06/18.
//  Copyright © 2018 Aripra. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    var viewController = ViewController()
    @IBOutlet var webView : UIWebView?
    @IBOutlet var termsAndConditionsEnable : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adding webView content
        
        if let path = Bundle.main.path(forResource: "Terms-and-Conditions_2.0", ofType: "pdf")
        {
            let pdfUrl = NSURL.init(fileURLWithPath: path) as URL
            do {
                let data = try Data(contentsOf:pdfUrl)
                webView?.load(data, mimeType: "application/pdf", textEncodingName: "", baseURL: pdfUrl.deletingLastPathComponent())
            }catch {
                // catch errors here
                 print ("File reading error")
            }
        }
    }

    @IBAction func doneBtnAction(_ sender: Any) {
        if (termsAndConditionsEnable?.isSelected)!{
            UserDefaults.standard.set("false", forKey: "FRESH_INSTALL")
            UserDefaults.standard.synchronize()
            self.dismiss(animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Warning!", message: "Please select checkbox.", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            
            // show the alert
            self.present(alert, animated: false, completion: nil)
        }

    }
    @IBAction func termsAndConditionsBtnAction(_ sender: Any) {
        
        if (termsAndConditionsEnable?.isSelected)!{
            termsAndConditionsEnable?.isSelected = false
        }else{
            termsAndConditionsEnable?.isSelected = true
        }
    }

}
