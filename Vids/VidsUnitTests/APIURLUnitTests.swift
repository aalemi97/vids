//
//  APIURLUnitTests.swift.swift
//  VidsUnitTests
//
//  Created by AliReza on 2024-06-16.
//

import XCTest
@testable import Vids

final class APIURLUnitTests: XCTestCase {

    func test_videosEndpointURL_onLocalServer(){
        let endpoint = APIURL.videos
        let urlString = endpoint.generateURLString()
        let expectation = "http://localhost:4000/videos"
        XCTAssertEqual(urlString, expectation, "Videos endpoint url is expected to be: \(expectation) while it is: \(urlString)")
    }

}
