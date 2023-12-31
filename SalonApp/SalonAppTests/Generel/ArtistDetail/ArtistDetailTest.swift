//
//  ArtistDetailTest.swift
//  SalonAppTests
//
//  Created by engin gülek on 28.08.2023.
//

import XCTest
@testable import SalonApp
final class ArtistDetailTest: XCTestCase {
    private var viewModel : ArtistDetailViewModel!
    private var view : MockArtistDetailViewController!
    private var serviceManager : MockArtistDetailService!
    
    override func setUp() {
        super.setUp()
        view = .init()
        serviceManager = .init()
        viewModel = .init(view: view,serviceManager: serviceManager)
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        serviceManager = nil
        viewModel = nil
    }
    
    func test_viewDidLoad_InvokedbackRoundColor_ReturnBackColor(){
        XCTAssertNil(view.involedBackColor)
        viewModel.viewDidLoad(artistId: 0)
        XCTAssertEqual(view.involedBackColor, "backColor")
    }
    
 
    
    func test_navigationItemTitl_ReturnArtistDetail(){
        XCTAssertFalse(view.invokedItemTitle)
        viewModel.viewDidLoad(artistId: 1)
        XCTAssertEqual(view.invokedItemTitleData, "Artist Detail")
    }
    
    func test_viewDidLoad_invokedPrepareTabbbarHidden(){
        XCTAssertTrue(view.invokedPrepareHiddenList.isEmpty)
        
        viewModel.viewDidLoad(artistId: 0)
        
        XCTAssertEqual(view.invokedPrepareHiddenList.map(\.isHidden), [true])
    }
    
    func test_didTapTab_prepareSection_AboutIsHidden(){
        XCTAssertFalse(view.invokedPrepareSection)
        viewModel.didTapTab(selectLabel: "About",artistId: 0)
        XCTAssertEqual(view.invokedPrepareSectionList.map(\.aboutisHidden),[false])
        XCTAssertEqual(view.invokedPrepareSectionList.map(\.commetisHidden),[true])
    }
    
    func test_didTapTab_prepareSection_CommentIsHidden(){
        XCTAssertFalse(view.invokedPrepareSection)
        viewModel.didTapTab(selectLabel: "Comment",artistId: 0)
        XCTAssertEqual(view.invokedPrepareSectionList.map(\.aboutisHidden),[true])
        XCTAssertEqual(view.invokedPrepareSectionList.map(\.commetisHidden),[false])
    }
    
    
    
    
    func test_didTapTabComment_IndicatorViewAnimateStop_ReturnFalse(){
        XCTAssertFalse(view.invokedIndicatorView)
        let comment = Comment(id: 0, imageurl: "", commenter: "", comment: "", rating: 0.0, commentdate: "")
        
        serviceManager.mockFetchAritstCommentResult = .success([comment])
        viewModel.didTapTab(selectLabel: "Comment", artistId: 0)
        XCTAssertEqual(view.invokedIndicatorViewList.map(\.animate), [false])
    }
    
    func test_didTapTab_ReturnAbout(){
        viewModel.didTapTab(selectLabel: "About",artistId: 0)
        XCTAssertEqual(viewModel.sectionType, .about)
    }
    
    func test_didTapTab_ReturnComment() {
        viewModel.didTapTab(selectLabel: "Comment",artistId: 0)
        XCTAssertEqual(viewModel.sectionType,.comment)
    }
    
   
    
    
   

}
