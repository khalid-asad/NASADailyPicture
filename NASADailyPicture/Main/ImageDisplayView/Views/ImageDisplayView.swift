//
//  ImageDisplayView.swift
//  NASADailyPicture
//
//  Created by Khalid Asad on 2019-02-26.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation
import UIKit

typealias InputData = (title: String, image: String)

final class ImageDisplayView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dailyImageView: UIImageView!
    
    private var isExpanded: Bool = false
    
    var didTapImage: ((UIView) -> Void)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        titleLabel.textColor = UIColor.black
    }
}

// MARK: - Internal Methods
extension ImageDisplayView {
    
    static func create(inputData: InputData) -> ImageDisplayView {
        let view: ImageDisplayView = .fromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(inputData: inputData)
        return view
    }
}

// MARK: - Private Methods
extension ImageDisplayView {
    
    private func configure(inputData: InputData) {
        titleLabel.configure(text: postInformation.title)
        dailyImageView.setAutoScaledImage(inputImage: postInformation.postImage, widthConstraint: postImageWidth, heightConstraint: postImageHeight)
    }
}

// MARK: - IBActions
extension ImageDisplayView {
    
    @IBAction func didTapImage(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        didTapImage?(newImageView)
    }
    
    
}
