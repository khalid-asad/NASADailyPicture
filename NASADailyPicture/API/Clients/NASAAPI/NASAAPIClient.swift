//
//  NASAAPIClient.swift
//  NASADailyPicture
//
//  Created by Khalid Asad on 2019-02-26.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation
import UIKit

public typealias ResponseData = (date: String?, explanation: String?, mediaType: String?, serviceVersion: String?, title: String?, url: URL?)

struct NasaAPIResponse: Codable {
    var date: String?
    var explanation: String?
    var mediaType: String?
    var serviceVersion: String?
    var title: String?
    var url: URL?
    
    enum CodingKeys: String, CodingKey {
        case date
        case explanation
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title
        case url
    }
    
    static func fetchData(completionHandler: @escaping (NasaAPIResponse?, Error?) -> Void) -> Void {
        #warning("Move this key to info plist")
        let clientKey = "NNKOjkoul8n1CH18TWA9gwngW1s1SmjESPjNoUFo"
//        let clientKey = "HsOIijCrXICAmzeyai7MeVz2x8tNPZEBxuQ4mpn9"
        guard let nasaUrl = URL(string: "https://api.nasa.gov/planetary/apod?api_key=" + clientKey) else { return }
        
        URLSession.shared.dataTask(with: nasaUrl) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(NasaAPIResponse.self, from: data)
                
                completionHandler(responseData, nil)
                return
            } catch let err {
                print("Err", err)
                completionHandler(nil, error)
                return
            }
            }.resume()
    }
}

final class NASAAPIClient {

    
    func fetch() -> ResponseData {
        var responseInfo = ResponseData(date: nil, explanation: nil, mediaType: nil, serviceVersion: nil, title: nil, url: nil)
        
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
            
            responseInfo.date = data.date
            responseInfo.explanation = data.explanation
            responseInfo.mediaType = data.mediaType
            responseInfo.serviceVersion = data.serviceVersion
            responseInfo.title = data.title
            responseInfo.url = data.url
            return
        })
        return responseInfo
    }
    
    static func downloadImage(inputURL: URL?, completion: @escaping(Bool, UIImage?) -> ()) {
        guard let url = inputURL else { return }
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
