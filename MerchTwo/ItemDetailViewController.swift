//
//  ItemDetailViewController.swift
//  MerchTwo
//
//  Created by JSudau on 08.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
	
	var item = itemData()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = item.title
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showSessionItemDetailView"{
			let vc = segue.destination as! ItemDetailViewController
			vc.item = sender as! itemData
		}
	}
}

