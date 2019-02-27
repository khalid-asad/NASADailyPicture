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
    
    private var defaultImage = UIImage(named: "playbutton")
    
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
            case .video(let url):
                addVideo(url: url)
            case .image(let image):
                addImageToBeDisplayed(image: image)
            case .date(let date):
                addDate(date: date)
            case .title(let title):
                addTitle(title: title)
            case .explanation(let explanation):
                addExplanation(explanation: explanation)
            }
        }
    }
    
    private func addDate(date: String?) {
        
    }
    
    private func addVideo(url: String?) {
        let videoDisplayView = ImageDisplayView.create(image: defaultImage)
        stackView.addArrangedSubview(UIView.createView(withSubview: videoDisplayView, edgeInsets: .zero))
        
        videoDisplayView.didTapImage = { (newImageView) in
            // open youtube
        }
    }
    
    private func addImageToBeDisplayed(image: UIImage?) {
        let imageDisplayView = ImageDisplayView.create(image: image)
        stackView.addArrangedSubview(UIView.createView(withSubview: imageDisplayView, edgeInsets: .zero))
        
        imageDisplayView.didTapImage = { (newImageView) in
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissFullscreenImage))
            newImageView.addGestureRecognizer(tap)
            UIView.animate(withDuration: 0.35) {
                self.view.addSubview(newImageView)
            }
            self.navigationController?.isNavigationBarHidden = true
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    private func addTitle(title: String?) {
        
    }
    
    private func addExplanation(explanation: String?) {
        
    }
    

    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        UIView.animate(withDuration: 0.35) {
            sender.view?.removeFromSuperview()
        }
    }
}

