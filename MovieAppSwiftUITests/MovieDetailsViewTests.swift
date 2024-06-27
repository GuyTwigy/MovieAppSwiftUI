//
//  MovieDetailsViewTests.swift
//  MovieAppSwiftUITests
//
//  Created by Guy Twig on 27/06/2024.
//

import XCTest
@testable import MovieAppSwiftUI

@MainActor
final class MovieDetailsViewTests: XCTestCase {

    var vm: MovieDetailsViewModel?
    var dataService: GetTrailerProtocol?
    var mockMovie: MovieData?
    var detailsArr: [MovieDetailsViewModel.SingleDetail] = []
    
    override func setUpWithError() throws {
        mockMovie = MovieData(id: 1, title: "title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 ", posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg", overview: "overview1", releaseDate: "releaseDate1", originalLanguage: "EN", voteAverage: 10.0)
        let dataService = NetworkManager()
        vm = MovieDetailsViewModel(dataService: dataService, movie: MovieData(id: 1, title: "title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 ", posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg", overview: "overview1", releaseDate: "releaseDate1", originalLanguage: "EN", voteAverage: 10.0))
    }
    
    override func tearDownWithError() throws {
        mockMovie = nil
        dataService = nil
        vm = nil
    }
    
    func test_MovieDetailsVM_init_movieNotNil() {
        // When
        detailsArr = [MovieDetailsViewModel.SingleDetail(title: "Overiew:", description: mockMovie?.overview ?? "Not Available"),
                      MovieDetailsViewModel.SingleDetail(title: "Rating:", description: "\(mockMovie?.voteAverage?.description ?? "-")/10"),
                      MovieDetailsViewModel.SingleDetail(title: "Language:", description: mockMovie?.originalLanguage ?? "Not Available"),
                      MovieDetailsViewModel.SingleDetail(title: "Release Date:", description: mockMovie?.releaseDate ?? "Not Available")]
        
        //then
        XCTAssertNotNil(mockMovie)
        XCTAssertEqual(detailsArr[0].description, "overview1")
        XCTAssertEqual(detailsArr[0].title, "Overiew:")
        XCTAssertEqual(detailsArr[1].title, "Rating:")
        XCTAssertEqual(detailsArr[2].title, "Language:")
        XCTAssertEqual(detailsArr[3].title, "Release Date:")
        
    }
    
    func test_MovieDetailsVM_init_movieNil() {
        // Given
        mockMovie = nil
        
        // When
        detailsArr = [MovieDetailsViewModel.SingleDetail(title: "Overiew:", description: mockMovie?.overview ?? "Not Available"),
                      MovieDetailsViewModel.SingleDetail(title: "Rating:", description: "\(mockMovie?.voteAverage?.description ?? "-")/10"),
                      MovieDetailsViewModel.SingleDetail(title: "Language:", description: mockMovie?.originalLanguage ?? "Not Available"),
                      MovieDetailsViewModel.SingleDetail(title: "Release Date:", description: mockMovie?.releaseDate ?? "Not Available")]
        
        //then
        XCTAssertNil(mockMovie)
        XCTAssertEqual(detailsArr[0].description, "Not Available")
        XCTAssertEqual(detailsArr[0].title, "Overiew:")
        XCTAssertEqual(detailsArr[1].title, "Rating:")
        XCTAssertEqual(detailsArr[2].title, "Language:")
        XCTAssertEqual(detailsArr[3].title, "Release Date:")
    }
    
    func test_MovieDetailsVM_getTrailerSeccess() async {
        //given
        let id = 1817
        
        //when
        await vm?.getTrailer(id: id)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else {
                XCTFail()
                return
            }
            
            XCTAssertNotNil(self.vm?.video)
            XCTAssertNotNil(self.vm?.video?.key)
            XCTAssertNotNil(self.vm?.video?.type)
        }
    }
}
