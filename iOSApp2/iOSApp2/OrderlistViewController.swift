//
//  ViewController.swift
//  iOSApp2
//
//  Created by Sumana Dhital on 2024-06-08.
//

import UIKit

// Main view controller class for displaying the order list
class OrderlistViewController: UITableViewController, AddToOrderViewControllerDelegate  {
    
    var orderlist: Orderlist!

    // Method called after the view has been loaded
    override func viewDidLoad() {
      super.viewDidLoad()
      
      // Disable large titles for this view controller
      navigationItem.largeTitleDisplayMode = .never
      
      // Set the title of the view controller to the order list name
      title = orderlist.name
    }


    // Configure the checkmark for a given cell and item
    func configureCheckmark(
      for cell: UITableViewCell,
      with item: OrderlistItem
    ) {
      let label = cell.viewWithTag(1001) as! UILabel

      // Set the checkmark if the item is checked
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
      return orderlist.items.count
    }

    // Configure and return the cell for a given index path
    override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "OrderlistItem",
        for: indexPath)

      let item = orderlist.items[indexPath.row]

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
        let item = orderlist.items[indexPath.row]
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
      orderlist.items.remove(at: indexPath.row)

      // 2. Delete the row from the table view
      let indexPaths = [indexPath]
      tableView.deleteRows(at: indexPaths, with: .automatic)
    }


    // MARK: - Actions

    // MARK: - Add Item ViewController Delegates
    // Handle the cancel action from AddToOrderViewController
    func addOrderViewControllerDidCancel(
      _ controller: AddOrderViewController
    ) {
      navigationController?.popViewController(animated: true)
    }

    // Handle adding a new item from AddToOrderViewController
    func addOrderViewController(
      _ controller: AddOrderViewController,
      didFinishAdding item: OrderlistItem
    ) {
      let newRowIndex = orderlist.items.count
      orderlist.items.append(item)

      let indexPath = IndexPath(row: newRowIndex, section: 0)
      let indexPaths = [indexPath]
      tableView.insertRows(at: indexPaths, with: .automatic)
      navigationController?.popViewController(animated:true)
    }
    
    // Handle editing an existing item from AddToOrderViewController
    func addOrderViewController(
      _ controller: AddOrderViewController,
      didFinishEditing item: OrderlistItem
    ) {
      if let index = orderlist.items.firstIndex(of: item) {
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
        let controller = segue.destination as! AddOrderViewController
        // 3. Set the delegate to self
        controller.delegate = self
      } else if segue.identifier == "EditItem" {
          let controller = segue.destination as! AddOrderViewController
          controller.delegate = self

          if let indexPath = tableView.indexPath(
            for: sender as! UITableViewCell) {
            controller.itemToEdit = orderlist.items[indexPath.row]
          }
        }
      }

}

