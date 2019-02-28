//
//  ImageDisplayView.swift
//  NASADailyPicture
//
//  Created by Khalid Asad on 2019-02-26.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation
import UIKit

final class ImageDisplayView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dailyImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    
    private var isExpanded: Bool = false
    
    var didTapImage: ((UIView) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        descriptionLabel.font = UIFont(name: "HelveticaNeue", size: 16)
        dateLabel.font = UIFont(name: "HelveticaNeue", size: 16)
        [titleLabel, descriptionLabel, dateLabel].forEach() {
            $0.textColor = UIColor.black
        }
        
    }
}

// MARK: - Internal Methods
extension ImageDisplayView {
    
    static func create(image: UIImage?, date: String?, title: String?, description: String?) -> ImageDisplayView {
        let view: ImageDisplayView = .fromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(image: image, date: date, title: title, description: description)
        return view
    }
}

// MARK: - Private Methods
extension ImageDisplayView {
    
    private func configure(image: UIImage?, date: String?, title: String?, description: String?) {
        dateLabel.configure(text: date)
        titleLabel.configure(text: title)
        descriptionLabel.configure(text: description)
        imageHeightConstraint.constant = UIScreen.main.bounds.height/2
        dailyImageView.setAutoScaledImage(inputImage: image, widthConstraint: imageWidthConstraint, heightConstraint: imageHeightConstraint)
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
