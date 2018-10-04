//
//  SecondViewController.swift
//  MerchTwo
//
//  Created by JSudau on 04.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

struct cellData {
	var opened = Bool()
	var title = String()
	var sectionData = [String]()
}

class SecondTableViewController: UITableViewController {
	
	var tableViewData = [cellData]()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavBar()
		tableViewData = [cellData(opened: false, title: "some", sectionData: ["1", "2", "3"]),
						 cellData(opened: false, title: "items", sectionData: ["4", "5", "6"]),
						 cellData(opened: false, title: "that", sectionData: ["7", "8", "9"]),
						 cellData(opened: false, title: "we", sectionData: ["1", "2", "3"]),
						 cellData(opened: false, title: "want", sectionData: ["4", "5", "6"]),
						 cellData(opened: false, title: "to", sectionData: ["7", "8", "9"]),
						 cellData(opened: false, title: "sell", sectionData: ["1", "2", "3"]),]
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func setupNavBar() {
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(tapButton))
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(tapButton))
		self.navigationItem.title = "Verkauf: 0€"
		
		navigationController?.navigationBar.prefersLargeTitles = true
		
		let searchController = UISearchController(searchResultsController: nil)
		navigationItem.searchController = searchController
	}
	
	@objc func tapButton() {
		print("You tapped!")
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewData.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if tableViewData[section].opened {
			return tableViewData[section].sectionData.count
		} else {
			return 1
		}
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SecondTableViewCell
			cell?.parentViewController = self
			cell?.cellTitle.text = tableViewData[indexPath.section].title
			return cell!
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "SubCell") as? SecondTableViewCell
			cell?.cellTitle.text = tableViewData[indexPath.section].sectionData[indexPath.row]
			return cell!
		}
		//cell!.textLabel?.text = cellContent[indexPath.row]
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if tableViewData[indexPath.section].opened == true {
			tableViewData[indexPath.section].opened = false
			let sections = IndexSet.init(integer: indexPath.section)
			tableView.reloadSections(sections, with: .none)
		} else {
			tableViewData[indexPath.section].opened = true
			let sections = IndexSet.init(integer: indexPath.section)
			tableView.reloadSections(sections, with: .none)
		}
		
		// https://www.youtube.com/watch?v=ClrSpJ3txAs this is the tutorial for the expansion
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 85
	}
}
