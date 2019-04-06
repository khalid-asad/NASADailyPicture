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
    var hdurl: URL?
    var mediaType: String?
    var serviceVersion: String?
    var title: String?
    var url: URL?
    
    enum CodingKeys: String, CodingKey {
        case date
        case explanation
        case hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title
        case url
    }
    
    static func fetchData(completionHandler: @escaping (NasaAPIResponse?, Error?) -> Void) {
        #warning("Move this into the cloud")
//        let clientKey = "NNKOjkoul8n1CH18TWA9gwngW1s1SmjESPjNoUFo"
        let clientKey = "HsOIijCrXICAmzeyai7MeVz2x8tNPZEBxuQ4mpn9"
        guard let nasaUrl = URL(string: "https://api.nasa.gov/planetary/apod?api_key=" + clientKey) else { return }
        
        URLSession.shared.dataTask(with: nasaUrl) { (data, response, error) in
            guard let data = data else { return }
            print("Data: ")
            print(data)
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(NasaAPIResponse.self, from: data)
                print(responseData)
                completionHandler(responseData, nil)
            } catch let err {
                print("Err", err)
                completionHandler(nil, error)
            }
            }.resume()
    }
}

final class NASAAPIClient {
    
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
}
