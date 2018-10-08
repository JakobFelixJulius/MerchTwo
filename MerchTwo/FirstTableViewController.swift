//
//  FirstViewController.swift
//  MerchTwo
//
//  Created by JSudau on 04.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class FirstTableViewController: UITableViewController {
    
    var stockItemsData = [itemData]()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavBar()
        
        let image = UIImage(named: "tshirt1.png")
        let imageData:Data = UIImagePNGRepresentation(image!)! as Data
        
        let image1 = UIImage(named: "tshirt2.png")
        let imageData1:Data = UIImagePNGRepresentation(image1!)! as Data
        
        let image2 = UIImage(named: "tshirt3.png")
        let imageData2:Data = UIImagePNGRepresentation(image2!)! as Data
        
		stockItemsData = [itemData(id: "unique1", opened: false, imageData: imageData, title: "T-Shirt 1", options: ["S", "M", "L"], stock: [1, 2, 3], sold: [0, 0, 0]),
                         itemData(id: "unique2", opened: false, imageData: imageData1, title: "T-Shirt 2", options: ["XS", "S", "M", "L", "XL"], stock: [1, 2, 3], sold: [0, 0, 0]),
                         itemData(id: "unique3", opened: false, imageData: imageData2, title: "T-Shirt 3", options: ["S", "M", "L", "XL", "XXL"], stock: [1, 2, 3], sold: [0, 0, 0]),
                         itemData(id: "unique4", opened: false, imageData: imageData, title: "T-Shirt 4", options: ["S", "M"], stock: [1, 2, 3], sold: [0, 0, 0]),
                         itemData(id: "unique5", opened: false, imageData: imageData1, title: "T-Shirt 5", options: ["S", "M", "L", "XL"], stock: [1, 2, 3], sold: [0, 0, 0]),
                         itemData(id: "unique6", opened: false, imageData: imageData2, title: "T-Shirt 6", options: ["XS", "S", "M", "L", "XL", "XXL"], stock: [1, 2, 3], sold: [0, 0, 0]),
                         itemData(id: "unique7", opened: false, imageData: imageData, title: "T-Shirt 7", options: ["S", "M", "L"], stock: [1, 2, 3], sold: [0, 0, 0])]
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(stockItemsData), forKey:"stockItemsData")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		if let data = UserDefaults.standard.value(forKey:"stockItemsData") as? Data {
			stockItemsData = try! PropertyListDecoder().decode(Array<itemData>.self, from: data)
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
		
		let searchController = UISearchController(searchResultsController: nil)
		navigationItem.searchController = searchController
	}
    
//    @objc func tapButton() {
//        print("You tapped!")
//    }
	
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? FirstTableViewCell
        cell?.parentViewController = self
        cell?.cellImage.image = UIImage(data: stockItemsData[indexPath.section].imageData)
        cell?.cellTitle.text = stockItemsData[indexPath.section].title
        cell?.itemOptions = stockItemsData[indexPath.section].options
        return cell!
    }
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 85
	}
}

