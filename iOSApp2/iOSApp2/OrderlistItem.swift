//
//  OrderItem.swift
//  iOSApp2
//
//  Created by Sumana Dhital on 2024-06-09.
//

import Foundation

// Class representing an item in the order list
class OrderlistItem: NSObject, Codable  {

  // The text description of the order list item
  var text = ""
    
  // Boolean indicating whether the item is checked
  var checked = false
}

