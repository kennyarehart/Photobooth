//
//  CountdownViewController.swift
//  Custom Camera
//
//  Created by Kenny Arehart on 6/11/19.
//  Copyright © 2019 Kenny Arehart. All rights reserved.
//

import UIKit

let myNotificationKey = "com.bobthedeveloper.notificationKey"

class CountdownViewController: UIViewController {

    var timer: Timer?
    var count = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(doThisWhenNotify),
                                               name: NSNotification.Name(rawValue: myNotificationKey),
                                               object: nil)
    }
    
    @objc func doThisWhenNotify() { print("I've sent a spark!") }
   
    @IBAction func startTimer(_ sender: Any) {
        print("startTimer()")
        count = 3
        updateLabel()
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.loop), userInfo: nil, repeats: true)
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    
    func stopTimer() {
        print("stopTimer()")
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc func loop() {
        count -= 1
        updateLabel()
        print("loop", count)
        if count == 0 {
            stopTimer()
//            let screenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoVC") as! PhotoViewController
//            photoVC.takenPhoto = image
//            let otherViewController: ScreenViewController = ScreenViewController()
//            otherViewController.setTakePhoto()
            NotificationCenter.default.post(name: Notification.Name(rawValue: myNotificationKey), object: self)
        }
    }
    
    func updateLabel() {
        timeLabel.text = String(count)
    }

}
