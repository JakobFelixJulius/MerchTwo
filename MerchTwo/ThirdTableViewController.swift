//
//  SecondViewController.swift
//  MerchTwo
//
//  Created by JSudau on 04.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class ThirdTableViewController: UITableViewController {
	
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
		
		navigationController?.navigationBar.prefersLargeTitles = true
		
		let searchController = UISearchController(searchResultsController: nil)
		navigationItem.searchController = searchController
	}
	
	@objc func tapButton() {
		print("You tapped!")
	}
}
