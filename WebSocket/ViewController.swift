//
//  ViewController.swift
//  WebSocket
//
//  Created by PPogra on 11/06/18.
//  Copyright © 2018 Aripra. All rights reserved.
//

import UIKit
import SystemConfiguration
import AASegmentedControl


class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,SocketControllerDelegate
{
    
    let alphaList = ["a","b","c","d","e","f"]
    let numberList = ["one","two","three","four","5","6"]
    let colorList = ["red","blue","yellow","pink","green","orange"]
    let shapeList = ["star","triangle","heart","cloud","circle","square"]
    let yesNoList = ["yes","no","maybe"]
    var tempList:[String] = []
    var isRetry = false
    var errorMsg = "Server is not connected"
    
    var submitViewController = SubmitViewController()
    static var numberOfAttempt  = 0
    @IBOutlet weak var copyrightText: UILabel!
    @IBOutlet var retryButton: UIButton!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var statusImage: UIImageView!
    @IBOutlet var collectionViewOutlet: UICollectionView!
    @IBOutlet var segmentControl: AASegmentedControl!
    @IBOutlet var centerView: UIView!
    
    @IBOutlet var heightCollectionView: NSLayoutConstraint!
    
    @IBOutlet var widthCollectionView: NSLayoutConstraint!
    
    @IBOutlet var centerXCollectionView: NSLayoutConstraint!
    @IBOutlet var centerYCollectionView: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.alpha = 0
        socketController.delegate = self
        copyrightText.text = socketController.getCopyrightString()
        setTableviewCellSize()
        let returnValue = UserDefaults.standard.object(forKey: "FRESH_INSTALL")
        if (returnValue == nil) {
            
            self.showWebViewController()
        }else{
            self.view.alpha = 1
            
        }
        // Alpha has replaced with LETTER from UI
        segmentControl.segmentTitles = ["LETTER","NUMBER","COLOR","SHAPE","YES/NO"] // String array for titles
        segmentControl.selectedIndex = 0// Default selected index
        
        // Add listener and observe changes! of AASegmentedControl
        segmentControl.addTarget(self, action: #selector(self.segmentValueChanged(_:)), for: .valueChanged)
        let bundle = Bundle(identifier: "com.aripra.WebsocketFrameWork")
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        submitViewController = storyboard.instantiateViewController(withIdentifier: "SubmitViewController") as! SubmitViewController
        tempList=alphaList
        //retryButton.imageView?.image = UIImage(named: "retry.png")
        retryButton.imageView?.image = UIImage().getAssetImage(assetIdentifier: "retry.png")
        
    }
    
