import UIKit

// Protocol for ListDetailViewController delegates
protocol ListDetailViewControllerDelegate: AnyObject {
  func listDetailViewControllerDidCancel(
    _ controller: ListDetailViewController)

  func listDetailViewController(
    _ controller: ListDetailViewController,
    didFinishAdding orderlist: Orderlist
  )

  func listDetailViewController(
    _ controller: ListDetailViewController,
    didFinishEditing orderlist: Orderlist
  )
}

// View controller for adding or editing order lists
class ListDetailViewController: UITableViewController, UITextFieldDelegate {
  @IBOutlet var textField: UITextField!
  @IBOutlet var doneBarButton: UIBarButtonItem!

  // Delegate to handle add/edit actions
  weak var delegate: ListDetailViewControllerDelegate?

  // Order list to edit, if any
  var orderlistToEdit: Orderlist?
    
    // Method called after the view has been loaded
    override func viewDidLoad() {
      super.viewDidLoad()

      // If editing an order list, set the title and text field
      if let orderlist = orderlistToEdit {
        title = "Edit Orderlist"
        textField.text = orderlist.name
        doneBarButton.isEnabled = true
      }
    }
    
    // Method called before the view appears
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      textField.becomeFirstResponder()
    }

    // MARK: - Actions
    // Action for cancel button
    @IBAction func cancel() {
      delegate?.listDetailViewControllerDidCancel(self)
    }

    // Action for done button
    @IBAction func done() {
      if let orderlist = orderlistToEdit {
        orderlist.name = textField.text!
        delegate?.listDetailViewController(
          self,
          didFinishEditing: orderlist)
      } else {
        let orderlist = Orderlist(name: textField.text!)
        delegate?.listDetailViewController(
          self,
          didFinishAdding: orderlist)
      }
    }
    
    // MARK: - Table View Delegates
    // Prevent selection of table view cells
    override func tableView(
      _ tableView: UITableView,
      willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
      return nil
    }
    
    // MARK: - Text Field Delegates
    // Handle text changes in the text field
    func textField(
      _ textField: UITextField,
      shouldChangeCharactersIn range: NSRange,
      replacementString string: String
    ) -> Bool {
      let oldText = textField.text!
      let stringRange = Range(range, in: oldText)!
      let newText = oldText.replacingCharacters(
        in: stringRange,
        with: string)
      doneBarButton.isEnabled = !newText.isEmpty
      return true
    }

    // Handle clearing of text field
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
      doneBarButton.isEnabled = false
      return true
    }




}
