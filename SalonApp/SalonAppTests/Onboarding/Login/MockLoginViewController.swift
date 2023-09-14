//
//  MockLoginViewController.swift
//  SalonAppTests
//
//  Created by engin gülek on 14.09.2023.
//

import Foundation
@testable import SalonApp
import UIKit.UIViewController
final class MockLoginViewController : LoginViewInterface {
    
    var invokedAlertMessage = false
    var invokedAlertMessageData = [(isHiddenEmailMes: Bool, isHiddenPassMes: Bool, emailMes: String, pasmessage: String)]()
    
    
    func alertMessage(isHiddenEmailMes: Bool, isHiddenPassMes: Bool, emailMes: String, pasmessage: String) {
        invokedAlertMessage = true
        invokedAlertMessageData.append((isHiddenEmailMes:isHiddenEmailMes,
                                        isHiddenPassMes:isHiddenPassMes,
                                        emailMes:emailMes,pasmessage:pasmessage))
        
    }
    
    
    var invokedsingError = false
    var invokedsingErrorData = [(isHidden:Bool,message:String)]()
    func singError(isHidden: Bool, message: String) {
        invokedsingError = true
        invokedsingErrorData.append((isHidden:isHidden,message:message))
    }
    
    var invokedSetBackroundColor = false
    var involedBackColor:String! = nil
    func setBackgroundColor(_ color: String) {
        invokedSetBackroundColor = true
        involedBackColor = color
    }
    
    var invokedNavigationBarColor = false
    var invokedNavigationBarColorCount = 0
    var involedNavigationBarColor:String! = nil
    
    func prepareNavigationBarCollor(colorText: String) {
        invokedNavigationBarColor = true
        invokedNavigationBarColorCount += 1
        involedNavigationBarColor = colorText
    }
    
    var invokedItemTitle = false
    var invokedItemTitleData : String = ""
    func navigationItemTitle(title: String) {
        invokedItemTitle = true
        invokedItemTitleData = title
    }
    
    var invokedTabbarSelectedIndex = false
    var  invokedTabbarSelectedIndexData:Int? = nil
    func tabbarSelectedIndex(at index: Int) {
        invokedTabbarSelectedIndex = true
        invokedTabbarSelectedIndexData = index
    }
    
    var invokedPushViewController = false
    var invokedPushViewControllerCount = 0
    var invokedPushViewControllers : (identifier: String,Void)?
    var invokedPushViewControllerList = [(identifier:String,Void)]()
    
    func pushViewControllerable(_ vc: UIViewController, identifier: String) {
        invokedPushViewController = true
        invokedPushViewControllerCount += 1
    
        invokedPushViewControllers = (identifier :identifier,())
        invokedPushViewControllerList.append((identifier :identifier,()))
    }
    
    func navigationPopViewController() {}
    
}
