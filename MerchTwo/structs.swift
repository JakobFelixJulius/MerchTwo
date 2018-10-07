//
//  structs.swift
//  MerchTwo
//
//  Created by Jakob Sudau on 06.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import Foundation

struct itemData: Codable {
    var opened = Bool()
    var imageData = Data()
    var title = String()
    var options = [String]()
    var stock = [Int]()
    var sold = [Int]()
}

struct appData: Codable {
    var currentUser = String()
    var loggedIn = Bool()
}

struct stockData: Codable {
    var stockItems = [itemData]()
}

struct sessionData: Codable {
    var sessionItems = [itemData]()
    var revenue = Float()
}
