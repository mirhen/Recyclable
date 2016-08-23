//
//  SaveOurPlanetViewController.swift
//  Recyclable.
//
//  Created by Miriam Hendler on 7/3/16.
//  Copyright © 2016  LLC. All rights reserved.
//

import UIKit

class SaveOurPlanetViewController: UIViewController, UIWebViewDelegate {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var webView: UIWebView!
  
  func loadFirstAid(){
    
    let requestFirstAidURL = NSURL (string: "http://www.grownyc.org/recycling/whyrecycle")
    let requestFirstAid = NSURLRequest(URL: requestFirstAidURL!)
    webView.loadRequest(requestFirstAid)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    webView.delegate = self
    loadFirstAid()
  }
  
  
  
  func webViewDidStartLoad(webView: UIWebView){
    
    activityIndicator.hidden = false
    activityIndicator.startAnimating()
    
  }
  func webViewDidFinishLoad(webView: UIWebView){
    
    
    activityIndicator.hidden = true
    activityIndicator.stopAnimating()
  }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
