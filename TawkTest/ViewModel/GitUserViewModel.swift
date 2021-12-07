//
//  GitUserViewModel.swift
//  TawkTest
//
//  Created by JayR- Mac-mini on 8/30/21.
//

import UIKit
import Moya
import CoreData
import SkeletonView

class GitUserViewModel : NSObject {
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, GitUser>
    typealias DiffableSnapshot = NSDiffableDataSourceSnapshot<Section, GitUser>
    
    private var sections = Section.allSections
    var dataSource: DiffableDataSource!
    private var lastUserId = 0
    private var api : APIService!
    private(set) var gitUserData : [GitUser]!
    private var collectionView : UICollectionView!
    
    var updateControllerAfterCellSelection : ((_ user : GitUser) -> ()) = {_ in }
    
    override init() {
        super.init()
    }
    
    func makeDataSource(collectionView: UICollectionView,  layout: UserListLayout) -> DiffableDataSource {
        self.collectionView = collectionView
        
        dataSource = DiffableDataSource(collectionView: collectionView,
                                        cellProvider: cellProvider)

        return dataSource
    }
    
    func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, gitUser: GitUser) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: "GitUserCollectionViewCell",
          for: indexPath) as? GitUserCollectionViewCell
        cell?.gitUser = gitUser
        return cell
    }
    
    func getUsersList(_ context: NSManagedObjectContext) {
        apiServiceProvider.request(.userList(lastUserId)) { [self] result in
            do {
                switch result {
                    case let .success(moyaResponse):
                        let data = moyaResponse.data
                        let decoder = JSONDecoder()
                        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context
                        let user = try decoder.decode([GitUser].self, from: data)
                        let lastUser = user.last
                        lastUserId = Int(lastUser!.id)
                        print(user)
                        gitUserData = user
                        applySnapshot()
                        //collectionView.hideSkeleton()
                    case let .failure(error):
                        print("Error : \(error.localizedDescription)")
                    }
            } catch {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
      var snapshot = DiffableSnapshot()
      snapshot.appendSections(sections)
      sections.forEach { section in
        snapshot.appendItems(gitUserData, toSection: section)
      }
      dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

extension GitUserViewModel : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = gitUserData[indexPath.row]
        self.updateControllerAfterCellSelection(user)
    }
}


