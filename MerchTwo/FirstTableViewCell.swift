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
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	@IBAction func sell(_ sender: Any) {
		let alert = UIAlertController(title: "Label", message: "Wähle die zu verkaufende Option", preferredStyle: .actionSheet)
		
		alert.addAction(UIAlertAction(title: "XS", style: .default , handler:{ (UIAlertAction)in
			print("User click XS button")
		}))
		
		alert.addAction(UIAlertAction(title: "S", style: .default , handler:{ (UIAlertAction)in
			print("User click S button")
		}))
		
		alert.addAction(UIAlertAction(title: "M", style: .default , handler:{ (UIAlertAction)in
			print("User click M button")
		}))
		
		alert.addAction(UIAlertAction(title: "L", style: .default , handler:{ (UIAlertAction)in
			print("User click L button")
		}))
		
		alert.addAction(UIAlertAction(title: "XL", style: .default , handler:{ (UIAlertAction)in
			print("User click XL button")
		}))
		
		alert.addAction(UIAlertAction(title: "XXL", style: .default , handler:{ (UIAlertAction)in
			print("User click XXL button")
		}))
		
		alert.addAction(UIAlertAction(title: "Abbruch", style: .cancel, handler:{ (UIAlertAction)in
			print("User click Dismiss button")
		}))
		
		parentViewController?.present(alert, animated: true, completion: {
			print("completion block")
		})
		
	}
}
