//
//  SessionViewController.swift
//  MerchTwo
//
//  Created by JSudau on 04.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class SessionTableViewController: UITableViewController, UISearchResultsUpdating {
	
	var stockItemsData = [ItemData]()
    var filteredItems = [ItemData]()
    var searchController = UISearchController()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavBar()
        setupSearchBar()
		
		let image = UIImage(named: "tshirt1.png")
		let imageData:Data = UIImagePNGRepresentation(image!)! as Data
		
		let image1 = UIImage(named: "tshirt2.png")
		let imageData1:Data = UIImagePNGRepresentation(image1!)! as Data
		
		let image2 = UIImage(named: "tshirt3.png")
		let imageData2:Data = UIImagePNGRepresentation(image2!)! as Data
		
		stockItemsData = [ItemData(id: "unique1", opened: false, imageData: imageData, title: "Tour T-Shirt", options: ["S", "M", "L"], price: 15.0, stock: [1, 2, 3], sold: [33, 0, 2]),
						  ItemData(id: "unique2", opened: false, imageData: imageData1, title: "Black T-Shirt", options: ["XS", "S", "M", "L", "XL"], price: 18.0, stock: [1, 2, 3], sold: [100, 30, 3]),
						  ItemData(id: "unique3", opened: false, imageData: imageData2, title: "Hoodie White", options: ["S", "M", "L", "XL", "XXL"], price: 30.0, stock: [1, 2, 3], sold: [2, 0, 6]),
						  ItemData(id: "unique4", opened: false, imageData: imageData, title: "Gymbag", options: ["S", "M"], price: 12.5, stock: [1, 2, 3], sold: [0, 0, 18]),
						  ItemData(id: "unique5", opened: false, imageData: imageData1, title: "Poster 2. Album", options: ["S", "M", "L", "XL"], price: 5.0, stock: [1, 2, 3], sold: [1000, 98, 500]),
						  ItemData(id: "unique6", opened: false, imageData: imageData2, title: "Songbook Session Edition 1. Album", options: ["XS", "S", "M", "L", "XL", "XXL"], price: 20.0, stock: [1, 2, 3], sold: [9000, 900, 99]),
						  ItemData(id: "unique7", opened: false, imageData: imageData, title: "Lighter", options: ["S", "M", "L"], price: 3.5, stock: [1, 2, 3], sold: [0, 2, 0])]
		
		UserDefaults.standard.set(try? PropertyListEncoder().encode(stockItemsData), forKey:"stockItemsData")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		if let data = UserDefaults.standard.value(forKey:"stockItemsData") as? Data {
			stockItemsData = try! PropertyListDecoder().decode(Array<ItemData>.self, from: data)
		}
		
		self.tableView.reloadData()
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
			let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SessionTableViewCell
            let item = isFiltering() ? filteredItems[indexPath.section] : stockItemsData[indexPath.section]
			cell?.parentSessionTableViewController = self
            cell?.cellImage.image = UIImage(data: item.imageData)
			cell?.cellTitle.text = item.title
			cell?.cellSubtitle.text = "\(item.price.clean)€, \(item.sold.reduce(0, +)) sold"
			cell?.itemOptions = item.options
			cell?.editingAccessoryType = .disclosureIndicator
			return cell!
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "SubCell") as? SessionTableViewSubCell
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

extension Float {
	var clean: String {
		return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
	}
}
