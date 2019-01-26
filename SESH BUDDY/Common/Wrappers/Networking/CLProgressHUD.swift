

import UIKit
import SVProgressHUD

class CLProgressHUD: SVProgressHUD {
  
  class func present(animated: Bool, status: String = "") {
    self.setDefaultStyle(SVProgressHUDStyle.custom)
    self.setDefaultMaskType(.gradient)
    self.setBackgroundColor(UIColor.white)
    self.setRingThickness(3)
    self.setForegroundColor(.orange)
    if status.isEmpty {
      self.show()
    } else {
      self.show(withStatus: status)
    }
  }
  
  class func dismiss(animated: Bool) {
    SVProgressHUD.dismiss()
  }
  
}
