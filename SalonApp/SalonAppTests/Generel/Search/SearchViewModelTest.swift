//
//  SearchViewModelTest.swift
//  SalonAppTests
//
//  Created by engin gülek on 6.09.2023.
//

import XCTest
@testable import SalonApp


final class SearchTest : XCTestCase {
    private var viewModel : SearchViewModel!
    private var view : MockSearchViewController!
    private var serviceManager : MockSearchService!
    
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
        viewModel.viewDidLoad(searchText: "sel")
        XCTAssertEqual(view.involedBackColor, "backColor")
    }
    
    func test_viewDidLoad_invokedPrepareTabbbarHidden(){
        XCTAssertFalse(view.invokedTabbarHidden)
        viewModel.viewDidLoad(searchText: "sle")
        XCTAssertTrue(view.invokedTabbarHidden)
    }
    
    func test_prepareCollectionView(){
        XCTAssertFalse(view.invokedPrepareCollectionView)
        viewModel.viewDidLoad(searchText: "sel")
        XCTAssertEqual(view.invokedPrepareCollectionViewCount,1)
    }
    
    func test_prepareNavigationBarCollor_ReturnBlack(){
        XCTAssertFalse(view.invokedNavigationBarColor)
        viewModel.viewDidLoad(searchText: "sel")
        XCTAssertEqual(view.invokedNavigationBarColorData, "black")
    }
    
    func test_navigationItemTitl_ReturnSearch(){
        XCTAssertFalse(view.invokedItemTitle)
        viewModel.viewDidLoad(searchText: "sel")
        XCTAssertEqual(view.invokedItemTitleData, "Search")
    }
    
    func test_viewDidLoad_fetchAllServiceDataCalled_RetrunTrue(){
        XCTAssertFalse(serviceManager.fetchAllServiceDataCalled)
        viewModel.fetchAllService()
        XCTAssertTrue(serviceManager.fetchAllServiceDataCalled)
        
    }

    
    func test_viewDidload_fetchSearchArtist_EmptyData_RetrunNoDataIcon(){
        XCTAssertFalse(view.invokedsearchDidNotComeData)
        serviceManager.mockFetchsearchArtist = .success([])
        viewModel.viewDidLoad(searchText: "sel")
        viewModel.fetchSearchArtist(searchText: "sel")
        XCTAssertEqual(view.invokedsearchDidNotComeDataIcon, "no-data")
        
    }
    
    
    func test_viewDidload_fetchSearchArtist_EmptyData_RetrunMessage(){
        XCTAssertFalse(view.invokedsearchDidNotComeData)
        serviceManager.mockFetchsearchArtist = .success([])
        viewModel.viewDidLoad(searchText: "sel")
        viewModel.fetchSearchArtist(searchText: "sel")
        XCTAssertEqual(view.invokedsearchDidNotComeDataMessage, "No product matching your search was found")
    }
    
    
    
    
    
    func test_viewDidload_fetchSearchArtist_NetworkError_RetrunError404Icon(){
        XCTAssertFalse(view.invokedsearchDidNotComeData)
        serviceManager.mockFetchsearchArtist = .failure(CustomError.networkError)
        viewModel.viewDidLoad(searchText: "sel")
        viewModel.fetchSearchArtist(searchText: "sel")
        XCTAssertEqual(view.invokedonErrorSearchIcon,"error-404")
    }
    
    
    func test_viewDidload_fetchSearchArtist_NetworkError_RetrunMessage(){
        XCTAssertFalse(view.invokedsearchDidNotComeData)
        serviceManager.mockFetchsearchArtist = .failure(CustomError.networkError)
        viewModel.viewDidLoad(searchText: "sel")
        viewModel.fetchSearchArtist(searchText: "sel")
        XCTAssertEqual(view.invokedonErrorSearchMessage,"Page not found. Try again")
    }
    
    
    
   
}
