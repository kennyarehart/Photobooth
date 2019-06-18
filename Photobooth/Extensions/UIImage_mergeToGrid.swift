//
//  UIImage_mergeToGrid.swift
//  Photobooth
//
//  Created by Kenny Arehart on 6/13/19.
//  Copyright © 2019 Kenny Arehart. All rights reserved.
//

import UIKit

extension UIImage {
    func mergeToGrid(images: [UIImage]) -> UIImage {
        let first = images[0]
        let newWidth = first.size.width * 2
        let newHeight = first.size.height * 2
        let newSize = CGSize(width: newWidth, height: newHeight)
        print(newWidth, "x", newHeight, "|", newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        // background color first
        UIColor.gray.setFill()
        UIRectFill(CGRect(x:0, y: 0, width:newWidth, height:newHeight))
        
        // add each image
        for (index, element) in images.enumerated() {
            let x = CGFloat(index % 2) * first.size.width
            let y = floor(CGFloat(index) / 2) * first.size.height
            element.draw(in: CGRect(origin: CGPoint(x: Double(x), y: Double(y)), size: first.size))
        }
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