    func setTableviewCellSize(){
     let screenSize = UIScreen.main.bounds
        print("@@@@@@@@@@@@@   screen size: \(UIScreen.main.bounds)   @@@@@@@@@@@@@")
        
        let layout = UICollectionViewFlowLayout()
        //  layout.invalidateLayout();
        if screenSize.height <= 480{
            widthCollectionView.constant = 210
            heightCollectionView.constant = 310
            centerXCollectionView.constant = 0
            centerYCollectionView.constant = 0
            layout.itemSize = CGSize(width: 90, height: 90)
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            layout.minimumLineSpacing = 10.0
            layout.minimumInteritemSpacing = 0.0
            
        }else if screenSize.height <= 568{
            widthCollectionView.constant = 270
            heightCollectionView.constant = 400
            centerXCollectionView.constant = 0
            centerYCollectionView.constant = 0
            layout.itemSize = CGSize(width: 120, height: 120)
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            layout.minimumLineSpacing = 10.0
            layout.minimumInteritemSpacing = 0.0
            
        }else if screenSize.height <= 667{
            
            widthCollectionView.constant = 340
            heightCollectionView.constant = 500
            centerXCollectionView.constant = 0
            centerYCollectionView.constant = 0
            layout.itemSize = CGSize(width: 140, height: 140)
            layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            layout.minimumLineSpacing = 20.0
            layout.minimumInteritemSpacing = 0.0
            
        }else if screenSize.height < 812{
            widthCollectionView.constant = 360
            heightCollectionView.constant = 530
            centerXCollectionView.constant = 0
            centerYCollectionView.constant = 0
            layout.itemSize = CGSize(width: 150, height: 150)
            layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            layout.minimumLineSpacing = 20.0
            layout.minimumInteritemSpacing = 0.0
            
        }else if screenSize.height <= 736{
            widthCollectionView.constant = 360
            heightCollectionView.constant = 530
            centerXCollectionView.constant = 0
            centerYCollectionView.constant = 0
            layout.itemSize = CGSize(width: 90, height: 90)
            layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            layout.minimumLineSpacing = 20.0
            layout.minimumInteritemSpacing = 0.0
        }else if screenSize.height >= 812{
            
            widthCollectionView.constant = 320
            heightCollectionView.constant = 460
            centerXCollectionView.constant = 0
            centerYCollectionView.constant = 0
            
            layout.itemSize = CGSize(width: 140, height: 140)
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            layout.minimumLineSpacing = 10.0
            layout.minimumInteritemSpacing = 0.0
        }
        collectionViewOutlet.setCollectionViewLayout(layout, animated: false)
        
    }
    
    
    func setYESNOCellSize(){
        let screenSize = UIScreen.main.bounds
        print("@@@@@@@@@@@@@   screen size: \(UIScreen.main.bounds)   @@@@@@@@@@@@@")
        
        let layout = UICollectionViewFlowLayout()
        layout.invalidateLayout();
        if screenSize.height <= 480{
       
            widthCollectionView.constant = 210
            heightCollectionView.constant = 220
            centerXCollectionView.constant = 0
            centerYCollectionView.constant = 0
            layout.itemSize = CGSize(width: 190, height: 60)
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            layout.minimumLineSpacing = 10.0
            layout.minimumInteritemSpacing = 10.0
            
        }else if screenSize.height <= 568{
            widthCollectionView.constant = 270
            heightCollectionView.constant = 250
            centerXCollectionView.constant = 0
            centerYCollectionView.constant = 0
            
            layout.itemSize = CGSize(width: 250, height: 70)
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            layout.minimumLineSpacing = 10.0
            layout.minimumInteritemSpacing = 10.0
            
        }else if screenSize.height <= 667{
            
            widthCollectionView.constant = 320
            heightCollectionView.constant = 320
            centerXCollectionView.constant = 0
            centerYCollectionView.constant = 0
            
            layout.itemSize = CGSize(width: 290, height: 80)
            layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            layout.minimumLineSpacing = 20.0
            layout.minimumInteritemSpacing = 0.0
            
        }else if screenSize.height < 812{
            
            widthCollectionView.constant = 320
            heightCollectionView.constant = 320
            centerXCollectionView.constant = 0
            centerYCollectionView.constant = 0
            
            layout.itemSize = CGSize(width: 290, height: 80)
            layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            layout.minimumLineSpacing = 20.0
            layout.minimumInteritemSpacing = 0.0
            
        }else if screenSize.height <= 736{
            
            widthCollectionView.constant = 320
            heightCollectionView.constant = 320
            centerXCollectionView.constant = 0
            centerYCollectionView.constant = 0
            
            layout.itemSize = CGSize(width: 290, height: 80)
            layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            layout.minimumLineSpacing = 20.0
            layout.minimumInteritemSpacing = 0.0
        }
        else if screenSize.height >= 812{
            
            widthCollectionView.constant = 320
            heightCollectionView.constant = 300
            centerXCollectionView.constant = 0
            centerYCollectionView.constant = 0
            
            layout.itemSize = CGSize(width: 300, height: 80)
            layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
            layout.minimumLineSpacing = 10.0
            layout.minimumInteritemSpacing = 0.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10), execute: {
            print("layout...\(layout)")
            self.collectionViewOutlet.setCollectionViewLayout(layout, animated: false)
        })
      
    }
    
    
    func showWebViewController() {
        let webViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController")
        self.present(webViewController!, animated: false)
        {
            self.view.alpha = 1
        }
    }
    
    
    func retryToEstablishConnection() {
        retryButton.isHidden = true
        ViewController.numberOfAttempt = ViewController.numberOfAttempt + 1
        if ViewController.numberOfAttempt == 5 {
            ViewController.numberOfAttempt = 0
            isRetry = false
            retryButton.isHidden = false
            self.statusLabel.text = "DISCONNECTED"
            //self.statusImage.image = UIImage(named: "notconnected")
            self.statusImage.image = UIImage().getAssetImage(assetIdentifier: "notconnected")
        }else{
            if !socketController.isSocketConnected().boolValue{
                statusLabel.text = "TRY TO RECONNECT [\(ViewController.numberOfAttempt)]"
                statusImage.image = UIImage().getAssetImage(assetIdentifier: "attempt.png")
                socketController.didConnect()
            }else{
                ViewController.numberOfAttempt = 0
                isRetry = false
            }
        }
    }
    
    
    @objc func segmentValueChanged(_ sender: AASegmentedControl) {
        tempList.removeAll()
        print(segmentControl.selectedIndex)
        switch segmentControl.selectedIndex {
        case 0:
            print("Send: 0")
            tempList.append(contentsOf: alphaList)
        case 1:
            print("Send: 1")
              tempList.append(contentsOf: numberList)
        case 2:
            print("Send: 2")
              tempList.append(contentsOf: colorList)
        case 3:
            print("Send: 3")
              tempList.append(contentsOf: shapeList)
        case 4:
            print("Send: 4")
              tempList.append(contentsOf: yesNoList)
        default:
            print("default")
              tempList.append(contentsOf: alphaList)
        }
        print("segment no.......\(segmentControl.selectedIndex)")
        if segmentControl.selectedIndex == 4{
             setYESNOCellSize()
        }else{
            
            setTableviewCellSize()
        }
       collectionViewOutlet.reloadData()
    }
    
    
    @IBAction func swipeRight(_ sender: Any) {
        if segmentControl.selectedIndex > 0{
            segmentControl.selectedIndex =  segmentControl.selectedIndex - 1;
            self.segmentValueChanged(segmentControl)
        }
    }
    @IBAction func swipeLeft(_ sender: Any){
        
        if segmentControl.selectedIndex < 4{
            segmentControl.selectedIndex =  segmentControl.selectedIndex + 1;
            self.segmentValueChanged(segmentControl)
        }
        
    }
    
    @IBAction func buttonAction(_sender : Any)
    {
        retryButton.isHidden = true
        isRetry = true
        socketController.didConnect()
    }
    
    func getString(_ tag: Int) -> String? {
        switch tag {
        case 0:
            return "ALPHA"
        case 1:
            return "NUMERIC"
        case 2:
            return "COLOR"
        case 3:
            return "SHAPE"
        case 4:
            return "YESNO"
        default:
            return "ALPHA"
        }
    }
    
    func getNumberString(_ tag: String) -> String? {
        switch tag {
        case "one":
            return "1"
        case "two":
            return "2"
        case "three":
            return "3"
        case "four":
            return "4"
        case "five":
            return "5"
        case "six":
            return "6"
        default:
            return tag
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tempList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath as IndexPath) as! CollectionViewCell
        print("\(self.tempList[indexPath.item])")
        cell.imageOfBox.image = UIImage().getAssetImage(assetIdentifier: "\(self.tempList[indexPath.item])")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if socketController.isSocketConnected().boolValue{
            
            print("You selected cell #\(indexPath.item)!")
            let type:String? = self.getString(self.segmentControl.selectedIndex)
            let input:String? = self.getNumberString(self.tempList[indexPath.item])
            
            
            let myDictOfDict:NSDictionary = [
                "type" : type!, "input" : input!
            ]
            print("print dictionary....")
            //print(myDictOfDict)
            socketController.sendDataToServer(message: myDictOfDict)
            self.submitViewController.ackText = "\(type!):\(input!)"
            self.present(self.submitViewController, animated: true, completion: nil)
        }
        else
        {
            print("socket not connected")
            let alertViewController = UIAlertController(title: "Failed!", message:errorMsg , preferredStyle:.alert);
            let okAction = UIAlertAction(title:"Ok", style:.default, handler:{(action:UIAlertAction!) in
                print("you have pressed the ok button")
            });
            alertViewController.addAction(okAction);
            self.present(alertViewController, animated: true) {
                print("Presented.....");
            }
        }
    }
 /*   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
    }*/
    
    func socketDidErrorEvent(string: String?) {
        print("socket error")
        if self.isRetry {
            self.retryToEstablishConnection()
        }else{
            self.retryButton.isHidden = false
            self.statusLabel.text = "DISCONNECTED"
            self.statusImage.image = UIImage().getAssetImage(assetIdentifier: "notconnected")
        }
        self.errorMsg = string!
    }
    func socketDidConnectEvent(string: String?) {
        print("socket connected")
        ViewController.numberOfAttempt = 0
        self.isRetry = false
        self.statusLabel.text = "CONNECTED"
        self.retryButton.isHidden = true
        self.statusImage.image = UIImage().getAssetImage(assetIdentifier: "connected")
        self.retryButton.isHidden = true
    }
    func socketDidDisconnectEvent(string: String?) {
        print("socket disconnected")
        
        if self.isRetry {
            self.retryToEstablishConnection()
        }else{
            self.retryButton.isHidden = false
            self.statusLabel.text = "DISCONNECTED"
            self.statusImage.image = UIImage().getAssetImage(assetIdentifier: "notconnected")
        }
        self.errorMsg = string!
    }
}


