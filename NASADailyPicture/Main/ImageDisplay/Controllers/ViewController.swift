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
        
        fetchData()
    }
}

extension ViewController {
    
    func fetchData(_ complete: (() -> Void)? = nil) {
        model.fetchData(completion: { [unowned self] status in
            switch status {
            case .success:
                DispatchQueue.main.async {
                    self.configureStackView(items: self.model.stackableItems)
                }
            default:
                break;
            }
        })
    }
}

extension ViewController {
    
    private func configureStackView(items: [ImageDisplayModel.StackableItem]) {
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        items.forEach {
            switch $0 {
            case .video(let url, let date, let title, let explanation):
                self.addVideo(url: url, date: date, title: title, explanation: explanation)
            case .image(let image, let date, let title, let explanation):
                self.addImageToBeDisplayed(image: image, date: date, title: title, explanation: explanation)
            }
        }
    }
    
    private func addVideo(url: URL?, date: String?, title: String?, explanation: String?) {
        let videoDisplayView = ImageDisplayView.create(image: defaultImage, date: date, title: title, description: explanation)
        stackView.addArrangedSubview(UIView.createView(withSubview: videoDisplayView, edgeInsets: .zero))
        
        videoDisplayView.didTapImage = { (newImageView) in
            guard let url = url else { return }
            UIApplication.shared.open(url)
        }
    }
    
    private func addImageToBeDisplayed(image: UIImage?, date: String?, title: String?, explanation: String?) {
        let imageDisplayView = ImageDisplayView.create(image: image, date: date, title: title, description: explanation)
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

    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        UIView.animate(withDuration: 0.35) {
            sender.view?.removeFromSuperview()
        }
    }
}

