//
//  TrailerViewModelTests.swift
//  MovieAppSwiftUITests
//
//  Created by Guy Twig on 27/06/2024.
//

import XCTest
@testable import MovieAppSwiftUI

@MainActor
final class TrailerViewModelTests: XCTestCase {

    var vm: TrailerViewModel?
    var dataService: GetTrailerProtocol?
    
    override func setUpWithError() throws {
        dataService = NetworkManager()
        vm = TrailerViewModel(videoKey: "PLl99DlL6b4")
    }
    
    override func tearDownWithError() throws {
        vm = nil
        dataService = nil
    }
    
    func test_TrailerVMTests_getTrailer() async {
        //given
        let expectation = self.expectation(description: "Get Trailer")
        do {
            let videoData = try await dataService?.getTrailer(id: "1817")
            expectation.fulfill()
            XCTAssertNotNil(videoData)
            XCTAssertNotNil(videoData?.first?.key)
            XCTAssertNotNil(videoData?.first?.type)
            
            //when
            let urlString = "https://www.youtube.com/embed/\(videoData?.first?.key ?? "")"
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                //then
                XCTAssertNotNil(request)
            }
        } catch {
            XCTFail()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0,  enforceOrder: true)
    }
    
    func test_TrailerVMTests_loadVideo() async {
        //given
        vm?.request = nil
        
        //when
        vm?.loadVideo()
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else {
                XCTFail()
                return
            }
            
            XCTAssertNotNil(vm?.request)
            XCTAssertFalse(vm?.showError ?? true)
            
        }
    }
}
