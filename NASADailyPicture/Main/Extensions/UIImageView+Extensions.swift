//
//  UIImageView+Extensions.swift
//  NASADailyPicture
//
//  Created by Khalid Asad on 2019-02-26.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setAutoScaledImage(inputImage: UIImage?, widthConstraint: NSLayoutConstraint, heightConstraint: NSLayoutConstraint) {
        if let inputImage = inputImage {
            let frameWidth = frame.size.width
            let frameHeight = frame.size.height
            let imageWidth = inputImage.size.width
            let imageHeight = inputImage.size.height
            let heightRatio = frameWidth / imageWidth
            let widthRatio = frameHeight / imageHeight
            
            image = inputImage
            
//            if frameWidth < imageWidth {
//                heightConstraint.constant = heightRatio * imageHeight
//            }
            
            if frameHeight < imageHeight {
                widthConstraint.constant = widthRatio * imageHeight
            }
        }
    }
}
