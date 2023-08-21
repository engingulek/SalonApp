//
//  HomeViewModelTest.swift
//  SalonAppTests
//
//  Created by engin gülek on 21.08.2023.
//

import XCTest
@testable import SalonApp
final class HomeViewModelTest : XCTestCase {
    private var viewModel : HomeViewModel!
    private var view : MockHomeViewController!
    private var serviceManager : MockHomePageService!
    
    override func setUp() {
        super.setUp()
        view = .init()
        serviceManager = .init()
        viewModel = .init(view: view,servisManager: serviceManager)
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        serviceManager = nil
        viewModel = nil
    }
    
    func test_viewDidLoad_InvokesRequiredMethods(){
        // given
        XCTAssertFalse(view.invokedPrepareCollectionView)
        XCTAssertFalse(view.invokedPrepareTableView)
        XCTAssertFalse(view.invokedReloadData)
        
        //when
        viewModel.viewDidLoad()
        
        // then
        XCTAssertEqual(view.invokedPrepareCollectionViewCount,1)
        XCTAssertEqual(view.invokedPrepareTableViewCount,1)
        XCTAssertEqual(view.invokedReloadDataCount,1)
        
    }
    
    func test_viewWillAppear_invokedprepareTabbarHidden(){
        // gicen
        XCTAssertTrue(view.invokedTabbarHiddenList.isEmpty)
        // when
        viewModel.viewWillAppear()
        //then
        XCTAssertEqual(view.invokedTabbarHiddenList.map(\.isHidden),[false])
        
    }
    
    func test_viewWillDisapper_InvokedPrepareTextFieldController(){
        // given
        XCTAssertTrue(view.invokedSearchTextFieldList.isEmpty)
        // when
        viewModel.viewWillDisappear()
        //then
        XCTAssertEqual(view.invokedSearchTextFieldList.map(\.text), [""])
    }
    
    
    func test_didSelectRow_toArtistDetailViewController_pushViewController(){
        // given
        XCTAssertTrue(view.invokedPushViewControllerList.isEmpty)
        //when
        viewModel.didSelectRow(at: .init(row: 0, section: 0))
        //then
        XCTAssertEqual(view.invokedPushViewControllerList.map(\.identifier),["ArtistDetailViewControllerIdentifier"])
    }
    
    
    func test_searchTextField_toSearchViewController_pushViewController(){
        // given
        XCTAssertTrue(view.invokedPushViewControllerList.isEmpty)
        //when
        /// Text length must be three
        viewModel.textFieldDidChange("Tes")
        // then
        XCTAssertEqual(view.invokedPushViewControllerList.map(\.identifier), ["SearchViewControllerIdentifier"])
    }
}
