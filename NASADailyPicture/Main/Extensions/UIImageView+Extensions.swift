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
            let imageWidth = inputImage.size.width
            let imageHeight = inputImage.size.height
            let imageRatio = imageHeight / imageWidth

            image = inputImage
            widthConstraint.constant = heightConstraint.constant / imageRatio
        }
    }
}
