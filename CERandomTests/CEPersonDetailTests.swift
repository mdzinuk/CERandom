//
//  CEPersonDetailTests.swift
//  CERandomTests
//
//  Created by Mohammad Arafat Hossain on 21/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import XCTest

final class CEPersonDetailTests: CEBaseTestCase {
    func testDownloadLargeImage() {
        CEPersonDetailViewModel(service)
            .getLargeImage(from: "") { (image: UIImage?) in
                guard let pic = image else {
                    XCTFail()
                    return
                }
                XCTAssertNotNil(pic)
        }
    }
}
