//
//  SelectSessionItemCell.swift
//  MerchTwo
//
//  Created by JSudau on 10.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class SelectSessionItemCell: UITableViewCell {
	
	@IBOutlet weak var cellImage: UIImageView!
	@IBOutlet weak var cellTitle: UILabel!
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.cellImage.layer.cornerRadius = self.cellImage.frame.size.width / 2
		self.cellImage.clipsToBounds = true
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
}


