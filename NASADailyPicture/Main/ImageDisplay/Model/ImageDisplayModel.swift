//
//  ImageDisplayModel.swift
//  NASADailyPicture
//
//  Created by Khalid Asad on 2019-02-26.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation
import UIKit

final class ImageDisplayModel {
    
    // MARK: - ItemStackable
    enum StackableItem {
        case video(url: URL?, date: String?, title: String?, explanation: String?)
        case image(image: UIImage?, date: String?, title: String?, explanation: String?)
    }
    
    var stackableItems: [ImageDisplayModel.StackableItem] = []
}

extension ImageDisplayModel {
    
    enum FetchInfoState {
        case fetching
        case success
        case failure
    }
    
    func fetchData(completion: @escaping ((FetchInfoState) -> Void)) {
        NasaAPIResponse.fetchData(completionHandler: { (data, error) in
            if let error = error {
                print("Error: ")
                print(error)
                completion(.failure)
                return
            }
            guard let data = data else {
                print("Error getting data: result is nil")
                completion(.failure)
                return
            }
                        
            if let mediaType = data.mediaType, let url = data.url, let date = data.date, let title = data.title, let explanation = data.explanation {
                print(mediaType)
                if mediaType == "video" {
                    self.stackableItems.append(.video(url: url, date: date, title: title, explanation: explanation))
                    completion(.success)
                    return
                } else if mediaType == "image" {
                    NASAAPIClient.downloadImage(inputURL: url, completion: { (success, image) in
                        if !success {
                            print("Error: Image not downloaded.")
                            completion(.failure)
                        } else {
                            self.stackableItems.append(.image(image: image, date: date, title: title, explanation: explanation))
                            completion(.success)
                        }
                    })
                    return
                }
            }
        })
    }
}
