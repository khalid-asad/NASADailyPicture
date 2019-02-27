//
//  UIConfigureable.swift
//  NASADailyPicture
//
//  Created by Khalid Asad on 2019-02-26.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation
import UIKit

public protocol UITextConfigureable {
    
    func configure(text: String?)
}

public protocol UIImageConfigureable {
    
    func configure(image: UIImage?)
}

extension UILabel: UITextConfigureable {
    
    public func configure(text: String?) {
        if let text = text {
            self.text = text
        } else {
            self.isHidden = true
        }
    }
}

extension UIImageView: UIImageConfigureable {
    
    public func configure(image: UIImage?) {
        if let image = image {
            self.image = image
        } else {
            self.isHidden = true
        }
    }
}
