
import UIKit
import Alamofire
import MessageUI

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
  // MARK: - IBOutlets
  @IBOutlet var takePictureButton: UIButton!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var progressView: UIProgressView!
  @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
  @IBOutlet var label: UITextView!
  

  // MARK: - Properties
  private var tags: [String]?

  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if !UIImagePickerController.isSourceTypeAvailable(.Camera) {
      takePictureButton.setTitle("Select Photo", forState: .Normal)
    }
    
  }

  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)

    imageView.image = nil
    
    
  }
  
  

  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    if segue.identifier == "ShowRecyclable" {
      guard let controller = segue.destinationViewController as? RecyclableViewController else {
        
        
        fatalError("Storyboard mis-configuration. Controller is not of expected type TagsColorsViewController")
      }
      if let imageView = imageView.image {
        controller.image = imageView
      }
      controller.tags = tags
      
    }
   }
  
  // MARK: - IBActions
  @IBAction func takePicture(sender: UIButton) {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = false
    if UIImagePickerController.isSourceTypeAvailable(.Camera) {
      picker.sourceType = UIImagePickerControllerSourceType.Camera
    } else {
      picker.sourceType = .PhotoLibrary
      picker.modalPresentationStyle = .FullScreen
    }

    presentViewController(picker, animated: true, completion: nil)
  }
}

// MARK: - UIImagePickerControllerDelegate
extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
      print("Info did not have the required UIImage for the Original Image")
      dismissViewControllerAnimated(true, completion: nil)
      return
    }
    
    imageView.image = image
    takePictureButton.hidden = true
    tableView.hidden = true
    label.hidden = true
    
    progressView.progress = 0.0
    self.view.bringSubviewToFront(progressView)
    self.view.bringSubviewToFront(activityIndicatorView)
    progressView.hidden = false
    activityIndicatorView.startAnimating()
    
    uploadImage(
      image,
      progress: { [unowned self] percent in
        self.progressView.setProgress(percent, animated: true)
      },
 
    completion: { [unowned self] tags in

      self.takePictureButton.hidden = false
        self.label.hidden = false
        self.tableView.hidden = false
        self.progressView.hidden = true
        self.activityIndicatorView.stopAnimating()
        
        self.tags = tags

 
//        self.performSegueWithIdentifier("ShowResults", sender: self)
      self.performSegueWithIdentifier("ShowRecyclable", sender: self)

    })
    dismissViewControllerAnimated(true, completion: nil)
  }
}




// MARK: - Networking Functions
extension ViewController {

 func uploadImage(image: UIImage, progress: (percent: Float) -> Void, completion: (tags: [String]) -> Void) {
  guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {
      print("Could not get JPEG representation of UIImage")
      return
    }
    
    Alamofire.upload(
      ImaggaRouter.Content,
      multipartFormData: { multipartFormData in
        multipartFormData.appendBodyPart(data: imageData, name: "imagefile", fileName: "image.jpg", mimeType: "image/jpeg")
      },
      encodingCompletion: { encodingResult in
        switch encodingResult {
        case .Success(let upload, _, _):
          upload.progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
            dispatch_async(dispatch_get_main_queue()) {
              let percent = (Float(totalBytesWritten) / Float(totalBytesExpectedToWrite))
              progress(percent: percent)
            }
          }
          upload.validate()
          upload.responseJSON { response in
            guard response.result.isSuccess else {
              print("Error while uploading file: \(response.result.error)")
              completion(tags: [String]())

              return
            }

            guard let responseJSON = response.result.value as? [String: AnyObject],
              uploadedFiles = responseJSON["uploaded"] as? [AnyObject],
              firstFile = uploadedFiles.first as? [String: AnyObject],
              firstFileID = firstFile["id"] as? String else {
                print("Invalid information received from service")
                completion(tags: [String]())

                return
            }

            print("Content uploaded with ID: \(firstFileID)")
            
            self.downloadTags(firstFileID) { tags in
                completion(tags: tags)
            }
          }
        case .Failure(let encodingError):
          print(encodingError)
        }
      }
    )
  }
  
  func downloadTags(contentID: String, completion: ([String]) -> Void) {

    Alamofire.request(ImaggaRouter.Tags(contentID))
      .responseJSON { response in
        guard response.result.isSuccess else {
          print("Error while fetching tags: \(response.result.error)")
          completion([String]())
          return
        }
        
        guard let responseJSON = response.result.value as? [String: AnyObject],
          results = responseJSON["results"] as? [AnyObject],
          firstObject = results.first,
          tagsAndConfidences = firstObject["tags"] as? [[String: AnyObject]] else {
            print("Invalid tag information received from the service")
            completion([String]())
            return
        }

        let tags = tagsAndConfidences.flatMap({ dict in
          return dict["tag"] as? String
        })

        completion(tags)
    }
  }

  
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, MFMessageComposeViewControllerDelegate {
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCellWithIdentifier("whatIdentifier", forIndexPath: indexPath) as! MainTableViewCell
      cell.label.text = "Share with friends!"
      cell.backgroundColor = colorWithHexString("#36935A")
      cell.label.textColor = UIColor.whiteColor()
      return cell
    } else {
      let cell = tableView.dequeueReusableCellWithIdentifier("saveIdentifier", forIndexPath: indexPath) as! MainTableViewCell
      
      cell.backgroundColor = colorWithHexString("#36935A")
      cell.label.textColor = UIColor.whiteColor()
      cell.label.text = "Saving our planet"

      return cell
    }
  }
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return tableView.frame.height/2
  }
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       if indexPath.row == 0 {
      let messageVC = MFMessageComposeViewController()
      
      messageVC.body = "I just recycled and so can you, just download the recyclable app!";
   //   messageVC.recipients = [" "]
      messageVC.messageComposeDelegate = self;
      
      self.presentViewController(messageVC, animated: false, completion: nil)

    }
    
  }
  
  func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
    switch (result) {
    case MessageComposeResultCancelled:
      print("Message was cancelled")
      self.dismissViewControllerAnimated(true, completion: nil)
    case MessageComposeResultFailed:
      print("Message failed")
      self.dismissViewControllerAnimated(true, completion: nil)
    case MessageComposeResultSent:
      print("Message was sent")
      self.dismissViewControllerAnimated(true, completion: nil)
    default:
      break;
    }
  }
  
  func colorWithHexString (hex:String) -> UIColor {
    var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
    
    if (cString.hasPrefix("#")) {
      cString = (cString as NSString).substringFromIndex(1)
    }
    
    if (cString.characters.count != 6) {
      return UIColor.grayColor()
    }
    
    let rString = (cString as NSString).substringToIndex(2)
    let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
    let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    NSScanner(string: rString).scanHexInt(&r)
    NSScanner(string: gString).scanHexInt(&g)
    NSScanner(string: bString).scanHexInt(&b)
    
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
  }

  
}


