/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import Foundation
import Alamofire

public enum ImaggaRouter: URLRequestConvertible {
  
  static let baseURLPath = "http://api.imagga.com/v1"
  //TODO: Replace xxx with your auth token found at https://imagga.com/profile/dashboard
  static let authenticationToken = "Basic YWNjXzMxMjRjNTUyYjRhNmMzMzo0Njc4NDQwY2IzYTBhMGFhZGI3NmMyYWI0OGFkZjc3Yw=="
  
  case Content
  case Tags(String)
// case Colors(String)
  
  public var URLRequest: NSMutableURLRequest {
    let result: (path: String, method: Alamofire.Method, parameters: [String: AnyObject]) = {
      switch self {
      case .Content:
        return ("/content", .POST, [String: AnyObject]())
      case .Tags(let contentID):
        let params = [ "content" : contentID ]
        return ("/tagging", .GET, params)
 //     case .Colors(let contentID):
  //     let params = [ "content" : contentID, "extract_object_colors" : NSNumber(int: 0) ]
 //      return ("/colors", .GET, params)
      }
    }()
    
    let URL = NSURL(string: ImaggaRouter.baseURLPath)!
    let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
    URLRequest.HTTPMethod = result.method.rawValue
    URLRequest.setValue(ImaggaRouter.authenticationToken, forHTTPHeaderField: "Authorization")
    URLRequest.timeoutInterval = NSTimeInterval(10 * 1000)
    
    let encoding = Alamofire.ParameterEncoding.URL
    
    return encoding.encode(URLRequest, parameters: result.parameters).0
  }
  
}
