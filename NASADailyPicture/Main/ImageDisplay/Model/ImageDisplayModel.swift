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
        case video(url: URL?)
        case image(image: UIImage?)
        case date(date: String?)
        case title(title: String?)
        case explanation(explanation: String?)
    }
    
    var stackableItems: [ImageDisplayModel.StackableItem]! {
        fetch() { stackItems in
            return stackItems
        }
        return []
    }
    
    func fetch(completion: @escaping ([ImageDisplayModel.StackableItem]) -> ()) {
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
            
            if let mediaType = data.mediaType {
                print(mediaType)
                if mediaType == "video" {
                    items.append(.video(url: data.url))
                } else if mediaType == "image" {
                    NASAAPIClient.downloadImage(inputURL: data.url, completion: { (success, image) in
                        if !success {
                            print("Error: Image not downloaded.")
                        } else {
                            items.append(.image(image: image))
                        }
                    })
                }
            }
            
            if let date = data.date {
                print(date)
                items.append(.date(date: date))
            }
            
            if let title = data.title {
                print(title)
                items.append(.title(title: title))
            }
            
            if let explanation = data.explanation {
                print(explanation)
                items.append(.explanation(explanation: explanation))
            }
            completion(items)
        })
        completion(items)
    }
}
