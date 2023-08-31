//
//  MockArtistDetailViewController.swift
//  SalonAppTests
//
//  Created by engin gülek on 28.08.2023.
//

import Foundation
@testable import SalonApp
import UIKit.UIViewController
final class MockArtistDetailViewController : ArtistDetailViewInterface{
    
   
    
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
    
    var invokedPrepareTableView = false
    var involedPrepareTableViewCount = 0
    func prepareTableView() {
        invokedPrepareTableView = true
        involedPrepareTableViewCount += 1
    }
    
    var invokedPrepareTabbarHidden = false
    var invokedPrepareTabbarHiddenCount = 0
    var invokedPrepareHiddenList = [(isHidden:Bool,Void)]()
    func prepareTabbarHidden(isHidden: Bool) {
         invokedPrepareTabbarHidden = true
         invokedPrepareTabbarHiddenCount += 1
        invokedPrepareHiddenList.append((isHidden:true,()))
    }
    
    var invokedPrepareSection = false
    var invokedPrepareSectionCount = 0
    var invokedPrepareSectionList = [(aboutisHidden:Bool,commetisHidden: Bool)]()
    func prepareSection(aboutisHidden: Bool, commetisHidden: Bool) {
         invokedPrepareSection = true
        invokedPrepareSectionCount = 0
        invokedPrepareSectionList.append((aboutisHidden:aboutisHidden,commetisHidden:commetisHidden))
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
    
    var invokedIndicatorView = false
    var invokedIndicatorViewCount = 0
    var invokedIndicatorViewList = [(animate:Bool,Void)]()
    func indicatorView(animate: Bool) {
        print("Mock \(animate)")
        invokedIndicatorView = true
        invokedIndicatorViewCount += 1
        invokedIndicatorViewList.append((animate:animate,()))
    }
    
    
    var invokedReloadTableViewData = false
    var invokedReloadDataTableViewCount = 0
    
    func reloadDataTableView() {
        
         invokedReloadTableViewData = true
         invokedReloadDataTableViewCount += 1
    }
      func getArtistDetail() {}
    
    
    
    
}
