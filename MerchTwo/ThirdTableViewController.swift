//
//  SecondViewController.swift
//  MerchTwo
//
//  Created by JSudau on 04.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class ThirdTableViewController: UITableViewController {
    
    var stockItemsData = [ItemData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        if let data = UserDefaults.standard.value(forKey:"stockItemsData") as? Data {
            stockItemsData = try! PropertyListDecoder().decode(Array<ItemData>.self, from: data)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: (self.tableView.isEditing ? "Done" : "Edit"), style: .plain, target: self, action: #selector(editSession(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem(_:)))
        self.navigationItem.title = "Stock"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
    }
	
	@objc func editSession(_ sender: Any) {
		self.tableView.setEditing(!self.tableView.isEditing, animated: true)
		setupNavBar()
	}
	
	@objc func addItem(_ sender: Any) {
		print("adding item to stock...")
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
		configuration.performsFirstActionWithFullSwipe = false //HERE..
		return configuration
	}
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return stockItemsData.count
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
            cell?.parentThirdTableViewController = self
            cell?.cellImage.image = UIImage(data: stockItemsData[indexPath.section].imageData)
            cell?.cellTitle.text = stockItemsData[indexPath.section].title
			cell?.editingAccessoryType = .disclosureIndicator
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubCell") as? SecondTableViewSubCell
            cell?.textLabel?.text = stockItemsData[indexPath.section].options[dataIndex]
            return cell!
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if self.tableView.isEditing {
			let item = stockItemsData[indexPath.row]
			performSegue(withIdentifier: "showStockItemDetailView", sender: item)
		} else {
			if indexPath.row == 0  {
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
		if(segue.identifier == "showStockItemDetailView") {
			if let destination = segue.destination as? ItemDetailViewController {
				destination.item = sender as! ItemData
			}
		}
	}
}
