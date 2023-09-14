//
//  MockBookMarkListViewController.swift
//  SalonAppTests
//
//  Created by engin gülek on 14.09.2023.
//

@testable import SalonApp
import UIKit.UIViewController
final class MockBookMarkListViewController : BookMarkViewInterface {
    
    var invokedPrepareTableView = false
    var invokedPrepareTableViewCount = 0
    func prepareTableView() {
        invokedPrepareTableView = true
        invokedPrepareTableViewCount += 1
    }
    
    
    var invokedTabbarHidden = false
    var invokedTabbarHiddenCount = 0
    var invokedTabbarHiddenList = [(isHidden:Bool,Void)]()
    func prepareTabbarHidden(isHidden: Bool) {
        invokedTabbarHidden = true
        invokedTabbarHiddenCount += 1
       invokedTabbarHiddenList.append((isHidden:false,()))
    }
    
    var invokedReloadTableViewData = false
    var invokedReloadDataTableViewCount = 0
    func reloadDataTableView() {
        invokedReloadTableViewData = true
        invokedReloadDataTableViewCount += 1
    }
    
    var invokedIndicatorViewTopArtist = false
    var invokedIndicatorViewTopArtistCount = 0
    var invokedIndicatorViewTopArtistList = [(animate:Bool,Void)]()
    func indicator(animate: Bool) {
        invokedIndicatorViewTopArtist = true
        invokedIndicatorViewTopArtistCount += 1
       invokedIndicatorViewTopArtistList.append((animate:animate,()))
    }
    
    var invokedEmptyBookMarkList = false
    var invokedEmptyBookMarkListCount = 0
    var invokedEmptyBookMarkListData = [(message:String,isHidden:Bool)]()
    func emptyBookMarkList(message: String, isHidden: Bool) {
        invokedEmptyBookMarkList = true
        invokedEmptyBookMarkListCount += 1
        invokedEmptyBookMarkListData.append((message:message,isHidden:isHidden))
        
    }
    var invokedSetBackroundColor = false
    var involedBackColor:String! = nil
    func setBackgroundColor(_ color: String) {
        invokedSetBackroundColor = true
        involedBackColor = color
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
    
    var invokedprepareNavigationBarCollor = false
    var invokedprepareNavigationBarCollorData:String = ""
    func prepareNavigationBarCollor(colorText: String) {
        invokedprepareNavigationBarCollor = true
        invokedprepareNavigationBarCollorData = colorText
    }
    
    var invokednavigationItemTitle = false
    var invokednavigationItemTitleData : String = ""
    func navigationItemTitle(title: String) {
        invokednavigationItemTitleData = title
    }
    
    func navigationPopViewController() {}
    
    
}
