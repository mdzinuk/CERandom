//
//  CEPersonListViewController.swift
//  CERandom
//
//  Created by Mohammad Arafat Hossain on 20/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import UIKit

class CEPersonListViewController: UITableViewController {
    
    private var searchController: UISearchController = UISearchController()
    var viewModel: CEPersonViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        viewModel = CEPersonViewModel(context: self)
        viewModel?.startLiveLoading()
    }
}

private extension CEPersonListViewController {
    func isMoreLoading(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel?.currentList ?? 0
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
    func configureViews() {
        tableView?.register(CEPersonListCell.nib,
                            forCellReuseIdentifier: CEPersonListCell.reuseIdentifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        
        searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchBar.delegate = self
            controller.obscuresBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.barStyle = UIBarStyle.black
            controller.searchBar.barTintColor = UIColor.white
            controller.searchBar.backgroundColor = UIColor.clear
            tableView.tableHeaderView = controller.searchBar
            return controller
        })()
    }
}


// MARK: - Table view datasource; delegate; prefetching
extension CEPersonListViewController: UITableViewDataSourcePrefetching {
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return viewModel?.total ?? 0 }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CEPersonListCell.reuseIdentifier,
                                                       for: indexPath) as? CEPersonListCell else {
                                                        return UITableViewCell()
        }
        if isMoreLoading(for: indexPath) {
            cell.configure(with: .none)
        } else {
            let model = viewModel?.getPerson(at: indexPath.row)
            cell.configure(with: model)
            
            viewModel?.getImage(from: model?.picture.thumbnail ?? "") { image in
                DispatchQueue.main.async { [weak cell] in
                    cell?.thumbView.image = image
                }
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isMoreLoading) && viewModel?.reachedMaximum != true {
            viewModel?.startLiveLoading()
        }
    }
}

extension CEPersonListViewController: CEListContextProtocol {
    func onImageFetch(with image: UIImage?, for path: IndexPath) {
        
    }
    
    func didSuccessFetching(with indexSet: [IndexPath]?) {
        guard let newIndexPathsToReload = indexSet else {
            tableView.reloadData()
            return
        }
        tableView.beginUpdates()
        tableView.insertRows(at: newIndexPathsToReload, with: .automatic)
        tableView.endUpdates()
    }
    
    func didFindSearch(list indexSet: [IndexPath]?) {
        // Note: Will use update later
        tableView.reloadData()
    }
}

extension CEPersonListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.startSearching(for: .none)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.startSearching(for: searchText)
    }
}
