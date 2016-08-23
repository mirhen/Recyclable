//
//
//import UIKit
//
//
//class TagsColorsTableViewController: UITableViewController {
//
//  // MARK: - Properties
//  var tags: [String]?
//  var image: UIImage?
//  // MARK: - UITableViewDataSource
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
//   
//  }
//  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    
//    return 1
//  }
//  
//  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//
//    let cellData = tags![indexPath.row]
//    
//    
//    let cell = tableView.dequeueReusableCellWithIdentifier("TagOrColorCell", forIndexPath: indexPath) as! ResultsTableViewCell
//
//    for  tag in tags! {
//     /* if tag == "paper" || tag == "container" || tag == "bottle" {
//        cell.label.text = "This is recyclable!"
//        cell.backgroundColor = UIColor.greenColor()
//        cell.label.backgroundColor = UIColor.greenColor()
//        
//      } else */ if tag == "human" /*|| tag == "face"*/ {
//        cell.label.text = "you are a human :))))"
//        cell.backgroundColor = UIColor.blueColor()
//        cell.label.backgroundColor = UIColor.blueColor()
//        print("hey human")
//      }/*else{
//        
//        cell.label.text = "This is not recyclable :(("
//        cell.backgroundColor = UIColor.greenColor()
//        cell.label.backgroundColor = UIColor.greenColor()
//      }
//      print(tag)
//
//      */
//    }
//    cell.imageVIew.image = image
//    return cell
//  }
//  
//  // MARK: - UITableViewDelegate
//  override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//  }
//}

