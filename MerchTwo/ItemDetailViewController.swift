//
//  ItemDetailViewController.swift
//  MerchTwo
//
//  Created by JSudau on 08.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	
	var item = ItemData()
    var addItem = Bool()
    @IBOutlet weak var itemImage: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
        if addItem {
            self.title = "new item"
        } else {
            self.title = item.title
        }
		
		let pictureTap = UITapGestureRecognizer(target: self, action: #selector(ItemDetailViewController.imageTapped(_:)))
		itemImage.addGestureRecognizer(pictureTap)
		itemImage.isUserInteractionEnabled = true
		
		self.itemImage.image = UIImage(data: item.imageData)
        self.itemImage.layer.cornerRadius = self.itemImage.frame.size.width / 2
        self.itemImage.clipsToBounds = true
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		globalAppData.stock.stockItems[globalAppData.stock.findStockItemIndex(item: item)] = item
	}
	
	@objc func imageTapped(_ sender: Any) {
		createAlert(title: "Would you like to import or take a picture?", message: "You can import images from your Camera Roll or take a picture.", options: ["Camera Roll", "Take a Picture"], sender: sender)
	}
	
	func createAlert(title: String, message: String, options: [String], sender: Any) {
		let alert = UIAlertController(title: "Would you like to import or take a picture?", message: "You can import images from your Camera Roll or take a picture.", preferredStyle: .actionSheet)
		
		let imagePickerController = UIImagePickerController()
		imagePickerController.delegate = self
		imagePickerController.allowsEditing = false
		
		alert.addAction(UIAlertAction(title: "Camera Roll", style: .default , handler:{ (UIAlertAction)in
			imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
			self.present(imagePickerController, animated: true, completion: nil)
		}))
		
		alert.addAction(UIAlertAction(title: "Take a Picture", style: .default , handler:{ (UIAlertAction)in
			imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
			self.present(imagePickerController, animated: true, completion: nil)
		}))
		
		alert.addAction(UIAlertAction(title: "Abbruch", style: .cancel, handler:{ (UIAlertAction)in
			print("User click Dismiss button")
		}))
		
		if let popoverController = alert.popoverPresentationController {
			popoverController.barButtonItem = sender as? UIBarButtonItem
		}
		
		self.present(alert, animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
			let imageData:Data = UIImagePNGRepresentation(image)! as Data
			item.imageData = imageData
			itemImage.image = image
		} else {
			print("There was a problem getting the image")
		}
		picker.dismiss(animated: true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true, completion: nil)
	}
}

