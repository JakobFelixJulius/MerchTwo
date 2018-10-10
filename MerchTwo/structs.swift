//
//  structs.swift
//  MerchTwo
//
//  Created by Jakob Sudau on 06.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import Foundation

//--------------------------------------------------------------
struct ItemData: Codable {
	var id = String()
    var opened = Bool()
    var imageData = Data()
    var title = String()
    var options = [String]()
	var price = Float()
    var stock = [Int]()
    var sold = [Int]()
}

//--------------------------------------------------------------
struct AppData: Codable {
    var currentUser = String()
    var loggedIn = Bool()
	var currency = String()
	var stock = StockData()
	var sessions = [SessionData]()
	
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
}

//--------------------------------------------------------------
struct SessionData: Codable {
	var id = String()
    var sessionItems = [ItemData]()
    var revenue = Float()
	
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
}
