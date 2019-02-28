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
        case video(url: URL?, date: String?, title: String?, explanation: String?)
        case image(image: UIImage?, date: String?, title: String?, explanation: String?)
    }
    
    var stackableItems: [ImageDisplayModel.StackableItem]! {
        var items: [StackableItem] = []
        
        NasaAPIResponse.fetchData(completionHandler: { (data, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else {
                print("Error getting first todo: result is nil")
                return
            }
            
            debugPrint(data)
            
            if let mediaType = data.mediaType, let url = data.url, let date = data.date, let title = data.title, let explanation = data.explanation {
                print(mediaType)
                if mediaType == "video" {
                    items.append(.video(url: url, date: date, title: title, explanation: explanation))
                } else if mediaType == "image" {
                    NASAAPIClient.downloadImage(inputURL: url, completion: { (success, image) in
                        if !success {
                            print("Error: Image not downloaded.")
                        } else {
                            items.append(.image(image: image, date: date, title: title, explanation: explanation))
                        }
                    })
                }
            }
        })
        #warning("REMOVE THIS - THIS IS BAD PRACTICE!!")
        sleep(3)
        return items
    }
}
