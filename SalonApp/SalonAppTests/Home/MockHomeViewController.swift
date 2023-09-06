//
//  MockHomeViewController.swift
//  SalonAppTests
//
//  Created by engin gülek on 21.08.2023.
//

@testable import SalonApp
import UIKit

final class MockHomeViewController : HomeViewInterface {
    
    var invokedIndicatorViewTopService = false
    var invokedIndicatorViewTopServiceCount = 0
    var invokedIndicatorViewTopServiceList = [(animate:Bool,Void)]()
    func indicatorViewTopService(animate: Bool) {
         invokedIndicatorViewTopService = true
         invokedIndicatorViewTopServiceCount += 1
        invokedIndicatorViewTopServiceList.append((animate:animate,()))
    }
    
    var invokedIndicatorViewTopArtist = false
    var invokedIndicatorViewTopArtistCount = 0
    var invokedIndicatorViewTopArtistList = [(animate:Bool,Void)]()
    func indicatoViewTopArtist(animate: Bool) {
        invokedIndicatorViewTopArtist = true
        invokedIndicatorViewTopArtistCount += 1
       invokedIndicatorViewTopArtistList.append((animate:animate,()))
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

    
    var invokedReloadTableViewData = false
    var invokedReloadDataTableViewCount = 0
    
    func reloadDataTableView() {
        
         invokedReloadTableViewData = true
         invokedReloadDataTableViewCount += 1
    }
    
    func prepareNavigationBarCollor(colorText: String) { }
    
    
    
    
    
}
