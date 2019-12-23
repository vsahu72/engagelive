//
//  SocketController.swift
//
//
//  Created by admin10.10 on 05/07/18.
//

import UIKit
import SystemConfiguration
import SocketIO

@objc  protocol SocketControllerDelegate{
    @objc optional func socketDidConnectEvent(string: String?)
    @objc optional func socketDidDisconnectEvent(string: String?)
    @objc optional func socketDidErrorEvent(string: String?)
    @objc optional func applicationIsActive(isAppActive : ObjCBool)
}

class SocketController {
    
    let WEB_Socket = "https://ee.vnumedia.app/"
    var socket:SocketIOClient!
    var socketManager:SocketManager!
    var delegate: SocketControllerDelegate?
    
    init() {
        self.establishSocketConnection()
    }
    
    func establishSocketConnection() {
        self.socketManager = SocketManager(socketURL: URL(string: WEB_Socket)!, config: [.log(true), .compress])
        self.socket = self.socketManager.defaultSocket
        self.handleEvent()
        
    }
    
    func didConnect()  {
        socket.connect()
    }
    
    func getCopyrightString() -> String {
        
        let date = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: date)
        let copyrightString = "POWERED BY VNU COPYRIGHT \(String(currentYear))"
       // print("Current year...\(currentYear)")
        return copyrightString
    }
    
    func handleEvent(){
        self.socket.on(clientEvent: .connect) {data, ack in
              print("@@@@@@@@ SERVER CONNECTED @@@@@@@@@")
            if self.delegate is ViewController {
                self.delegate?.socketDidConnectEvent!(string:self.getStringFromData(data: data))
            }
        }
        self.socket.on(clientEvent: .disconnect) {data, ack in
              print("@@@@@@@@ SERVER DISCONNECTED @@@@@@@@@")
            if (self.delegate is ViewController) {
                self.delegate?.socketDidDisconnectEvent!(string:self.getStringFromData(data: data))
            }
            
            
        }
        self.socket.on(clientEvent: .error) {data, ack in
              print("@@@@@@@@ SERVER ERROR @@@@@@@@@")
            if (self.delegate is ViewController) {
                self.delegate?.socketDidErrorEvent!(string:self.getStringFromData(data: data))
            }
        }
        socket.on("is_active") { (data, ack) in
           
            if self.getStringFromData(data: data) == "1"{ // If false then exit message
                print("@@@@@@@@ SERVER ACTIVE @@@@@@@@@")
                if (self.delegate is SplashViewController) {
                    self.delegate?.applicationIsActive!(isAppActive:true)
                }
            }else{
                
                 print("@@@@@@@@ SERVER NOT ACTIVE @@@@@@@@@")
                if (self.delegate is SplashViewController) {
                    self.delegate?.applicationIsActive!(isAppActive:false)
                }
            }
        }
    }
    
    func sendDataToServer(message: NSDictionary) {
        self.socket.emitWithAck("mobile_data",message).timingOut(after: 0.5) {data in
            print(data.description)
        }
    }
    
    func isSocketConnected() -> ObjCBool {
        if socket.status == SocketIOStatus.connected{
            return true
        }
        return false
    }
    
    func getStringFromData(data:[Any]) -> String {
        let characterSet = CharacterSet(charactersIn: "[\"]")
        return data.description.trimmingCharacters(in: characterSet)//.replacingOccurrences(of: "\"", with: "")
    }
}

