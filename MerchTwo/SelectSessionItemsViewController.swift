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
		setupNavBar()
		//setupSearchBar()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.tableView.reloadData()
	}
	
	func setupNavBar() {
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.hidesBackButton = true
		let right = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done1(_:)))
		self.navigationItem.rightBarButtonItem = right
		self.navigationItem.title = "Add"
	}
	
	func setupTabAndToolBar() {
		self.tabBarController?.tabBar.isHidden = true
		let addOption = UIBarButtonItem(title: "Add Option", style: .plain, target: self, action: #selector(addOption(_:)))
		let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
		toolbarItems = [addOption, spacer]
	}
	
	@objc func done1(_ sender: Any) {
		self.navigationController?.popToRootViewController(animated: true)
	}

	@IBAction func done(_ sender: Any) {
		print("done done")
	}
	
	@objc func addOption(_ sender: Any) {
		print("adding option")
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
//		filteredItems = globalAppData.sessions[globalAppData.activeSession].sessionItems.filter({( item : ItemData) -> Bool in
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
		return /*isFiltering() ? filteredItems.count : */globalAppData.sessions[globalAppData.activeSession].sessionItems.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SelectSessionItemCell
		let item = globalAppData.sessions[globalAppData.activeSession].sessionItems[indexPath.section]
		cell?.cellImage.image = UIImage(data: item.imageData)
		cell?.cellTitle.text = item.title
		return cell!
	}
	
	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
		return UITableViewCellEditingStyle.init(rawValue: 3)!
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
			return 85
	}
}


