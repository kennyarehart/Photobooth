//
//  PhotoViewController.swift
//  Custom Camera
//
//  Created by Kenny Arehart on 6/11/19.
//  Copyright © 2019 Kenny Arehart. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    var printTotal = 1
    var printPhoto:UIImage?
    var previewPhoto:UIImage? 
   
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var printCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // should immediately save
        UIImageWriteToSavedPhotosAlbum(printPhoto!, nil, nil, nil)
        
        printTotal = 1
        
        if let availableImage = previewPhoto {
            imageView.image = availableImage
        }
    }
    @IBAction func printCountChange(_ sender: Any) {
        printTotal += 1
        if printTotal == 4 {
            printTotal = 1
        }
        printCountLabel.text = String(printTotal)
    }
    
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func printAndExit(_ sender: Any) {
        runPrintJob()
        exit(self)
    }
    
    func runPrintJob() {
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.jobName = "My Print Job"
        printInfo.outputType = .photo
            
        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo
        
        printController.showsNumberOfCopies = false
        printController.printingItem = printPhoto
        
        //Wi-Fi is connected to TP-LINK_Extender_873053 and has the IP address 192.168.0.100.
        // If you want to specify a printer
//        guard let printerURL = URL(string: "Your printer URL here, e.g. ipps://HPDC4A3E0DE24A.local.:443/ipp/print") else { return }
//        guard let currentPrinter = UIPrinter(url: printerURL) else { return }
//        printController.print(to: <#T##UIPrinter#>, completionHandler: <#T##UIPrintInteractionController.CompletionHandler?##UIPrintInteractionController.CompletionHandler?##(UIPrintInteractionController, Bool, Error?) -> Void#>)
        
        // shows the printer prompt
        printController.present(animated:true, completionHandler: nil)
    }

}
