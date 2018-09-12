//
//  UIAlertController+Extension.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import UIKit
import RMessage

extension UIAlertController {
  
  func present(viewController: UIViewController) {
    viewController.present(self, animated: true, completion: nil)
  }
  
  func present() {
    if let viewController = UIApplication.shared.keyWindow?.rootViewController {
      self.present(viewController: viewController)
    }
  }
  
  @discardableResult
  func action(title: String?, style: UIAlertActionStyle, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
    let action: UIAlertAction = UIAlertAction(title: title, style: style, handler: handler)
    self.addAction(action)
    return self
  }
  
  @discardableResult
  class func alert(title: String?, message: String?, style: UIAlertControllerStyle) -> UIAlertController {
    let alertController: UIAlertController  = UIAlertController(title: title, message: message, preferredStyle: style)
    alertController.view.tintColor = .orange
    return alertController
  }
  
  @discardableResult
  class func presentAlert(title: String?, message: String?, style: UIAlertControllerStyle) -> UIAlertController {
    let alertController = UIAlertController.alert(title: title, message: message, style: style)
    alertController.view.tintColor = .orange
    alertController.present()
    return alertController
  }
  
  class func presentBanner(_ inView: UIViewController, message: String) {
    RMessage.showNotification(in: inView, title: "", subtitle: message, type: .custom, customTypeName: "banner") {
      
    }
  }
  
  class func presentGlobalBanner(_ message: String) {
    
//    guard let window = appDelegate.window, let rootController = window.rootViewController as? EntryViewController else {
//      return
//    }
   
    RMessage.showNotification(withTitle: AppStrings.getBusinessName(), subtitle: message, type: .custom, customTypeName: "message", callback: {
      
      
      
    })
    
    

    }
  
  
  
  
  @discardableResult
  class func MultipleButtonAlert(_ message: String, title: String, button: [String], completeFunction: [(() -> Void)]) -> UIAlertController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    // Create the actions
    
    for  i  in  0..<button.count {
      let Action = UIAlertAction(title: button[i], style: UIAlertActionStyle.default) { UIAlertAction in
        for  j in 0..<button.count {
          if button[j] == UIAlertAction.title {
            completeFunction[j]()
          }
        }
      }
      alertController.addAction(Action)
    }
    alertController.view.tintColor = .orange
    return alertController
  }
  
  class func showCallPopup(_ forNumber: String) {
    UIAlertController.MultipleButtonAlert(AppStrings.Do_you_want_to_make_call_to.localized + " " + forNumber + "?", title: "", button: [AppStrings.Cancel.localized,AppStrings.Ok.localized], completeFunction: [{() -> Void in },{ () -> Void in
      
      if let url = URL(string: "tel://\(forNumber)") , UIApplication.shared.canOpenURL(url) {
        if #available(iOS 10, *) {
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
          UIApplication.shared.openURL(url as URL)
        }
      }
      }]).present()
  }
}
