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
        case imageDisplay(inputData: InputData)
    }
    
    var stackableItems: [ImageDisplayModel.StackableItem]! {
        guard let image = UIImage(named: "hanny-naibaho") else { return [] }
        NASAAPIClient().getNASAImage()
        return [StackableItem.imageDisplay(inputData: InputData(title: "blah", image: image))]
    }
}

extension ImageDisplayModel {
    

}

