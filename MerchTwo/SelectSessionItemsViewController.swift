//
//  SelectSessionItemsViewController.swift
//  MerchTwo
//
//  Created by JSudau on 10.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class SelectSessionItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource/*, UISearchResultsUpdating*/ {
	
	var filteredItems = [ItemData]()
	var searchController = UISearchController()
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.setEditing(true, animated: false)
		//setupSearchBar()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.tableView.reloadData()
	}

	@IBAction func done(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
//	func setupSearchBar() {
//		searchController = UISearchController(searchResultsController: nil)
//		navigationItem.searchController = searchController
//
//		searchController.searchResultsUpdater = self
//		searchController.obscuresBackgroundDuringPresentation = false
//		searchController.searchBar.placeholder = "Search Session"
//		navigationItem.searchController = searchController
//		definesPresentationContext = true
//	}
//
//	func updateSearchResults(for searchController: UISearchController) {
//		filterContentForSearchText(searchController.searchBar.text!)
//	}
//
//	func searchBarIsEmpty() -> Bool {
//		return searchController.searchBar.text?.isEmpty ?? true
//	}
//
//	func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//		filteredItems = globalAppData.stock.stockItems.filter({( item : ItemData) -> Bool in
//			return item.title.lowercased().contains(searchText.lowercased())
//		})
//
//		tableView.reloadData()
//	}
//
//	func isFiltering() -> Bool {
//		return searchController.isActive && !searchBarIsEmpty()
//	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return /*isFiltering() ? filteredItems.count : */globalAppData.stock.stockItems.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SelectSessionItemCell
		let item = globalAppData.stock.stockItems[indexPath.section]
		cell?.cellImage.image = UIImage(data: item.imageData)
		cell?.cellTitle.text = item.title
		return cell!
	}
	
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.init(rawValue: 3)!
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
			return 85
	}
}


