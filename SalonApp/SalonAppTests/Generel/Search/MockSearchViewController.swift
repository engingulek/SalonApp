//
//  MockSearchViewController.swift
//  SalonAppTests
//
//  Created by engin gülek on 6.09.2023.
//

import UIKit
@testable import SalonApp

final class MockSearchViewController : SearchViewInterface {
    
    var invokedPrepareCollectionView = false
    var invokedPrepareCollectionViewCount = 0
    func prepareColllectionView() {
        invokedPrepareCollectionView = true
        invokedPrepareCollectionViewCount += 1
    }
    
    var invokedTabbarHidden = false
    var invokedTabbarHiddenCount = 0
    var invokedTabbarHiddenList = [(isHidden:Bool,Void)]()
    func prepareTabbarHidden(isHidden: Bool) {
        invokedTabbarHidden = true
        invokedTabbarHiddenCount += 1
       invokedTabbarHiddenList.append((isHidden:false,()))
    }
    
    var invokedReloadArtistSection = false
    var invokedReloadArtistSectionCount = 0
    func reloadArtistSection() {
        invokedReloadArtistSection = true
        invokedReloadArtistSectionCount += 1
    }
    
    var invokedReloadServiceSection = false
    var invokedReloadServiceSectionCount = 0
    func reloadServiceSection() {
        invokedReloadServiceSection = true
        invokedReloadServiceSectionCount += 1
    }
    
    var invokedPushViewController = false
    var invokedPushViewControllerCount = 0
    var invokedPushViewControllerIdentifier : String! = nil
    func pushViewControllerable(_ vc: UIViewController, identifier: String) {
        invokedPushViewController = true
        invokedPushViewControllerCount += 1
        invokedPushViewControllerIdentifier = identifier
    }
    
    var invokedNavigationBarColor = false
    var invokedNavigationBarColorCount = 0
    var invokedNavigationBarColorData:String! = nil
    func prepareNavigationBarCollor(colorText: String) {
        invokedNavigationBarColor = true
        invokedNavigationBarColorCount += 1
        invokedNavigationBarColorData = colorText
    }
    
    var invokedSetBackroundColor = false
    var involedBackColor:String! = nil
    func setBackgroundColor(_ color: String) {
        invokedSetBackroundColor = true
       involedBackColor = color
    }
    
    var invokedsearchDidNotComeData = false
    var invokedsearchDidNotComeDataCount = 0
    var invokedsearchDidNotComeDataMessage : String!
    var invokedsearchDidNotComeDataIcon : String!
    
    
    func searchDidNotComeData(message: String, icon: String) {
        invokedsearchDidNotComeData = true
        invokedsearchDidNotComeDataCount += 1
        invokedsearchDidNotComeDataMessage = message
        invokedsearchDidNotComeDataIcon = icon
    }
    
    var invokedonErrorSearch = false
    var invokedonErrorSearchCount = 0
    var invokedonErrorSearchMessage : String!
    var invokedonErrorSearchIcon : String!
    func onErrorSearch(message: String, icon: String) {
         invokedonErrorSearchMessage = message
         invokedonErrorSearchIcon  = icon
    }
    
    var invokedItemTitle = false
    var invokedItemTitleData : String = ""
    func navigationItemTitle(title: String) {
        invokedItemTitle = true
        invokedItemTitleData = title
    }
    
    func navigationPopViewController() {
        
    }
    
   
    
    
}
