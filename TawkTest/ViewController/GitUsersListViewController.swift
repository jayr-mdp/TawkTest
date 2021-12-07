//
//  GitUsersList.swift
//  TawkTest
//
//  Created by JayR- Mac-mini on 8/30/21.
//

import UIKit
import SkeletonView

class GitUsersListViewController : UIViewController {
    
    private var gitUserViewModel : GitUserViewModel!
    @IBOutlet var collectionView : UICollectionView!
    var refreshControl: UIRefreshControl!
    var selectedUser : GitUser!
    private var searchController = UISearchController(searchResultsController: nil)
    
    private var layout = UserListLayout()
    private lazy var dataSource = gitUserViewModel.makeDataSource(collectionView: collectionView, layout: layout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = layout.make()
        view.showSkeleton()
        configureRefreshControl()
        configureSearchController()
        self.collectionView.isSkeletonable = true
        collectionView.prepareSkeleton(completion: { done in
                self.view.showAnimatedSkeleton()
        })
        
        gitUserViewModel = GitUserViewModel()
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        gitUserViewModel.getUsersList(context)
        
        //viewModel binding to update Controller when cell is selected
        gitUserViewModel.updateControllerAfterCellSelection =  { [self] user in
            selectedUser = user
            self.performSegue(withIdentifier: "showDetails", sender: self)
        }
        
        // Initialize diffable data source
        _ = dataSource.snapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setUpViewModel() {
        self.gitUserViewModel =  GitUserViewModel()
    }
    
    func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    func configureSearchController() {
      //searchController.searchResultsUpdater = self
      searchController.obscuresBackgroundDuringPresentation = false
      searchController.searchBar.placeholder = "Search Videos"
      navigationItem.searchController = searchController
      definesPresentationContext = true
    }
    
    @objc
    func pullToRefreshAction() {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        gitUserViewModel.getUsersList(context)
    }
}
