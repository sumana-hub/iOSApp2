import UIKit

// Protocol for AddToOrderViewController delegates
protocol AddToOrderViewControllerDelegate: AnyObject {
  func addToOrderViewControllerDidCancel(
    _ controller: AddToOrderViewController)
  func addToOrderViewController(
    _ controller: AddToOrderViewController,
    didFinishAdding item: OrderlistItem
  )
  func addToOrderViewController(
    _ controller: AddToOrderViewController,
    didFinishEditing item: OrderlistItem
  )
}

// View controller for adding or editing order list items
class AddToOrderViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    // Delegate to handle add/edit actions
    weak var delegate: AddToOrderViewControllerDelegate?
    
    // Item to edit, if any
    var itemToEdit: OrderlistItem?

    // Method called after the view has been loaded
    override func viewDidLoad() {
      super.viewDidLoad()
      
      // If editing an item, set the title and text field
      if let item = itemToEdit {
        title = "Edit Item"
        textField.text = item.text
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
      delegate?.addToOrderViewControllerDidCancel(self)
    }

    // Action for done button
    @IBAction func done() {
      if let item = itemToEdit {
        item.text = textField.text!
        delegate?.addToOrderViewController(
          self,
          didFinishEditing: item)
      } else {
        let item = OrderlistItem()
        item.text = textField.text!
        delegate?.addToOrderViewController(self, didFinishAdding: item)
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
      if newText.isEmpty {
        doneBarButton.isEnabled = false
      } else {
        doneBarButton.isEnabled = true
      }
      return true
    }
    
    // Handle clearing of text field
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
      doneBarButton.isEnabled = false
      return true
    }


}
