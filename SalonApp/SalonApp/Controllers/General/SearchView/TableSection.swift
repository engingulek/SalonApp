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
    case resultArtist
    
    func numberOfItems() -> Int {
        switch self {
        case .allService:
            return 1
        case .resultArtist:
            return 1
        }
    }
    func sectionTitle() -> String{
              switch self {
              case .allService:
                  return ""
              case .resultArtist:
                  return "Result Artist"
              }
          }
    func register(tableView : UITableView) {
        switch self {
        case .allService:
            break
            
        case .resultArtist:
            tableView.register(ArtistTableViewCell.self, forCellReuseIdentifier: ArtistTableViewCell.identifier)
            
        }
    }
}
