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
        let newWidth = 1606.0 // 1515.0 //first.size.width * 2
        let newHeight = 1100.0 // 1010.0 //first.size.height * 2
        let newSize = CGSize(width: newWidth, height: newHeight)
        print(newWidth, "x", newHeight, "|", newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        // background color first
        UIColor.gray.setFill()
        UIRectFill(CGRect(x:0, y: 0, width:newWidth, height:newHeight))
        
        let bgImage = UIImage(named: "photobooth_bg_white")
        bgImage!.draw(in: CGRect(x:0.0, y:0.0, width: newWidth, height: newHeight))
        
        // add each image
        for (index, element) in images.enumerated() {
            let xIndex = CGFloat(index % 2)
            let x = xIndex * first.size.width + (xIndex + 1) * 25.0 + 44.0
            let yIndex = floor(CGFloat(index) / 2)
            let y = yIndex * first.size.height + (yIndex + 1) * 17.0 + 44.0
            print(xIndex, yIndex, "|", xIndex, yIndex)
            element.draw(in: CGRect(origin: CGPoint(x: Double(x), y: Double(y)), size: first.size))
        }
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
