//
//  PhotoViewController.swift
//  Custom Camera
//
//  Created by Kenny Arehart on 6/11/19.
//  Copyright © 2019 Kenny Arehart. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    var takenPhoto:UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let availableImage = takenPhoto {
            imageView.image = availableImage
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(takenPhoto!, nil, nil, nil)
        self.dismiss(animated: true, completion: nil)
        printIt(img: takenPhoto)
    }
    
    func printIt(img:Any) {
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.jobName = "My Print Job"
        printInfo.outputType = .photo
            
        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo
        
        printController.showsNumberOfCopies = false
        printController.printingItem = img
        
        // If you want to specify a printer
//        guard let printerURL = URL(string: "Your printer URL here, e.g. ipps://HPDC4A3E0DE24A.local.:443/ipp/print") else { return }
//        guard let currentPrinter = UIPrinter(url: printerURL) else { return }
//        printController.print(to: <#T##UIPrinter#>, completionHandler: <#T##UIPrintInteractionController.CompletionHandler?##UIPrintInteractionController.CompletionHandler?##(UIPrintInteractionController, Bool, Error?) -> Void#>)
        printController.present(animated:true, completionHandler: nil)
        
    }

}
