//
//  SecondViewController.swift
//  MerchTwo
//
//  Created by JSudau on 04.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class SecondTableViewController: UITableViewController, UISearchResultsUpdating {
	
	var stockItemsData = [ItemData]()
    var filteredItems = [ItemData]()
    var searchController = UISearchController()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavBar()
        setupSearchBar()
        
        if let data = UserDefaults.standard.value(forKey:"stockItemsData") as? Data {
            stockItemsData = try! PropertyListDecoder().decode(Array<ItemData>.self, from: data)
        }
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func setupNavBar() {
		var right1 = UIBarButtonItem()
		var right2 = UIBarButtonItem()
		if self.tableView.isEditing {
			right1 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem(_:)))
		} else {
			right1 = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(saveSession(_:)))
			right2 = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(newSession(_:)))
		}
        self.navigationItem.rightBarButtonItems = [right1, right2]
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: (self.tableView.isEditing ? "Done" : "Edit"), style: .plain, target: self, action: #selector(editSession(_:)))
		self.navigationItem.title = "Berlin: 0€"
		
		navigationController?.navigationBar.prefersLargeTitles = true
        
//        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
//        textField.text = "Title"
//        textField.font = UIFont.systemFont(ofSize: 19)
//        textField.textColor = UIColor.black
//        textField.textAlignment = .center
//        self.navigationItem.titleView = textField
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
    
	@objc func addItem(_ sender: Any) {
		print("adding item to session...")
	}
	
	@objc func newSession(_ sender: Any) {
        createAlert(title: "Would you like to start a new session?", message: "All current sales will be reset. The stock stays the same.", options: ["Yes", "No"], sender: sender)
    }
    
    @objc func saveSession(_ sender: Any) {
        createAlert(title: "Would you like to save the current session?", message: "All current sales will be sent as mail.", options: ["Yes", "No"], sender: sender)
    }
    
    @objc func editSession(_ sender: Any) {
		self.tableView.setEditing(!self.tableView.isEditing, animated: true)
		setupNavBar()
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
	
	override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		let movedObject = self.stockItemsData[sourceIndexPath.row]
		stockItemsData.remove(at: sourceIndexPath.row)
		stockItemsData.insert(movedObject, at: destinationIndexPath.row)
		UserDefaults.standard.set(try? PropertyListEncoder().encode(stockItemsData), forKey:"stockItemsData")
	}
	
	override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
	{
		let deleteAction = UIContextualAction(style: .destructive, title: "Edit") { (action, view, handler) in
			print("Add Action Tapped")
		}
		deleteAction.backgroundColor = .orange
		let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
		return configuration
	}
	
	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
	{
		let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
			print("Delete Action Tapped")
		}
		deleteAction.backgroundColor = .red
		let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
		return configuration
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
        let dataIndex = indexPath.row - 1
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SecondTableViewCell
            let item = isFiltering() ? filteredItems[indexPath.section] : stockItemsData[indexPath.section]
			cell?.parentSecondTableViewController = self
            cell?.cellImage.image = UIImage(data: item.imageData)
			cell?.cellTitle.text = item.title
			cell?.editingAccessoryType = .disclosureIndicator
			return cell!
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "SubCell") as? SecondTableViewSubCell
			cell?.textLabel?.text = stockItemsData[indexPath.section].options[dataIndex]
			return cell!
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 0  {
			if self.tableView.isEditing {
				let item = stockItemsData[indexPath.section]
				performSegue(withIdentifier: "showSessionItemDetailView", sender: item)
			} else {
				if stockItemsData[indexPath.section].opened == true {
					stockItemsData[indexPath.section].opened = false
					let sections = IndexSet.init(integer: indexPath.section)
					tableView.reloadSections(sections, with: .none)
				} else {
					stockItemsData[indexPath.section].opened = true
					let sections = IndexSet.init(integer: indexPath.section)
					tableView.reloadSections(sections, with: .none)
				}
			}
        }
	}
	
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 85
        } else {
            return 44
        }
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if(segue.identifier == "showSessionItemDetailView") {
			if let destination = segue.destination as? ItemDetailViewController {
				destination.item = sender as! ItemData
			}
		}
	}
}
