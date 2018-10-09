//
//  ItemDetailViewController.swift
//  MerchTwo
//
//  Created by JSudau on 08.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
	
	var item = ItemData()
    var addItem = Bool();
    @IBOutlet weak var itemImage: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
        if addItem {
            self.title = "new item"
        } else {
            self.title = item.title
        }
        
        self.itemImage.layer.cornerRadius = self.itemImage.frame.size.width / 2
        self.itemImage.clipsToBounds = true
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showSessionItemDetailView"{
			let vc = segue.destination as! ItemDetailViewController
			vc.item = sender as! ItemData
		}
	}
}

