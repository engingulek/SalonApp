//
//  BookMarkListViewModelTest.swift
//  SalonAppTests
//
//  Created by engin gülek on 14.09.2023.
//

import XCTest
@testable import SalonApp
final class BookMarkListViewModelTest: XCTestCase {
    
    private var viewModel : BookMarkListViewModel!
    private var view : MockBookMarkListViewController!
    private var serviceManager : MockBookMarkListService!
    
    override func setUp() {
        super.setUp()
        view = .init()
        serviceManager = .init()
        viewModel = .init(view: view,serviceManager: serviceManager)
    }
    
    override func tearDown() {
        view = nil
        serviceManager = nil
        viewModel =  nil
    }
    
    func test_viewDidLoad_InvokesRequiredMethods(){
        XCTAssertFalse(view.invokedPrepareTableView)
       
        XCTAssertFalse(view.invokedReloadTableViewData)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(view.invokedPrepareTableViewCount,1)
    }
    
    func test_viewDidLoad_InvokedbackRoundColor_ReturnBackColor(){
        XCTAssertNil(view.involedBackColor)
        viewModel.viewDidLoad()
        XCTAssertEqual(view.involedBackColor, "backColor")
    }
    
    func test_viewDidLoad_InvokedNavigationItemTitle_ReturnBookMarkList(){
        XCTAssertFalse(view.invokednavigationItemTitle)
        viewModel.viewDidLoad()
        XCTAssertEqual(view.invokednavigationItemTitleData, "Book Mark List")
    }
    
    
    func test_fetchBookMarkList_IndicatorViewAnimateStop_ReturnFalse(){
        XCTAssertFalse(view.invokedIndicatorViewTopArtist)
        let bookMarkListArtist = BookMarkListArtist(id: 1, artistId: 1, userId: 1, imageUrl: "test url", rating: 0.0, name: "test namesurnmae", bestService: "test ervice", locationcity: "test city", pay: 0.0, number: "+1111111")
        
        serviceManager.mockFetchBookMarkList = .success([bookMarkListArtist])
        viewModel.fetchBookMarkList()
        XCTAssertEqual(view.invokedIndicatorViewTopArtistList.map(\.animate), [false])
    }
    
    func test_fetchBookMarkList_EmptyBookMarkList_ReturnDEmpty(){
        XCTAssertFalse(view.invokedEmptyBookMarkList)
        
        serviceManager.mockFetchBookMarkList = .success([])
        viewModel.fetchBookMarkList()
        
        let message =  view.invokedEmptyBookMarkListData.map(\.message)
        let isHidden = view.invokedEmptyBookMarkListData.map(\.isHidden)
        XCTAssertEqual(message, ["Bookmark List is Empty"])
        XCTAssertEqual(isHidden, [true])
    }
    
    func test_didSelectItem_toArtistDetailViewController_pushViewController(){
        // given
        XCTAssertTrue(view.invokedPushViewControllerList.isEmpty)
        let bookMarkListArtist = BookMarkListArtist(id: 1, artistId: 1, userId: 1, imageUrl: "test url", rating: 0.0, name: "test namesurnmae", bestService: "test ervice", locationcity: "test city", pay: 0.0, number: "+1111111")
      
        serviceManager.mockFetchBookMarkList = .success([bookMarkListArtist])
       
        //when
        viewModel.fetchBookMarkList()
        viewModel.didSelectItem(at: .init(item: 0, section: 0))
        
        //then
        XCTAssertEqual(view.invokedPushViewControllerList.map(\.identifier),["ArtistDetailViewControllerIdentifier"])
    }

  



   

}
