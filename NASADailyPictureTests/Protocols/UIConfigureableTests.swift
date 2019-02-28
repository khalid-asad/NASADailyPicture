//
//  UIConfigureableTests.swift
//  NASADailyPictureTests
//
//  Created by Khalid Asad on 2019-02-27.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import XCTest
import Foundation
@testable import NASADailyPicture

class UIConfigureableTests: NASADailyPictureTests {
    
    func testUILabelIsHidden() {
        // Given nil text for label
        let label = UILabel()
        label.configure(text: nil)
        
        // Then label should be hidden
        XCTAssertTrue(label.isHidden)
        XCTAssertNil(label.text)
    }
    
    func testUILabelIsNotHidden() {
        // Given nil text for label
        let label = UILabel()
        label.configure(text: "Random Text")
        
        // Then label should not be hidden
        XCTAssertFalse(label.isHidden)
        XCTAssertNotNil(label.text)
    }
    
    func testImageIsHidden() {
        // Given UIImage
        let imageView = UIImageView()
        imageView.configure(image: nil)
        
        // Then image should be hidden
        XCTAssertTrue(imageView.isHidden)
        XCTAssertNil(imageView.image)
    }
    
    func testImageIsNotHidden() {
        // Given UIImage
        let imageView = UIImageView()
        imageView.configure(image: UIImage(named: "hanny-naibaho"))
        
        // Then image should not be hidden
        XCTAssertFalse(imageView.isHidden)
        XCTAssertNotNil(imageView.image)
    }
}
