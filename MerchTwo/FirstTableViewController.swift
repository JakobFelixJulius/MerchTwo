//
//  FirstViewController.swift
//  MerchTwo
//
//  Created by JSudau on 04.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class FirstTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var stockItemsData = [ItemData]()
	var filteredItems = [ItemData]()
	var searchController = UISearchController()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavBar()
        setupSearchBar()
        let image = UIImage(named: "tshirt1.png")
        let imageData:Data = image!.pngData()! as Data
        
        let image1 = UIImage(named: "tshirt2.png")
        let imageData1:Data = image1!.pngData()! as Data
        
        let image2 = UIImage(named: "tshirt3.png")
        let imageData2:Data = image2!.pngData()! as Data
        
		stockItemsData = [ItemData(id: "unique1", opened: false, imageData: imageData, title: "T-Shirt this is my new Shirt and it looks soooo nice!", options: ["S", "M", "L"], stock: [1, 2, 3], sold: [0, 0, 0]),
                         ItemData(id: "unique2", opened: false, imageData: imageData1, title: "T-Shirt 2", options: ["XS", "S", "M", "L", "XL"], stock: [1, 2, 3], sold: [0, 0, 0]),
                         ItemData(id: "unique3", opened: false, imageData: imageData2, title: "T-Shirt 3", options: ["S", "M", "L", "XL", "XXL"], stock: [1, 2, 3], sold: [0, 0, 0]),
                         ItemData(id: "unique4", opened: false, imageData: imageData, title: "T-Shirt 4", options: ["S", "M"], stock: [1, 2, 3], sold: [0, 0, 0]),
                         ItemData(id: "unique5", opened: false, imageData: imageData1, title: "T-Shirt 5", options: ["S", "M", "L", "XL"], stock: [1, 2, 3], sold: [0, 0, 0]),
                         ItemData(id: "unique6", opened: false, imageData: imageData2, title: "T-Shirt 6", options: ["XS", "S", "M", "L", "XL", "XXL"], stock: [1, 2, 3], sold: [0, 0, 0]),
                         ItemData(id: "unique7", opened: false, imageData: imageData, title: "T-Shirt 7", options: ["S", "M", "L"], stock: [1, 2, 3], sold: [0, 0, 0])]
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(stockItemsData), forKey:"stockItemsData")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		if let data = UserDefaults.standard.value(forKey:"stockItemsData") as? Data {
			stockItemsData = try! PropertyListDecoder().decode(Array<ItemData>.self, from: data)
		}
		
		self.tableView.reloadData()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func setupNavBar() {
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(tapButton))
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(tapButton))
        self.navigationItem.title = "Berlin: 467€"
		
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	func setupSearchBar() {
		searchController = UISearchController(searchResultsController: nil)
		navigationItem.searchController = searchController
		
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search Session"
		navigationItem.searchController = searchController
		definesPresentationContext = true
	}
	
	func updateSearchResults(for searchController: UISearchController) {
		filterContentForSearchText(searchController.searchBar.text!)
	}

	func searchBarIsEmpty() -> Bool {
		return searchController.searchBar.text?.isEmpty ?? true
	}
	
	func filterContentForSearchText(_ searchText: String, scope: String = "All") {
		filteredItems = stockItemsData.filter({( item : ItemData) -> Bool in
			return item.title.lowercased().contains(searchText.lowercased())
		})
		
		tableView.reloadData()
	}
	
	func isFiltering() -> Bool {
		return searchController.isActive && !searchBarIsEmpty()
	}
	
    override func numberOfSections(in tableView: UITableView) -> Int {
		return isFiltering() ? filteredItems.count : stockItemsData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if stockItemsData[section].opened {
            return stockItemsData[section].options.count + 1
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? FirstTableViewCell
		let item = isFiltering() ? filteredItems[indexPath.section] : stockItemsData[indexPath.section]
		cell?.parentViewController = self
		cell?.cellImage.image = UIImage(data: item.imageData)
		cell?.cellTitle.text = item.title
		cell?.itemOptions = item.options
		return cell!
    }
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 85
	}
}
