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
    
      func prepareNavigationBarCollor(colorText: String) {}
      func reloadDataTableView() { }
      func getArtistDetail() {}
    
}
