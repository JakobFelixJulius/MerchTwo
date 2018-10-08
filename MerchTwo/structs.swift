//
//  structs.swift
//  MerchTwo
//
//  Created by Jakob Sudau on 06.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import Foundation

//--------------------------------------------------------------
struct itemData: Codable {
	var id = String()
    var opened = Bool()
    var imageData = Data()
    var title = String()
    var options = [String]()
    var stock = [Int]()
    var sold = [Int]()
}

//--------------------------------------------------------------
struct appData: Codable {
    var currentUser = String()
    var loggedIn = Bool()
	var stock = stockData()
	var sessions = [sessionData]()
}

//--------------------------------------------------------------
struct stockData: Codable {
    var stockItems = [itemData]()
	
	mutating func addStockItem(item: itemData) {
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
}

//--------------------------------------------------------------
struct sessionData: Codable {
    var sessionItems = [itemData]()
    var revenue = Float()
	
	mutating func setRevenue(value: Float) {
		self.revenue = value
	}
	
	func getRevenue() -> Float {
		return self.revenue
	}
	
	mutating func addSessionItem(item: itemData) {
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
}
