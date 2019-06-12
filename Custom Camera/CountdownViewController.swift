//
//  CountdownViewController.swift
//  Custom Camera
//
//  Created by Kenny Arehart on 6/11/19.
//  Copyright © 2019 Kenny Arehart. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {

    var timer: Timer?
    var count = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
        }
    }
    
    func updateLabel() {
        timeLabel.text = String(count)
    }

}
