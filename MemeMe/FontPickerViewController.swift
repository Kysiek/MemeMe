//
//  FontPickerViewController.swift
//  MemeMe
//
//  Created by Krzysztof Maciążek on 25/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

class FontPickerViewController: UIViewController {

    @IBOutlet weak var fontPickerTableViewDelegates: FontPickerTableViewDelegates!
    
    @IBOutlet weak var tableView: UITableView!
    private var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fontPickerTableViewDelegates.dataSource = MemeMeAPI.sharedInstance.getAvailableFonts()
        fontPickerTableViewDelegates.filteredDataSource = fontPickerTableViewDelegates.dataSource
        initializaSearchController()
    }
    
    private func initializaSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
}
extension FontPickerViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchString = searchController.searchBar.text {
            fontPickerTableViewDelegates.filterDataSourceContaining(searchString)
            tableView.reloadData()
        }
    }
}

