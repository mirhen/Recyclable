//
//import UIKit
//
//class TagsColorsViewController: UIViewController {
//
//  // MARK: - Properties
//var tags: [String]?
//var image: UIImage?
//var tableViewController: TagsColorsTableViewController!
//
//  
//
//  // MARK: - IBOutlets
//  @IBOutlet var segmentedControl: UISegmentedControl!
//  
//  // MARK: - View Life Cycle
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    setupTableData()
//    
//  }
//  
//  // MARK: - Navigation
//  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    if segue.identifier == "DataTable" {
//      guard let controller = segue.destinationViewController as? TagsColorsTableViewController else {
//
//        fatalError("Storyboard mis-configuration. Controller is not of expected type TagsColorTableViewController")
//      }
//      
//      tableViewController = controller
//
//    }
//  }
//  
//  // MARK: - IBActions
//  @IBAction func tagsColorsSegmentedControlChanged(sender: UISegmentedControl) {
//    setupTableData()
//  }
//  
//  // MARK: - Public
//  func setupTableData() {
//
//    
//      if let tags = tags {
//        tableViewController.tags = tags
//        tableViewController.image = image
//      }
//}
//}


