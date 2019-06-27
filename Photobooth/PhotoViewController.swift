//
//  PhotoViewController.swift
//  Custom Camera
//
//  Created by Kenny Arehart on 6/11/19.
//  Copyright © 2019 Kenny Arehart. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

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
        
        
        if let availableImage = printPhoto {
            imageView.image = availableImage
        }
    }
    
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
