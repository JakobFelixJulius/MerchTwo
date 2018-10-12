//
//  structs.swift
//  MerchTwo
//
//  Created by Jakob Sudau on 06.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import Foundation
import UIKit

//--------------------------------------------------------------
struct ItemConfiguration: Codable {
	var options = [String]()
	var stock = [Int]()
	var sold = [Int]()
}

//--------------------------------------------------------------
struct ItemData: Codable {
	var id = String()
    var opened = Bool()
    var imageData = Data()
    var title = String()
	var price = Float()
    var configuration = ItemConfiguration()
}

//--------------------------------------------------------------
struct AppData: Codable {
    var currentUser = String()
    var loggedIn = Bool()
	var currency = String()
	var activeSession = Int()
	var sessions = [SessionData]()
	var stock = StockData()
	
	mutating func addSession(session: SessionData) {
		self.sessions.append(session)
	}
	
	mutating func deleteSession(id: String) {
		for i in 0..<self.sessions.count {
			if self.sessions[i].id == id {
				self.sessions.remove(at: i)
				break
			}
		}
	}
}

//--------------------------------------------------------------
struct StockData: Codable {
    var stockItems = [ItemData]()
	
	mutating func addStockItem(item: ItemData) {
		self.stockItems.append(item)
	}
	
	mutating func deleteStockItem(id: String) {
		for i in 0..<self.stockItems.count {
			if self.stockItems[i].id == id {
				self.stockItems.remove(at: i)
				break
			}
		}
	}
	
	func findStockItemIndex(item: ItemData) -> Int {
		var value = -1
		for i in 0..<self.stockItems.count {
			if self.stockItems[i].id == item.id {
				value = i
			}
		}
		return value
	}
}

//--------------------------------------------------------------
struct SessionData: Codable {
	var id = String()
	var revenue = Float()
    var sessionItems = [ItemData]()
	
	mutating func setRevenue(value: Float) {
		self.revenue = value
	}
	
	func getRevenue() -> Float {
		return self.revenue
	}
	
	mutating func addSessionItem(item: ItemData) {
		self.sessionItems.append(item)
	}
	
	mutating func deleteSessionItem(id: String) {
		for i in 0..<self.sessionItems.count {
			if self.sessionItems[i].id == id {
				self.sessionItems.remove(at: i)
				break
			}
		}
	}
	
	func findStockItemIndex(item: ItemData) -> Int {
		var value = -1
		for i in 0..<self.sessionItems.count {
			if self.sessionItems[i].id == item.id {
				value = i
			}
		}
		return value
	}
}

//--------------------------------------------------------------
func initAppData() -> AppData{
//	let image = UIImage(named: "tshirt1.png")
//	let imageData:Data = UIImagePNGRepresentation(image!)! as Data
//
//	let image1 = UIImage(named: "tshirt2.png")
//	let imageData1:Data = UIImagePNGRepresentation(image1!)! as Data
//
//	let image2 = UIImage(named: "tshirt3.png")
//	let imageData2:Data = UIImagePNGRepresentation(image2!)! as Data
//
//	let stockItemsData = [ItemData(id: "unique1", opened: false, imageData: imageData, title: "Tour T-Shirt", options: ["S", "M", "L"], price: 15.0, stock: [1, 2, 3], sold: [33, 0, 2]),
//						  ItemData(id: "unique2", opened: false, imageData: imageData1, title: "Black T-Shirt", options: ["XS", "S", "M", "L", "XL"], price: 18.0, stock: [1, 2, 3], sold: [100, 30, 3]),
//						  ItemData(id: "unique3", opened: false, imageData: imageData2, title: "Hoodie White", options: ["S", "M", "L", "XL", "XXL"], price: 30.0, stock: [1, 2, 3], sold: [2, 0, 6]),
//						  ItemData(id: "unique4", opened: false, imageData: imageData, title: "Gymbag", options: ["S", "M"], price: 12.5, stock: [1, 2, 3], sold: [0, 0, 18]),
//						  ItemData(id: "unique5", opened: false, imageData: imageData1, title: "Poster 2. Album", options: ["S", "M", "L", "XL"], price: 5.0, stock: [1, 2, 3], sold: [1000, 98, 500]),
//						  ItemData(id: "unique6", opened: false, imageData: imageData2, title: "Songbook Session Edition 1. Album", options: ["XS", "S", "M", "L", "XL", "XXL"], price: 20.0, stock: [1, 2, 3], sold: [9000, 900, 99]),
//						  ItemData(id: "unique7", opened: false, imageData: imageData, title: "Lighter", options: ["S", "M", "L"], price: 3.5, stock: [1, 2, 3], sold: [0, 2, 0])]
//
//	let sessionItemsData = [stockItemsData[1], stockItemsData[3], stockItemsData[5]]
	
	let stock = StockData(stockItems: /*stockItemsData*/[])
	let session = SessionData(id: "uniqueSession1", revenue: 0.0, sessionItems: /*sessionItemsData*/[])
	
	
	return AppData(currentUser: "",
								loggedIn: false,
								currency: "€",
								activeSession: 0,
								sessions: [session],
								stock: stock)
}

//--------------------------------------------------------------
var globalAppData = initAppData()




