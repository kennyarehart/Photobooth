//
//  CountdownViewController.swift
//  Custom Camera
//
//  Created by Kenny Arehart on 6/11/19.
//  Copyright © 2019 Kenny Arehart. All rights reserved.
//

import UIKit

//let myNotificationKey = "com.kennyarehart.notificationKey"

class CountdownViewController: UIViewController {

    var timer: Timer?
    var clockCount = 3
    var totalCount = 0
    var ogTransform: CGAffineTransform?
    var lgTransform: CGAffineTransform?
    var smallTransform: CGAffineTransform?
    var uiFlash: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = ""
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(doThisWhenNotify),
//                                               name: NSNotification.Name(rawValue: myNotificationKey),
//                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startButton.isHidden = false
        self.ogTransform = self.timeLabel.transform
        self.lgTransform = self.timeLabel.transform.scaledBy(x: 3.0, y: 3.0)
        self.smallTransform = self.timeLabel.transform.scaledBy(x: 0.5, y: 0.5)
        
        uiFlash = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        uiFlash!.backgroundColor = UIColor.white
        uiFlash!.alpha = 0
        
        // Add UIView as a Subview
        self.view.addSubview(self.uiFlash!)
        
        startButton.imageView?.contentMode = .scaleAspectFit
        let p:CGFloat = 0.68
        startButton.imageEdgeInsets = UIEdgeInsets.init(
            top: startButton.frame.size.height * p,
            left: startButton.frame.size.width * p,
            bottom: startButton.frame.size.height * p,
            right: startButton.frame.size.width * p)
        
    }
    
//    @objc func doThisWhenNotify() { print("I've sent a spark!") }
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func startTimer(_ sender: UIButton) {
        sender.isHidden = true
        print("startTimer()")
        clockCount = 5
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
            animFlash()
            NotificationCenter.default.post(name: Notification.Name(rawValue: keyCountdownLoop), object: self)
            if totalCount < 4 {
                clockCount = 4
            } else {
                stopTimer()
            }
        }
    }
    
    func updateLabel() {
        if clockCount > 3 {
            timeLabel.text = "<< Look Left"
        } else if clockCount == 0 {
            timeLabel.text = ""
        } else {
            timeLabel.text = String(clockCount)
        }
       
        if (clockCount > 0 && clockCount <= 4) {
            animLabel()
        }
    }
    
    func animLabel() {
        self.timeLabel.alpha = 1.0
        let currentTargetTransform = clockCount < 4 ? self.lgTransform : self.ogTransform
        let scaledTransform = currentTargetTransform!.scaledBy(x: 0.5, y: 0.5)
        self.timeLabel.transform = currentTargetTransform!
        UIView.animate(withDuration: 0.95, delay:0.0, options: .curveEaseIn, animations: {
            self.timeLabel.alpha = 0.0
            if self.clockCount <= 4 {
                self.timeLabel.transform = scaledTransform
            }
        })
    }
    
    func animFlash() {
        self.uiFlash!.alpha = 1
        UIView.animate(withDuration: 0.95, delay: 0.0, options: .curveEaseIn, animations: {
            self.uiFlash!.alpha = 0
        })
    }
}
