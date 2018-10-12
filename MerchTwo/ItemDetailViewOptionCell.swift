//
//  ItemDetailViewOptionCell.swift
//  MerchTwo
//
//  Created by JSudau on 12.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class ItemDetailViewOptionCell: UITableViewCell, UITextFieldDelegate {

	
	@IBOutlet weak var cellTitle: UILabel!
	@IBOutlet weak var cellTextField: UITextField!
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.cellTextField.delegate = self
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		endEditing(true)
		return true
	}
}


