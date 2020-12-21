//
//  CollectionViewSections.swift
//  Cartisim
//
//  Created by Cole M on 6/14/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

class Sections: NSObject {
    
    static let shared = Sections()
    
    func defaultSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let sectionIndex = NSCollectionLayoutSection(group: group)
        sectionIndex.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        sectionIndex.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return sectionIndex
    }
    
    func chatSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
//        let spacing = CGFloat(30)
//        group.contentInsets.top = CGFloat(30)
//        group.contentInsets.bottom = CGFloat(30)
//        group.interItemSpacing = .fixed(spacing)
        
        let sectionIndex = NSCollectionLayoutSection(group: group)
        sectionIndex.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
        
        return sectionIndex
    }
    
    func listWithSmallHeaderSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)
        
        let sectionIndex = NSCollectionLayoutSection(group: group)
        sectionIndex.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(35))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: Constants.SECTION_HEADER_ELEMENT_OF_KIND,
            alignment: .top)
        
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        sectionIndex.boundarySupplementaryItems = [sectionHeader]
        return sectionIndex
    }
}

