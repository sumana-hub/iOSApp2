//
//  ViewController.swift
//  iOSApp2
//
//  Created by Sumana Dhital on 2024-06-08.
//

import UIKit

// Main view controller class for displaying the order list
class OrderlistViewController: UITableViewController, AddToOrderViewControllerDelegate  {

    // Array to hold order list items
    var items = [OrderlistItem]()
    
    // Method called after the view has been loaded
    override func viewDidLoad() {
      super.viewDidLoad()
      navigationController?.navigationBar.prefersLargeTitles = true
    
    // Create initial order list items and add them to the items array
      let item1 = OrderlistItem()
      item1.text = "Medium Double Double"
      items.append(item1)

      let item2 = OrderlistItem()
      item2.text = "Four Cheese Bagel"
      item2.checked = true
      items.append(item2)

      let item3 = OrderlistItem()
      item3.text = "Mocha Iced Cap"
      item3.checked = true
      items.append(item3)

      let item4 = OrderlistItem()
      item4.text = "Grilled Chicken Wrap"
      items.append(item4)

      let item5 = OrderlistItem()
      item5.text = "Peach Quenchers"
      items.append(item5)
    }

    // Configure the checkmark for a given cell and item
    func configureCheckmark(
      for cell: UITableViewCell,
      with item: OrderlistItem
    ) {
      let label = cell.viewWithTag(1001) as! UILabel

      if item.checked {
        label.text = "√"
      } else {
        label.text = ""
      }
    }

    // Configure the text for a given cell and item
    func configureText(
      for cell: UITableViewCell,
      with item: OrderlistItem
    ) {
      let label = cell.viewWithTag(1000) as! UILabel
      label.text = item.text
    }


    // MARK: - Table View Data Source
    // Return the number of rows in the section
    override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
      return items.count
    }

    // Configure and return the cell for a given index path
    override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "OrderlistItem",
        for: indexPath)

      let item = items[indexPath.row]

      configureText(for: cell, with: item)
      configureCheckmark(for: cell, with: item)
      return cell
    }

    // MARK: - Table View Delegate
    // Handle the row selection to toggle the checkmark
    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ) {
      if let cell = tableView.cellForRow(at: indexPath) {
        let item = items[indexPath.row]
        item.checked.toggle()
        configureCheckmark(for: cell, with: item)
      }
      tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Handle the deletion of a row
    override func tableView(
      _ tableView: UITableView,
      commit editingStyle: UITableViewCell.EditingStyle,
      forRowAt indexPath: IndexPath
    ) {
      // 1. Remove the item from the data source
      items.remove(at: indexPath.row)

      // 2. Delete the row from the table view
      let indexPaths = [indexPath]
      tableView.deleteRows(at: indexPaths, with: .automatic)
    }


    // MARK: - Actions

    // MARK: - Add Item ViewController Delegates
    // Handle the cancel action from AddToOrderViewController
    func addToOrderViewControllerDidCancel(
      _ controller: AddToOrderViewController
    ) {
      navigationController?.popViewController(animated: true)
    }

    // Handle adding a new item from AddToOrderViewController
    func addToOrderViewController(
      _ controller: AddToOrderViewController,
      didFinishAdding item: OrderlistItem
    ) {
      let newRowIndex = items.count
      items.append(item)

      let indexPath = IndexPath(row: newRowIndex, section: 0)
      let indexPaths = [indexPath]
      tableView.insertRows(at: indexPaths, with: .automatic)
      navigationController?.popViewController(animated:true)
    }
    
    // Handle editing an existing item from AddToOrderViewController
    func addToOrderViewController(
      _ controller: AddToOrderViewController,
      didFinishEditing item: OrderlistItem
    ) {
      if let index = items.firstIndex(of: item) {
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) {
          configureText(for: cell, with: item)
        }
      }
      navigationController?.popViewController(animated: true)
    }


    // MARK: - Navigation
    // Prepare for the segue to AddToOrderViewController
    override func prepare(
      for segue: UIStoryboardSegue,
      sender: Any?
    ) {
      // 1. Check the identifier of the segue
      if segue.identifier == "AddItem" {
        // 2. Get the destination view controller
        let controller = segue.destination as! AddToOrderViewController
        // 3. Set the delegate to self
        controller.delegate = self
      } else if segue.identifier == "EditItem" {
          let controller = segue.destination as! AddToOrderViewController
          controller.delegate = self

          if let indexPath = tableView.indexPath(
            for: sender as! UITableViewCell) {
            controller.itemToEdit = items[indexPath.row]
          }
        }
      }

}

