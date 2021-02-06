//
//  GitHubRepoViewController.swift
//  RxSwift_Study
//
//  Created by Елизавета Щербакова on 06.02.2021.
//

import UIKit
import RxSwift
import RxCocoa

class GitHubRepoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    let disposeBag = DisposeBag()
    
    var viewModel: ViewModel?
    let apiProvider = APIProvider()
    
    var searchBar: UISearchBar {
        return searchController.searchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        
        viewModel = ViewModel(apiProvider: apiProvider)
        if let viewModel = viewModel {
            viewModel.data.drive(tableView.rx.items(cellIdentifier: "Cell")) { _, repository, cell in
                cell.textLabel?.text = repository.name
                cell.detailTextLabel?.text = repository.url
                
            }.disposed(by: disposeBag)
            
            searchBar.rx.text.orEmpty.bind(to: viewModel.searchText).disposed(by: disposeBag)
            searchBar.rx.cancelButtonClicked.map{""}.bind(to: viewModel.searchText).disposed(by: disposeBag)
            
            viewModel.data.asDriver()
                .map {
                    "\($0.count) Repositories"
                }
                .drive(navigationItem.rx.title)
                .disposed(by: disposeBag)
        }
    }
    
    private func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.text = "sherbakova031193"
        searchController.searchBar.placeholder = "Enter User"
        
        tableView.tableHeaderView = searchBar
        definesPresentationContext = true
    }
}
