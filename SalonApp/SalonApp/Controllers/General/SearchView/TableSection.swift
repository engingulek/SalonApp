//
//  TableSection.swift
//  SalonApp
//
//  Created by engin gülek on 31.08.2023.
//

import Foundation
import UIKit

enum TableSection : CaseIterable {
    case allService
    case resultArtistStory
    case resultArtist
    
    func numberOfItems() -> Int {
        switch self {
        case .allService:
            return 2
        case .resultArtistStory:
            return 1
        case .resultArtist:
            return 1
        }
    }
    func sectionTitle() -> String{
              switch self {
              case .allService:
                  return ""
              case .resultArtistStory:
                  return "Artist Story"
              case .resultArtist:
                  return "Result Artist"
              }
          }
    func register(tableView : UITableView) {
        switch self {
        case .allService:
          tableView.register(AllServiceTableViewCell.self, forCellReuseIdentifier: AllServiceTableViewCell.identifier)
            
        case .resultArtistStory:
         tableView.register(ArtistStoryTableViewCell.self, forCellReuseIdentifier: ArtistStoryTableViewCell.identifier)
            
        case .resultArtist:
            tableView.register(ArtistTableViewCell.self, forCellReuseIdentifier: ArtistTableViewCell.identifier)
            
        }
    }
}
