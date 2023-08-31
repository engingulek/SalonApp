//
//  SearchViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 31.08.2023.
//

import Foundation
import UIKit


protocol SearchViewModelInterface {
    func viewDidLoad()
    func numberOfSections() -> Int
    func numberOfRowsInSection(section:TableSection) -> Int
    func viewForHeaderInSection(section:TableSection) -> String
    func heightForRowAt(section:TableSection) -> CGFloat
    func heightForHeaderInSection(section:TableSection) -> CGFloat
    func cellForRowAt(indexPath:IndexPath,section:TableSection,tableView:UITableView) -> UITableViewCell
    func didSelectRowAt(section:TableSection)
    func toStortViewController(item:Int)
}

final class SearchViewModel : SearchViewModelInterface {
    private weak var view : SearchViewInterface?
    private var tableSection : TableSection = .allService
    private var sectionType : TableSection {tableSection }
    
    init(view: SearchViewInterface) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.prepareTabbarHidden(isHidden: true)
    }
    
    func numberOfRowsInSection(section:TableSection) -> Int{
        tableSection = section
        switch tableSection {
        case .allService:
            return 1
        case .resultArtistStory:
            return 1
        case .resultArtist:
            return 5
        }
        
    }
    
    func numberOfSections() -> Int {
        return TableSection.allCases.count
    }
    
  
    
    func viewForHeaderInSection(section:TableSection) -> String {
        tableSection = section
        switch tableSection {
        case .allService:
            return "All Service"
        case .resultArtistStory:
            return "All Story"
        case .resultArtist:
            return "All Artist"
        }
    }
    
    func heightForRowAt(section:TableSection) -> CGFloat {
        tableSection = section
        switch tableSection {
        case .resultArtist:
            return 170
        default:
            return 70
        }
        
    }
    
    func heightForHeaderInSection(section:TableSection) -> CGFloat {
        return 30
    }
    
    func cellForRowAt(indexPath:IndexPath,section:TableSection,tableView:UITableView) -> UITableViewCell {
        tableSection = section
        switch tableSection {
        case .allService:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AllServiceTableViewCell.identifier,for: indexPath) as? AllServiceTableViewCell
            else {return UITableViewCell()}
            cell.backgroundColor =  UIColor(named: "backColor")
            return cell
        case .resultArtistStory:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtistStoryTableViewCell.identifier ,for: indexPath) as? ArtistStoryTableViewCell else {return UITableViewCell()}
            cell.backgroundColor =  UIColor(named: "backColor")
            cell.cellProtocol = view
            return cell
        case .resultArtist:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier,for:indexPath) as? ArtistTableViewCell else {return UITableViewCell()}
            cell.backgroundColor = UIColor(named: "backColor")
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderColor = UIColor(named: "backColor")?.cgColor
            return cell
        }
         
    }
    
     func didSelectRowAt(section:TableSection){
         tableSection = section
         switch tableSection {
         case .resultArtist:
             let vc = ArtistDetailViewController()
             vc.artistId = 1
             view?.pushViewControllerable(vc, identifier: "ArtistDetailViewControllerIdentifier")
         default:
             break
         }
    }
    
    func toStortViewController(item:Int){
        let vc = StroyViewController()
        vc.index = item
        view?.pushViewControllerable(vc, identifier: "StortViewControllerIndetifier")
        
    }
    
   
}
