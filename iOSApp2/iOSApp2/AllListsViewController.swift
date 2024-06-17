//
//  AllListsViewControllerTableViewController.swift
//  iOSApp2
//
//  Created by Sumana Dhital on 2024-06-14.
//

import UIKit

// View controller to manage and display all order lists
class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {
    
    let cellIdentifier = "OrderlistCell"
    var dataModel: DataModel!

    // Method called after the view has been loaded
    override func viewDidLoad() {
      super.viewDidLoad()
        
      // Enable large titles in the navigation bar
      navigationController?.navigationBar.prefersLargeTitles = true
        
      // Register the cell identifier for table view cells
      tableView.register(
        UITableViewCell.self,
        forCellReuseIdentifier: cellIdentifier)
    }

    // MARK: - Table view data source

    // Return the number of rows in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
    }

    // Configure and return the cell for a given index path
    override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: cellIdentifier,
        for: indexPath)
        
      // Update cell information
      let orderlist = dataModel.lists[indexPath.row]
      cell.textLabel!.text = orderlist.name
      cell.accessoryType = .detailDisclosureButton

      return cell
    }

    // Handle the row selection to show the order list
    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ) {
      let orderlist = dataModel.lists[indexPath.row]
      performSegue(
        withIdentifier: "ShowOrderlist",
        sender: orderlist)
    }
    
    // MARK: - Navigation
    // Prepare for the segue to the appropriate view controller
    override func prepare(
      for segue: UIStoryboardSegue,
      sender: Any?
    ) {
      if segue.identifier == "ShowOrderlist" {
        let controller = segue.destination as! OrderlistViewController
        controller.orderlist = sender as? Orderlist
      }
      else if segue.identifier == "AddOrderlist" {
        let controller = segue.destination as! ListDetailViewController
        controller.delegate = self
      }
    }
    
    // MARK: - List Detail View Controller Delegates
    // Handle the cancel action from ListDetailViewController
    func listDetailViewControllerDidCancel(
      _ controller: ListDetailViewController
    ) {
      navigationController?.popViewController(animated: true)
    }

    // Handle adding a new order list from ListDetailViewController
    func listDetailViewController(
      _ controller: ListDetailViewController,
      didFinishAdding orderlist: Orderlist
    ) {
      let newRowIndex = dataModel.lists.count
      dataModel.lists.append(orderlist)

      let indexPath = IndexPath(row: newRowIndex, section: 0)
      let indexPaths = [indexPath]
      tableView.insertRows(at: indexPaths, with: .automatic)

      navigationController?.popViewController(animated: true)
    }

    // Handle editing an existing order list from ListDetailViewController
    func listDetailViewController(
      _ controller: ListDetailViewController,
      didFinishEditing orderlist: Orderlist
    ) {
      if let index = dataModel.lists.firstIndex(of: orderlist) {
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) {
          cell.textLabel!.text = orderlist.name
        }
      }
      navigationController?.popViewController(animated: true)
    }

    // Handle the deletion of a row
    override func tableView(
      _ tableView: UITableView,
      commit editingStyle: UITableViewCell.EditingStyle,
      forRowAt indexPath: IndexPath
    ) {
      dataModel.lists.remove(at: indexPath.row)

      let indexPaths = [indexPath]
      tableView.deleteRows(at: indexPaths, with: .automatic)
    }

    // Handle the accessory button tap to edit the order list
    override func tableView(
      _ tableView: UITableView,
      accessoryButtonTappedForRowWith indexPath: IndexPath
    ) {
      let controller = storyboard!.instantiateViewController(
        withIdentifier: "ListDetailViewController") as! ListDetailViewController
      controller.delegate = self

      let orderlist = dataModel.lists[indexPath.row]
      controller.orderlistToEdit = orderlist

      navigationController?.pushViewController(
        controller,
        animated: true)
    }
    
    // MARK: - Data Saving
    

}
