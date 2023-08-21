//
//  MockHomeViewController.swift
//  SalonAppTests
//
//  Created by engin gülek on 21.08.2023.
//

@testable import SalonApp
import UIKit

final class MockHomeViewController : HomeViewInterface {
    
    

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
 
    
    var invokedPrepareCollectionView = false
    var invokedPrepareCollectionViewCount = 0
    func prepareCollectionView() {
        invokedPrepareCollectionView = true
        invokedPrepareCollectionViewCount += 1
    }
    
    var invokedPrepareTableView = false
    var invokedPrepareTableViewCount = 0
    func prepareTableView() {
        invokedPrepareTableView = true
        invokedPrepareTableViewCount += 1
    }
        
    var invokedTabbarHidden = false
    var invokedTabbarHiddenCount = 0
    var invokedTabbarHiddenList = [(isHidden:Bool,Void)]()
    func prepareTabbarHidden(isHidden:Bool) {
         invokedTabbarHidden = true
         invokedTabbarHiddenCount += 1
        invokedTabbarHiddenList.append((isHidden:false,()))
    }
    
    var invokedSearchTextField = false
    var invokedSearchTextFieldCount = 0
   // var invokedSearchTextField : (identifier: String,Void)?
    var invokedSearchTextFieldList = [(text:String,Void)]()
    
    func prepareTextFieldController(text: String) {
        invokedSearchTextField = true
        invokedSearchTextFieldCount += 1
        invokedSearchTextFieldList.append((text:text,()))
        
    }
    
    var invokedReloadData = false
    var invokedReloadDataCount = 0
    
    func reloadData() {
         invokedReloadData = true
         invokedReloadDataCount += 1
    }
    
    
    
    
}
