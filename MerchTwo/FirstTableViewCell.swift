//
//  FirstTableViewCell.swift
//  MerchTwo
//
//  Created by JSudau on 04.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
	
	@IBOutlet weak var cellImage: UIImageView!
	@IBOutlet weak var cellTitle: UILabel!
	weak var parentViewController : FirstTableViewController?
	var itemOptions = [String]()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.cellImage.layer.cornerRadius = self.cellImage.frame.size.width / 2
		self.cellImage.clipsToBounds = true
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
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
		
	}
	
	@IBAction func sell(_ sender: Any) {
		let alert = UIAlertController(title: "Promo", message: " ", preferredStyle: .actionSheet)
		
		alert.view.addSubview(createSwitch())
		
		for option in itemOptions {
			alert.addAction(UIAlertAction(title: option, style: .default , handler:{ (UIAlertAction)in
				print("User click \(option) button")
			}))
		}
		
		alert.addAction(UIAlertAction(title: "Abbruch", style: .cancel, handler:{ (UIAlertAction)in
			print("User click Dismiss button")
		}))
		
		if let popoverController = alert.popoverPresentationController {
			popoverController.sourceView = parentViewController?.view
			popoverController.sourceRect = CGRect(x: (parentViewController?.view.bounds.midX)!, y: (parentViewController?.view.bounds.midY)!, width: 0, height: 0)
			popoverController.permittedArrowDirections = []
		}
		
		parentViewController?.present(alert, animated: true, completion: {
			print("completion block")
		})
		
	}
}
