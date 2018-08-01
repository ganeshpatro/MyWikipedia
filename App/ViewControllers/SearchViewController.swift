//
//  SearchViewController.swift
//  MyWikipedia
//
//  Created by Ganesh Patro on 7/31/18.
//  Copyright © 2018 Ganesh Patro. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var tblViewSearchWiki: UITableView!
    
    private var arrWikiData = [WikiData]() {
        didSet {
            tblViewSearchWiki.reloadData()
        }
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK:- View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        customiseUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK:- BaseViewController Protocol Methods
extension SearchViewController:BaseViewControllerProtocol {
    func customiseUI() {
        self.title = "My Wikipedia"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        setUpSearchController()
        
        tblViewSearchWiki.configureForSelfSizingCell(withEstimatedHeight: 30.0)
        tblViewSearchWiki.registerNib(withNibName: WikiDataCell.cellNibName(), withCellIdentifier: WikiDataCell.cellIdentifier())
        
        hitSearchWikipediaAPI(withSearchString: searchController.searchBar.text!)
    }
}

//MARK:- Private Methods
extension SearchViewController {
    private func setUpSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Wikipedia"
        definesPresentationContext = true
        self.navigationItem.searchController = searchController;
        
        searchController.searchBar.text = "Arijit Singh"
        searchController.isActive = true
    }
    
    private func hitSearchWikipediaAPI(withSearchString searchString: String) {
        WikiSearchAPI.searchWikiData(withSearchString: searchString) { (wikiDataResult) in
            switch(wikiDataResult) {
            case .success(let arrWikiData):
                print(arrWikiData)
                DispatchQueue.main.async {
                    self.arrWikiData = arrWikiData
                }
            case .error(let error):
                print(error)
            }
        }
    }
}

//MARK: UISearchController Protocol Methods
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        hitSearchWikipediaAPI(withSearchString: searchString!)
    }
}

//MARK:- UITableView Delage & Datasource Methods
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrWikiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let wikiDataCell = tblViewSearchWiki.dequeueReusableCell(withIdentifier: WikiDataCell.cellIdentifier(), for: indexPath) as? WikiDataCell else {
            return UITableViewCell()
        }
        
        wikiDataCell.configureCell(withData: arrWikiData[indexPath.row], atIndexPath: indexPath as NSIndexPath)
        
        return wikiDataCell
    }
}


