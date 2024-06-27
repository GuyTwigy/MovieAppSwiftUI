//
//  GetTrailerProtocolTests.swift
//  MovieAppSwiftUITests
//
//  Created by Guy Twig on 27/06/2024.
//

import XCTest
@testable import MovieAppSwiftUI

final class GetTrailerProtocolTests: XCTestCase {

    var dataService: GetTrailerProtocol?
    
    override func setUpWithError() throws {
        dataService = NetworkManager()
    }
    
    override func tearDownWithError() throws {
        dataService = nil
    }
    
    func test_NetworkManager_fetchSingleSuggestionSuccess() async throws {
        // Given
        let id = "1817"
        
        // When
        let expectation = self.expectation(description: "Fetch Single Suggestion with Success")
        do {
            let videoData = try await dataService?.getTrailer(id: id)
            expectation.fulfill()
            
            //Then
            XCTAssertNotNil(videoData)
            XCTAssertNotNil(videoData?.first?.key)
            XCTAssertNotNil(videoData?.first?.type)
        } catch {
            XCTFail()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0, enforceOrder: true)
    }
}
