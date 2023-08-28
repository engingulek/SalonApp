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
    
    func test_viewDidLoad_InvokesRequiredMethods(){
        XCTAssertFalse(serviceManager.invokedFetchArtistDetail)
        XCTAssertFalse(view.invokedPrepareTableView)
        
        viewModel.viewDidLoad(artistId: 0)
        
        XCTAssertEqual(serviceManager.invokedFetchArtistDetailCount, 1)
        XCTAssertEqual(view.involedPrepareTableViewCount, 1)
    }
    
    func test_viewDidLoad_invokedPrepareTabbbarHidden(){
        XCTAssertTrue(view.invokedPrepareHiddenList.isEmpty)
        
        viewModel.viewDidLoad(artistId: 0)
        
        XCTAssertEqual(view.invokedPrepareHiddenList.map(\.isHidden), [true])
    }
    
    func test_didTapTab_prepareSection_AboutIsHidden(){
        XCTAssertFalse(view.invokedPrepareSection)
        viewModel.didTapTab(selectLabel: "About")
        XCTAssertEqual(view.invokedPrepareSectionList.map(\.aboutisHidden),[false])
        XCTAssertEqual(view.invokedPrepareSectionList.map(\.commetisHidden),[true])
    }
    
    func test_didTapTab_prepareSection_CommentIsHidden(){
        XCTAssertFalse(view.invokedPrepareSection)
        viewModel.didTapTab(selectLabel: "Comment")
        XCTAssertEqual(view.invokedPrepareSectionList.map(\.aboutisHidden),[true])
        XCTAssertEqual(view.invokedPrepareSectionList.map(\.commetisHidden),[false])
    }
    
    func test_didTapTab_ReturnAbout(){
        viewModel.didTapTab(selectLabel: "About")

        XCTAssertEqual(viewModel.sectionType, .about)
    }
    
    func test_didTapTab_ReturnComment() {
        viewModel.didTapTab(selectLabel: "Comment")
        XCTAssertEqual(viewModel.sectionType,.comment)
    }
    
    func test_sendMessage_toChatViewController_pushViewController(){
        XCTAssertTrue(view.invokedPushViewControllerList.isEmpty)
        let artistDetail = ArtistDetail(id: 1, imageUrl: "", rating: 1.0, name: "", bestService: "", locationcity: "", pay: 2.0, about: "")
        
        serviceManager.mockFetchArtistDetailResult = .success([artistDetail])
        
        viewModel.fetchArtistDetail(artistId: 1)
        viewModel.sendMessageButtonTap()
        
        XCTAssertEqual(view.invokedPushViewControllerList.map(\.identifier),["ChatViewControllerIndetifier"])
    }

}
