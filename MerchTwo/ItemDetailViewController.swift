//
//  ItemDetailViewController.swift
//  MerchTwo
//
//  Created by JSudau on 08.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource {
	
	
	@IBOutlet weak var tableView: UITableView!
	var item = ItemData()
    var addItem = Bool()
	var titleNames = ["", "Title", "Options", "Stock"]
	let imagePickerController = UIImagePickerController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if addItem {
			item.imageData = UIImagePNGRepresentation(UIImage(named: "tshirt1.png")!)! as Data
			item.title = "New Item"
		}
		
		setupTabAndToolBar()
		setupNavBar()
		setupImagePicker()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		if !addItem {
			globalAppData.stock.stockItems[globalAppData.stock.findStockItemIndex(item: item)] = item
			//globalAppData.sessions[globalAppData.activeSession].sessionItems[globalAppData.stock.findStockItemIndex(item: item)] = item
		} else {
			globalAppData.stock.stockItems.append(item)
		}
	}
	
	func setupNavBar() {
		navigationController?.setNavigationBarHidden(false, animated: true)
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.hidesBackButton = true
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done(_:)))
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Option", style: .plain, target: self, action: #selector(addOption(_:)))
		
		if addItem {
			self.navigationItem.title = "Add"
		} else {
			self.navigationItem.title = "Details"
		}
	}
	
	func setupTabAndToolBar() {
		self.tabBarController?.tabBar.isHidden = true
		self.navigationController?.setToolbarHidden(true, animated: true)
//		let addOption = UIBarButtonItem(title: "Add Option", style: .plain, target: self, action: #selector(addOption(_:)))
//		let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//		toolbarItems = [addOption, spacer]
	}
	
	func setupImagePicker() {
		imagePickerController.delegate = self
		imagePickerController.allowsEditing = false
		
		if let popoverController = self.popoverPresentationController {
			popoverController.sourceView = self.view
			popoverController.sourceRect = CGRect(x: (self.view.bounds.midX), y: (self.view.bounds.midY), width: 0, height: 0)
			popoverController.permittedArrowDirections = []
		}
	}
	
	@objc func addOption(_ sender: Any) {
		
		
		item.configuration.options.append("new option")
		item.configuration.stock.append(0)

		// Appending new item to table view
		self.tableView.beginUpdates()
		let indexPath1 = IndexPath(row: item.configuration.options.count - 1, section: 2)
		let indexPath2 = IndexPath(row: item.configuration.stock.count - 1, section: 3)
		self.tableView.insertRows(at: [indexPath1, indexPath2], with: .automatic)
		self.tableView.endUpdates()
	}
	
	@objc func done(_ sender: Any) {
		self.navigationController?.popToRootViewController(animated: true)
	}
	
	@objc func imageTapped(_ sender: Any) {
		createAlert(title: "Would you like to import or take a picture?", message: "You can import images from your Camera Roll or take a picture.", options: ["Camera Roll", "Take a Picture"], sender: sender)
	}
	
	func createAlert(title: String, message: String, options: [String], sender: Any) {
		let alert = UIAlertController(title: "Would you like to import or take a picture?", message: "You can import images from your Camera Roll or take a picture.", preferredStyle: .actionSheet)

		alert.addAction(UIAlertAction(title: "Camera Roll", style: .default , handler:{ (UIAlertAction)in
			self.imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
			self.present(self.imagePickerController, animated: true, completion: nil)
		}))
		
		alert.addAction(UIAlertAction(title: "Take a Picture", style: .default , handler:{ (UIAlertAction)in
            self.imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
			self.present(self.imagePickerController, animated: true, completion: nil)
		}))
		
		alert.addAction(UIAlertAction(title: "Abbruch", style: .cancel, handler:{ (UIAlertAction)in
			print("User click Dismiss button")
		}))
		
		self.present(alert, animated: true, completion: nil)
	}
    
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
			let imageData:Data = UIImagePNGRepresentation(image)! as Data
			item.imageData = imageData
		} else {
			print("There was a problem getting the image")
		}
		picker.dismiss(animated: true, completion: nil)
	}

	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true, completion: nil)
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 4
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 0
		} else if section == 1 {
			return 1
		} else {
			return item.configuration.options.count == 0 ? 1 : item.configuration.options.count
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 1 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ItemDetailViewCell
			cell?.cellTextField.placeholder = "add an item title"
			return cell!
			
		} else if indexPath.section == 2{
			let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ItemDetailViewCell
			cell?.cellTextField.placeholder = "add an option"
			return cell!
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell") as? ItemDetailViewOptionCell
			cell?.cellTextField.placeholder = "add a stock for this option"
			return cell!
		}
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return titleNames[section]
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
	{
		// This is where you would change section header content
		if section == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as? ItemDetailViewHeaderCell
			
			let pictureTap = UITapGestureRecognizer(target: self, action: #selector(ItemDetailViewController.imageTapped(_:)))
			cell?.cellImage.addGestureRecognizer(pictureTap)
			cell?.cellImage.isUserInteractionEnabled = true
			
			return cell
		}
		return nil
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
	{
		if section == 0 {
			return 148
		} else if section == 1 {
			//skip section 1 because no title can be displayed
			return 0
		} else {
			return 44
		}
	}
}

