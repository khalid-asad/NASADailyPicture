//
//  ImageDisplayModel.swift
//  NASADailyPicture
//
//  Created by Khalid Asad on 2019-02-26.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation
import UIKit

struct ImageDisplayModel {
    
    // MARK: - ItemStackable
    enum StackableItem {
        case date(date: String?)
        case video(url: String?)
        case image(image: UIImage?)
        case title(title: String?)
        case explanation(explanation: String?)
    }
    
    var stackableItems: [ImageDisplayModel.StackableItem]! {
        //guard let image = UIImage(named: "hanny-naibaho") else { return [] }
        
        var items: [StackableItem] = []
        
        let response = NASAAPIClient().getNASAAPIData()
        
        if let date = response.date {
            items.append(.date(date: date))
        }
        
        if let mediaType = response.mediaType, let url = response.url {
            if mediaType == "video" {
                items.append(.video(url: url))
            } else if mediaType == "image" {
                //download image
                //items.append(.image(url: image))
            }
        }
        
        if let title = response.title {
            items.append(.title(title: title))
        }
        
        if let explanation = response.explanation {
            items.append(.explanation(explanation: explanation))
        }
        
        return items
    }
}

extension ImageDisplayModel {
    

}

