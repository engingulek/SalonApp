//
//  LoginViewModelTest.swift
//  SalonAppTests
//
//  Created by engin gülek on 14.09.2023.
//

import XCTest
@testable import SalonApp
final class LoginViewModelTest: XCTestCase {

    private var viewModel : LoginViewModel!
    private var view : MockLoginViewController!
    private var serviceManger : MockLoginService!
    override func setUp()  {
        view = .init()
        serviceManger = .init()
        viewModel = .init(view: view,serviceManager: serviceManger)
    }

    override func tearDown()  {
        view = nil
        serviceManger = nil
        viewModel = nil
    }
    
    func test_viewDidLoad_InvokedbackRoundColor_ReturnBackColor(){
        XCTAssertNil(view.involedBackColor)
        viewModel.viewDidLoad()
        XCTAssertEqual(view.involedBackColor, "backColor")
    }
    
    func test_prepareNavigationBarCollor_ReturnBlack(){
        XCTAssertFalse(view.invokedNavigationBarColor)
        viewModel.viewDidLoad()
        XCTAssertEqual(view.involedNavigationBarColor, "black")
    }
    
    func test_NotLoginUser_singError(){
        XCTAssertFalse(view.invokedsingError)
        viewModel.viewDidLoad()
        let isHidden = view.invokedsingErrorData.map(\.isHidden)
        let message = view.invokedsingErrorData.map(\.message)
        
        XCTAssertEqual(isHidden,[true])
        XCTAssertEqual(message, [""])
    }
    
    
    func test_loginUser_SuccessFalse(){
        XCTAssertFalse(view.invokedsingError)
        let singInResut =  SingInResult(success: false, message: "Error", data: nil)
        serviceManger.mockLoginUser = .success(singInResut)
        viewModel.login(email: "testEmail@gmail.com", password: "testPassword")
        
        let isHidden = view.invokedsingErrorData.map(\.isHidden)
        let message = view.invokedsingErrorData.map(\.message)
        
        XCTAssertEqual(isHidden,[false])
        XCTAssertEqual(message, ["Email or password is incorrect"])
    }
    
    
    func test_loginUser_SuccessTrue(){
        XCTAssertFalse(view.invokedsingError)
        let user = User(id: 1, name: "testname", surname: "test sruname", email: "testEmail@gmail.com", imageUrl: "test imageYrl")
        let singInResut =  SingInResult(success: true, message: "Sing In Success", data:user )
        
        serviceManger.mockLoginUser = .success(singInResut)
        viewModel.login(email: "testEmail@gmail.com", password: "testPassword")
        
        let isHidden = view.invokedsingErrorData.map(\.isHidden)
        let message = view.invokedsingErrorData.map(\.message)
    
       
    }
    
    func test_loginUser_AlertMessage_ReturnEmailAlert(){
        XCTAssertFalse(view.invokedAlertMessage)
        
        viewModel.login(email: "testEm", password: "testPassword")
        
        let isHiddenEmailMes = view.invokedAlertMessageData.map(\.isHiddenEmailMes)
        let emailMes = view.invokedAlertMessageData.map(\.emailMes)
        
        
        XCTAssertEqual(isHiddenEmailMes,[false])
        XCTAssertEqual(emailMes, ["Please enter a valid e-mail address"])
    }
    
    func test_loginUser_AlertMessage_ReturnPasswordAlert(){
        XCTAssertFalse(view.invokedAlertMessage)
        
        viewModel.login(email: "testEmfmali@gmail.com", password: "test")
        
        let isHiddenPassMes = view.invokedAlertMessageData.map(\.isHiddenPassMes)
        let pasmessage = view.invokedAlertMessageData.map(\.pasmessage)
        
        
        XCTAssertEqual(isHiddenPassMes,[false])
        XCTAssertEqual(pasmessage, ["Enter a password of at least 10 characters"])
    }
}
