//
//  SecondViewController.swift
//  MerchTwo
//
//  Created by JSudau on 04.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class ThirdTableViewController: UITableViewController {
	
	let cellContent = ["some", "items", "that", "we", "want", "to", "sell"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavBar()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func setupNavBar() {
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(tapButton))
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapButton))
		self.navigationItem.title = "Bestand"
		
		navigationController?.navigationBar.prefersLargeTitles = true
		
		let searchController = UISearchController(searchResultsController: nil)
		navigationItem.searchController = searchController
	}
	
	@objc func tapButton() {
		print("You tapped!")
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellContent.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ThirdTableViewCell
		//let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
		
		//cell!.textLabel?.text = cellContent[indexPath.row]
		
		cell?.parentViewController = self
		
		return cell!
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 85
	}
}
