//
//  NASAAPIClient.swift
//  NASADailyPicture
//
//  Created by Khalid Asad on 2019-02-26.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation
import UIKit

public typealias ResponseData = (date: String?, explanation: String?, mediaType: String?, serviceVersion: String?, title: String?, url: String?)

final class NASAAPIClient {
    
    private static func get(with completion: @escaping ([String : Any]) -> ()) {
//        let clientKey = "NNKOjkoul8n1CH18TWA9gwngW1s1SmjESPjNoUFo"
        let clientKey = "HsOIijCrXICAmzeyai7MeVz2x8tNPZEBxuQ4mpn9"
        let urlWithKey = URL(string: "https://api.nasa.gov/planetary/apod?api_key=" + clientKey)
        guard let url = urlWithKey else { return }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                if let response = response {
                    print(response)
                    completion(response)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    private static func downloadImage(urlString: String, completion: @escaping(Bool, UIImage?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else {
                completion (false, nil)
                return
            }
            completion(true, image)
        }
        task.resume()
    }
    
    public func getNASAAPIData() -> ResponseData {
        var date: String?
        var explanation: String?
        var mediaType: String?
        var serviceVersion: String?
        var title: String?
        var url: String?
        
        NASAAPIClient.get { (data) in
            for (key, value) in data {
                print("\(key) - \(value) ")
            }
            
            if let dateResponse = data["date"] as? String {
                date = dateResponse
            }
            
            if let explanationResponse = data["explanation"] as? String {
                explanation = explanationResponse
            }
            
            if let mediaTypeResponse = data["media_type"] as? String {
                mediaType = mediaTypeResponse
//                if mediaType == "image" {
//                    NASAAPIClient.downloadImage(urlString: data["url"] as? String ?? "", completion: { (success, image) in
//                        if !success {
//                            print("Error: Image not downloaded.")
//                        }
//                    })
//                } else if mediaType == "video" {
//
//                }
            }
            
            if let serviceVersionResponse = data["serviceVersion"] as? String {
                serviceVersion = serviceVersionResponse
            }
            
            if let titleResponse = data["title"] as? String {
                title = titleResponse
            }
            
            if let urlResponse = data["url"] as? String {
                url = urlResponse
            }
        }
        return ResponseData(date: date, explanation: explanation, mediaType: mediaType, serviceVersion: serviceVersion, title: title, url: url)
    }
}
