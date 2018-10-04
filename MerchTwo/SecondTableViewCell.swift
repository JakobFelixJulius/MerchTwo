//
//  SecondTableViewCell.swift
//  MerchTwo
//
//  Created by JSudau on 04.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class SecondTableViewCell: UITableViewCell {
	
	weak var parentSecondTableViewController : SecondTableViewController?
    weak var parentThirdTableViewController : ThirdTableViewController?
	@IBOutlet weak var cellImage: UIImageView!
	@IBOutlet weak var cellTitle: UILabel!
	@IBOutlet weak var cellSubtitle: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
        if parentSecondTableViewController != nil {
            print("second")
        } else if parentThirdTableViewController != nil {
            print("third")
        }
        
		self.cellImage.layer.cornerRadius = self.cellImage.frame.size.width / 2
		self.cellImage.clipsToBounds = true
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
}

