//
//  LayoutBuilder.swift
//  SalonApp
//
//  Created by engin gülek on 3.09.2023.
//

import Foundation


import UIKit

public class LayoutBuilder {
    
    public static func buildAllServiceSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.7)))
        let itemInset = NSDirectionalEdgeInsets(top: 0.0, leading: 5.0, bottom: 0.0, trailing: 5.0)
        item.contentInsets = itemInset
        let size =  NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(0.1))
       
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        
       
        let section = NSCollectionLayoutSection(group: group)
        let sectionInset = NSDirectionalEdgeInsets(top: 16.0, leading: 0.0, bottom: 16.0, trailing: 0.0)
        section.contentInsets = sectionInset
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return section
    }
    
    public static func buildResultArtistSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),  heightDimension: .fractionalHeight(0.5))
        
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    
  
    
 
}
