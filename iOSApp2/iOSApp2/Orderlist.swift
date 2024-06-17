//
//  Orderlist.swift
//  iOSApp2
//
//  Created by Sumana Dhital on 2024-06-16.
//

import UIKit

// Class representing an order list containing multiple items
class Orderlist: NSObject, Codable {
    
    // The name of the order list
    var name = ""
    
    // The items in the order list
    var items = [OrderlistItem]()
    
    // Initializer to create an order list with a given name
    init(name: String) {
      self.name = name
      super.init()
    }

}
