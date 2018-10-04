//
//  FirstViewController.swift
//  MerchTwo
//
//  Created by JSudau on 04.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class FirstTableViewController: UITableViewController {

	let cellContent = ["some", "items", "that", "we", "want", "to", "sell"]
    
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
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(saveSession(_:)))
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(newSession(_:)))
		self.navigationItem.title = "Verkauf: 0€"
		
		navigationController?.navigationBar.prefersLargeTitles = true
		
		let searchController = UISearchController(searchResultsController: nil)
		navigationItem.searchController = searchController
	}
	
	@objc func newSession(_ sender: Any) {
		createAlert(title: "Willst du eine neue Session starten?", message: "Alle aktuellen Verkäufe werden zurückgesetzt. Der Bestand bleibt unverändert.", options: ["Ja", "Nein"], sender: sender)
	}
	
	@objc func saveSession(_ sender: Any) {
		createAlert(title: "Willst du die Session speichern?", message: "Alle aktuellen Verkäufe werden per Mail verschickt.", options: ["Ja", "Nein"], sender: sender)
	}
	
	func createAlert(title: String, message: String, options: [String], sender: Any) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
		
		for option in options {
			alert.addAction(UIAlertAction(title: option, style: .default , handler:{ (UIAlertAction)in
				print("User click \(option) button")
			}))
		}
		
		alert.addAction(UIAlertAction(title: "Abbruch", style: .cancel, handler:{ (UIAlertAction)in
			print("User click Dismiss button")
		}))
		
		if let popoverController = alert.popoverPresentationController {
			popoverController.barButtonItem = sender as? UIBarButtonItem
		}
		
		self.present(alert, animated: true, completion: {
			print("completion block")
		})
	}
	
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableViewData[section].opened {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? FirstTableViewCell
        cell?.parentViewController = self
        cell?.cellTitle.text = tableViewData[indexPath.section].title
        cell?.itemOptions = ["XS", "S", "M", "L", "XL", "XXL"]
        return cell!
    }
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 85
	}
}

