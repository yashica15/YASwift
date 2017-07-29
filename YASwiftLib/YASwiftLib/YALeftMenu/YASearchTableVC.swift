//
//  YASearchTableVC.swift
//  YASwiftLib
//
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import UIKit

class YASearchTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblYAData: UITableView!

    var arrYAData = [YAData]()
    var filteredYAData = [YAData]()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search TableView"

        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
        self.tblYAData.tableHeaderView = searchController.searchBar
        
        arrYAData = [
            YAData(category:"Chocolate", name:"Chocolate Bar"),
            YAData(category:"Chocolate", name:"Chocolate Chip"),
            YAData(category:"Chocolate", name:"Dark Chocolate"),
            YAData(category:"Hard", name:"Lollipop"),
            YAData(category:"Hard", name:"Candy Cane"),
            YAData(category:"Hard", name:"Jaw Breaker"),
            YAData(category:"Other", name:"Caramel"),
            YAData(category:"Other", name:"Sour Chew"),
            YAData(category:"Other", name:"Gummi Bear")]
        
//        self.tblYAData.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredYAData.count
        }
        return arrYAData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "YADataCell"
        let cell = self.tblYAData.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let yaData: YAData
        if searchController.isActive && searchController.searchBar.text != "" {
            yaData = filteredYAData[indexPath.row]
        } else {
            yaData = arrYAData[indexPath.row]
        }
        cell.textLabel!.text = yaData.name
        cell.detailTextLabel!.text = yaData.category
        return cell
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredYAData = arrYAData.filter({( yaData : YAData) -> Bool in
            let categoryMatch = (scope == "All") || (yaData.category == scope)
            return categoryMatch && yaData.name.lowercased().contains(searchText.lowercased())
        })
        self.tblYAData.reloadData()
    }
}

extension YASearchTableVC: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension YASearchTableVC: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}
