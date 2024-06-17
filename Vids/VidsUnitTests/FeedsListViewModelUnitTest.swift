//
//  FeedsListViewModelUnitTest.swift
//  VidsUnitTests
//
//  Created by AliReza on 2024-06-16.
//

import XCTest
import Combine
@testable import Vids

final class FeedsListViewModelUnitTest: XCTestCase {
    
    private var viewModel: FeedsListViewModel?
    private var cancellableSet = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        viewModel = FeedsListViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_videosCount_shouldEqualToTwo() {
        viewModel?.getVideos()
        let expectation = XCTestExpectation(description: "Check existance of videos!")
        viewModel?.$videos
            .dropFirst()
            .sink(receiveValue: { videos in
            XCTAssertEqual(videos.count, 2)
            expectation.fulfill()
        }).store(in: &cancellableSet)
        wait(for: [expectation], timeout: 20)
    }
    
}
