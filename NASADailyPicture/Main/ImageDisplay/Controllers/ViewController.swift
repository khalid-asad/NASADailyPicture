//
//  ViewController.swift
//  NASADailyPicture
//
//  Created by Khalid Asad on 2019-02-26.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    private var model: ImageDisplayModel!
    
    private var didTapAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = ImageDisplayModel()
        
        configureStackView()
    }
}

extension ViewController {
    
    private func configureStackView() {
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        guard let items = model.stackableItems else { return }
        items.forEach {
            switch $0 {
            case .imageDisplay(let inputData):
                addImageToBeDisplayed(inputData: inputData)
            }
        }
    }
    
    private func addImageToBeDisplayed(inputData: InputData) {
        let imageDisplayView = ImageDisplayView.create(inputData: inputData)
        stackView.addArrangedSubview(UIView.createView(withSubview: imageDisplayView, edgeInsets: .zero))
        
        imageDisplayView.didTapImage = { (newImageView) in
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissFullscreenImage))
            newImageView.addGestureRecognizer(tap)
            self.view.addSubview(newImageView)
            self.navigationController?.isNavigationBarHidden = true
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}

