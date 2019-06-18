//
//  CountdownViewController.swift
//  Custom Camera
//
//  Created by Kenny Arehart on 6/11/19.
//  Copyright © 2019 Kenny Arehart. All rights reserved.
//

import UIKit

let myNotificationKey = "com.kennyarehart.notificationKey"

class CountdownViewController: UIViewController {

    var timer: Timer?
    var clockCount = 3
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = ""
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(doThisWhenNotify),
                                               name: NSNotification.Name(rawValue: myNotificationKey),
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startButton.isHidden = false
    }
    
    @objc func doThisWhenNotify() { print("I've sent a spark!") }
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func startTimer(_ sender: UIButton) {
        sender.isHidden = true
        print("startTimer()")
        clockCount = 3
        totalCount = 0
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
        clockCount -= 1
        updateLabel()
        print("loop", clockCount)
        if clockCount == 0 {
            totalCount += 1
            NotificationCenter.default.post(name: Notification.Name(rawValue: myNotificationKey), object: self)
            if totalCount < 4 {
                clockCount = 4
            } else {
                stopTimer()
            }
        }
    }
    
    func updateLabel() {        
        timeLabel.text = clockCount == 0 ? "" : String(clockCount)
    }
}
