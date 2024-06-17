import Foundation

// Class for managing the data model of the order lists
class DataModel {
  
  // Array of order lists
  var lists = [Orderlist]()
    
    // Initializer to load the order lists when the data model is created
    init() {
      loadOrderlists()
    }
    
    // Method to get the URL of the documents directory
    func documentsDirectory() -> URL {
      let paths = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask)
      return paths[0]
    }

    // Method to get the file path for storing the order lists
    func dataFilePath() -> URL {
      return documentsDirectory().appendingPathComponent("Orderlists.plist")
    }

    // Method to save the order lists to a file
    func saveOrderlists() {
      let encoder = PropertyListEncoder()
      do {
        // Encode the lists array
        let data = try encoder.encode(lists)
        // Write the encoded data to the file
        try data.write(
          to: dataFilePath(),
          options: Data.WritingOptions.atomic)
      } catch {
        print("Error encoding list array: \(error.localizedDescription)")
      }
    }

    // Method to load the order lists from a file
    func loadOrderlists() {
      let path = dataFilePath()
      if let data = try? Data(contentsOf: path) {
        let decoder = PropertyListDecoder()
        do {
          // Decode the data to an array of Orderlist objects
          lists = try decoder.decode(
            [Orderlist].self,
            from: data)
        } catch {
          print("Error decoding list array: \(error.localizedDescription)")
        }
      }
    }

   

}

