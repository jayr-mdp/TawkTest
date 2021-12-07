//
//  CardListLayout.swift
//  TawkTest
//
//  Created by JayR- Mac-mini on 8/30/21.
//

import UIKit

final class UserListLayout: NSObject {
    enum Constants {
        static let insets: CGFloat = 10
        static let headerHeight: CGFloat = 30
        static let cellCornerRadius: CGFloat = 5
        static let cellInnerCornerRadius: CGFloat = 3
    }
    
    func make() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }

    private func sectionProvider(sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let size = NSCollectionLayoutSize(
          widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
          heightDimension: NSCollectionLayoutDimension.absolute(128)
        )
        // Item
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = makeContentInsets()

        // Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])

        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = makeContentInsets()

        return section
    }
    
    private func makeContentInsets() -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: Constants.insets / 2,
                                leading: Constants.insets / 2,
                                bottom: Constants.insets / 2,
                                trailing: Constants.insets / 2)
    }
}
