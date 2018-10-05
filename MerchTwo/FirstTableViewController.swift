//
//  FirstViewController.swift
//  MerchTwo
//
//  Created by JSudau on 04.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

struct itemData: Codable {
    var opened = Bool()
    var imageData = Data()
    var title = String()
    var options = [String]()
    var stock = [Int]()
}

class FirstTableViewController: UITableViewController {
    
    var tableViewData = [itemData]()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavBar()
        
        let image = UIImage(named: "tshirt1.png")
        let imageData:Data = UIImagePNGRepresentation(image!)! as Data
        
        let image1 = UIImage(named: "tshirt2.png")
        let imageData1:Data = UIImagePNGRepresentation(image1!)! as Data
        
        let image2 = UIImage(named: "tshirt3.png")
        let imageData2:Data = UIImagePNGRepresentation(image2!)! as Data
        
        tableViewData = [itemData(opened: false, imageData: imageData, title: "some", options: ["a", "b", "c"], stock: [1, 2, 3]),
                         itemData(opened: false, imageData: imageData1, title: "items", options: ["d", "e", "f"], stock: [1, 2, 3]),
                         itemData(opened: false, imageData: imageData2, title: "that", options: ["g", "h", "i"], stock: [1, 2, 3]),
                         itemData(opened: false, imageData: imageData, title: "we", options: ["j", "k", "l"], stock: [1, 2, 3]),
                         itemData(opened: false, imageData: imageData1, title: "want", options: ["m", "n", "o"], stock: [1, 2, 3]),
                         itemData(opened: false, imageData: imageData2, title: "to", options: ["p", "q", "r"], stock: [1, 2, 3]),
                         itemData(opened: false, imageData: imageData, title: "sell", options: ["s", "t", "u"], stock: [1, 2, 3])]
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(tableViewData), forKey:"tableViewData")
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
            return tableViewData[section].options.count + 1
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? FirstTableViewCell
        cell?.parentViewController = self
        cell?.cellImage.image = UIImage(data: tableViewData[indexPath.section].imageData)
        cell?.cellTitle.text = tableViewData[indexPath.section].title
        cell?.itemOptions = ["XS", "S", "M", "L", "XL", "XXL"]
        return cell!
    }
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 85
	}
}

