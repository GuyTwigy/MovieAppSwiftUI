//
//  NetworkManagerTests.swift
//  MovieAppSwiftUITests
//
//  Created by Guy Twig on 27/06/2024.
//

import XCTest
@testable import MovieAppSwiftUI

final class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager?
    var mockSession: MockURLSession?
    
    override func setUpWithError() throws {
        mockSession = MockURLSession()
        networkManager = NetworkManager()
        if let mockSession {
            networkManager?.setSession(session: mockSession)
        }
    }
    
    override func tearDownWithError() throws {
        networkManager = nil
        mockSession = nil
    }
    
    func testBadURL() async throws {
        //Given
        
        //Wenn
        do {
            _ = try await networkManager?.getRequestData(clearCache: false, components: nil, type: MovieData.self)
            XCTFail()
        } catch {
            //Tehn
            XCTAssertEqual(error as? URLError, URLError(.badURL))
        }
    }
    
    func test_NetworkManager_BadServerResponse() async throws {
        //Given
        mockSession?.response = URLResponse(url: URL(string: "https://api.themoviedb.org")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        
        //Wenn
        do {
            _ = try await networkManager?.getRequestData(clearCache: false, components: URLComponents(string: "\(networkManager?.baseUrl ?? "")\(AppConstant.EndPoints.movie.description)/1817?api_key=\(networkManager?.apiKey ?? "")"), type: MovieData.self)
            XCTFail()
        } catch {
            //Then
            XCTAssertEqual(error as? URLError, URLError(.badServerResponse))
        }
    }
    
    func test_NetworkManager_Non200StatusCode() async throws {
        //Given
        mockSession?.response = HTTPURLResponse(url: URL(string: "https://api.themoviedb.org")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        //When
        do {
            _ = try await networkManager?.getRequestData(clearCache: false, components: URLComponents(string: "\(networkManager?.baseUrl ?? "")\(AppConstant.EndPoints.movie.description)/1817?api_key=\(networkManager?.apiKey ?? "")"), type: MovieData.self)
            XCTFail()
        } catch {
            //Then
            XCTAssertEqual(error as? URLError, URLError(.badServerResponse))
        }
    }
    
    func test_NetworkManager_DataTaskError() async throws {
        //Given
        mockSession?.error = URLError(.notConnectedToInternet)
        
        //When
        do {
            _ = try await networkManager?.getRequestData(clearCache: false, components: URLComponents(string: "\(networkManager?.baseUrl ?? "")\(AppConstant.EndPoints.movie.description)/1817?api_key=\(networkManager?.apiKey ?? "")"), type: MovieData.self)
            XCTFail()
        } catch {
            //Then
            XCTAssertEqual(error as? URLError, URLError(.notConnectedToInternet))
        }
    }
    
    func test_NetworkManager_GetRequestDataSuccess() async throws {
        // Given
        let movieData = MovieData(id: 1, title: "title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 ", posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg", overview: "overview1", releaseDate: "releaseDate1", originalLanguage: "EN", voteAverage: 10.0)
        let data = try JSONEncoder().encode(movieData)
        let response = HTTPURLResponse(url: URL(string: "https://api.themoviedb.org")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        mockSession?.data = data
        mockSession?.response = response
        
        // When
        let components = URLComponents(string: "\(networkManager?.baseUrl ?? "")\(AppConstant.EndPoints.movie.description)/1817?api_key=\(networkManager?.apiKey ?? "")")
        let result = try await networkManager?.getRequestData(clearCache: false, components: components, type: MovieData.self)
        
        // Then
        XCTAssertEqual(result, movieData)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.title, movieData.title)
    }
}
