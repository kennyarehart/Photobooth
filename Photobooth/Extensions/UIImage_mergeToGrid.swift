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
        let bleed: CGFloat = 49.0
        let padding: CGFloat = 10.0
        let first = images[0]
        var newHeight = first.size.height * 2 + padding * 3
        var newWidth = newHeight * (6/4)
        newHeight += bleed * 2
        newWidth += bleed * 2
        print(newWidth, "x", newHeight)
        
        let newSize = CGSize(width: newWidth, height: newHeight)
//        print(newWidth, "x", newHeight, "|", newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        let bgImage = UIImage(named: "photobooth_bg_white")
        bgImage!.draw(in: CGRect(x:0.0, y:0.0, width: newWidth, height: newHeight))
        
        // add each image
        for (index, element) in images.enumerated() {
            let xIndex = CGFloat(index % 2)
            let x = xIndex * first.size.width + (xIndex + 1) * padding + bleed + padding
            let yIndex = floor(CGFloat(index) / 2)
            let y = yIndex * first.size.height + (yIndex + 1) * padding + bleed
            print(xIndex, yIndex, "|", xIndex, yIndex)
            element.draw(in: CGRect(origin: CGPoint(x: Double(x), y: Double(y)), size: first.size))
        }
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func mergeToGridOnly(images: [UIImage], isPreview: Bool) -> UIImage {
        let padding:CGFloat = isPreview ? 5.0 : 10.0
        let first = images[0]
        let newWidth = first.size.width * 2 + padding * 3
        let newHeight = first.size.height * 2 + padding * 3
        let newSize = CGSize(width: newWidth, height: newHeight)
        //        print(newWidth, "x", newHeight, "|", newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        if isPreview {
            // background color first
            UIColor.white.setFill()
            UIRectFill(CGRect(x:0, y: 0, width:newWidth, height:newHeight))
        }
        
        // add each image
        for (index, element) in images.enumerated() {
            let xIndex = CGFloat(index % 2)
            let x = xIndex * (first.size.width + padding) + padding
            let yIndex = floor(CGFloat(index) / 2)
            let y = yIndex * (first.size.height + padding) + padding
//            print(xIndex, yIndex, "|", xIndex, yIndex)
            element.draw(in: CGRect(origin: CGPoint(x: Double(x), y: Double(y)), size: first.size))
        }
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func applyBg(image: UIImage) -> UIImage {
        return image
    }
}
