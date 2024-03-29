//
//  SessionTableViewCell.swift
//  MerchTwo
//
//  Created by JSudau on 04.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class SessionTableViewCell: UITableViewCell {
	
	weak var parentSessionTableViewController : SessionTableViewController?
    weak var parentStockTableViewController : StockTableViewController?
	var itemOptions = [String]()
	var isPromo: Bool!
	
	@IBOutlet weak var cellImage: UIImageView!
	@IBOutlet weak var cellTitle: UILabel!
	@IBOutlet weak var cellSubtitle: UILabel!
	@IBOutlet weak var sellButton: UIStepper!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
        if parentSessionTableViewController != nil {
            print("second")
        } else if parentStockTableViewController != nil {
            print("third")
        }
		
		isPromo = false
		cellImage.layer.cornerRadius = self.cellImage.frame.size.width / 2
		cellImage.clipsToBounds = true
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		// Configure the view for the selected state
	}
	
	override func setEditing(_ editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		
		if parentSessionTableViewController != nil {
			sellButton.isHidden = isEditing
		}
	}
	
	func createSwitch () -> UISwitch {
		let switchControl = UISwitch(frame: CGRect(x:125, y:38, width:0, height:0))
		switchControl.isOn = false
		switchControl.setOn(false, animated: false)
		switchControl.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)
		return switchControl
	}
	
	@objc func switchValueDidChange(sender: UISwitch!) {
		print("Switch Value : \(sender.isOn)")
		isPromo = sender.isOn
		
	}
	
	@IBAction func sell(_ sender: UIStepper) {
		var isAdd = false
		
		if (sender).value == 1.0 {
			isAdd = true
		}else if (sender).value == -1.0 {
			isAdd = false
		}
		
		
		let alert = UIAlertController(title: "Promo", message: " ", preferredStyle: .actionSheet)
		
		alert.view.addSubview(createSwitch())
		
		for option in itemOptions {
			alert.addAction(UIAlertAction(title: option, style: .default , handler:{ (UIAlertAction)in
				print("User click \(option) button with promo set to \(self.isPromo!) and isAdd set to \(isAdd)")
				self.parentSessionTableViewController?.navigationItem.title = "Berlin: 536€"
			}))
		}
		
		alert.addAction(UIAlertAction(title: "Abbruch", style: .cancel, handler:{ (UIAlertAction)in
			print("User click Dismiss button")
		}))
		
		if let popoverController = alert.popoverPresentationController {
			popoverController.sourceView = parentSessionTableViewController?.view
			popoverController.sourceRect = CGRect(x: (parentSessionTableViewController?.view.bounds.midX)!, y: (parentSessionTableViewController?.view.bounds.midY)!, width: 0, height: 0)
			popoverController.permittedArrowDirections = []
		}
		
		parentSessionTableViewController?.present(alert, animated: true, completion: {
			print("completion block")
		})
		
		sender.value = 0
	}
}

