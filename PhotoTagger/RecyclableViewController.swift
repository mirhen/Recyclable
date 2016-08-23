//
//  RecyclableViewController.swift
//  Recyclable.
//
//  Created by Miriam Hendler on 7/3/16.
//  Copyright © 2016  LLC. All rights reserved.
//

import UIKit

class RecyclableViewController: UIViewController {
    @IBOutlet weak var label: UILabel?
    var tags: [String]?
    var image: UIImage!
  var recyclable = ["can", "tin", "box", "card", "carton", "milk", "glass", "lid", "paper", "plastic", "bottle", "container", "steel", "aluminum", "jar", "tub", "tray", "pot", "newspaper", "magazine", "envelope", "mail", "shampoo", "water", "bleach", "yogurt", "cup", "drink", "beverage", "liquid", "tea", "coffee", "bag", "basket", "hamper", "box", " paper", "vessel", "pill bottle", "water bottle", "drink", "tissue", "book", "napkin", "towel", "wrap", "paper bag", "metal container", "beer", "jug"]
  var person =  ["face", "eyes", "hair", "model", "attractive", "human", "adult", "male", "female", "person"]
    @IBOutlet weak var imageView: UIImageView!
    var newTags: [String] = [""]
    var humanTags: [String] = [""]
    var vowels = ["a", "e", "i","o","u"]
    override func viewDidLoad() {
      super.viewDidLoad()
      self.view.bringSubviewToFront(label!)
      
            for tag in 0...11 {
        newTags.append(tags![tag])
      
      }
      for tag in 0...2
      {
        humanTags.append(person[tag])
      }
              if anyCommonRecyclableElements(newTags, rhs: recyclable) == true {
                label?.text = "This is recyclable!"
                
              }else if anyCommonRecyclableElements(humanTags, rhs: newTags) == true {
                label?.text = "You're a human...not recyclable"
              }

              else if anyCommonRecyclableElements(newTags, rhs: recyclable) == false {
//                for character in vowels
//                {
                
                
                  if anyCommonRecyclableElements([String(tags!.first!.characters.first!)], rhs: vowels) != true
//                if String(tags!.first!.characters.first!) != character
                {
                label?.text = "This is a \(tags!.first!)...not recyclable"
                }
                  else
                {
                  label?.text = "This is an \(tags!.first!)...not recyclable"
    
                  }
//                }
              
      }
    print("the first tag: \(tags!.first!)")
      print("the human tags: \(humanTags)")
      print("the new tags: \(newTags)")
    print("all the tags: \(tags)")
      
      
     
      imageView.image = image
//      print(newTags)
      
      // Do any additional setup after loading the view.
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }

  func anyCommonRecyclableElements <T, U where T: SequenceType, U: SequenceType, T.Generator.Element: Equatable, T.Generator.Element == U.Generator.Element> (lhs: T, rhs: U) -> Bool {
    for lhsItem in lhs {
      for rhsItem in rhs {
        if lhsItem as! String != ""
        {

        if lhsItem == rhsItem {
          print(lhsItem)
                     return true
          }
        }
      }
    }
    return false
  }
}
