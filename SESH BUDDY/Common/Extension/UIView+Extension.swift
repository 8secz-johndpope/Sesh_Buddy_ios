//
//  UIView+Extension.swift
//  Jugnoo Driver
//
//  Created by Divyansh Bhardwaj on 27/04/18.
//  Created by Kanwalz on 28/04/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  
  var isRTL: Bool {
    return Locale.characterDirection(forLanguage:  L102Language.currentAppleLanguage()) == .rightToLeft
  }
  
  func flipDueToRTL(_ assignedFrame: CGRect = CGRect.zero) {
    
    var newFrame = self.frame
    if assignedFrame != CGRect.zero {
      newFrame = assignedFrame
    }
    
    if self.isRTL {
      self.frame = CGRect.init(x: screenWidth - newFrame.origin.x - newFrame.width, y: newFrame.origin.y, width: newFrame.width, height: newFrame.height)
    } else {
      self.frame = newFrame
    }
  }
  
    func roundView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = (self.frame.width/2)
    }
    var snapshot: UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
            defer { UIGraphicsEndImageContext() }
            guard let currentContext = UIGraphicsGetCurrentContext() else {
                return nil
            }
            self.layer.render(in: currentContext)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
    }
  
  func createShadow(_ shadowOpacity: Float = 1.0, shadowRadius: CGFloat = 1.5, shadowColor: CGColor = UIColor.gray.cgColor) {
    let mainScreenShadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius)
    self.layer.masksToBounds = false
    self.layer.shadowColor = shadowColor
    self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    self.layer.shadowOpacity = shadowOpacity
    //1.0f;
    self.layer.shadowRadius = shadowRadius
    self.layer.shadowPath = mainScreenShadowPath.cgPath
  }

  func addDashedBorder(_ withColor: UIColor) {
    let color = withColor
    
    let shapeLayer:CAShapeLayer = CAShapeLayer()
    let frameSize = self.frame.size
    let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
    
    shapeLayer.bounds = shapeRect
    shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = color.cgColor
    shapeLayer.lineWidth = 1
    shapeLayer.lineJoin = kCALineJoinRound
    shapeLayer.lineDashPattern = [4,4]
    shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 2).cgPath
    
    self.layer.addSublayer(shapeLayer)
  }
  
  
  func addShadow(_ cornerRadius: CGFloat, color: UIColor = UIColor.darkGray, shadowOffset: CGSize = CGSize(width: 0, height: 2), shadowOpacity: CGFloat = 0.4, shadowRadius: CGFloat = 2 ) {
    // corner radius
    
    self.layer.cornerRadius = cornerRadius
    
    // shadow
    self.layer.shadowColor = color.cgColor
    self.layer.shadowOffset = shadowOffset
    self.layer.shadowOpacity = Float(shadowOpacity)
    self.layer.shadowRadius = shadowRadius
  }
  
  
  class func getwidth(_ fromString: String, height: CGFloat, font: UIFont) -> CGFloat {
    
    var width = CGFloat(0)
    
    let label = UILabel()
    label.numberOfLines = 0
    label.font = font
    label.text = fromString
    let size = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: height))
    width += (size.width)
    
    return width
    
  }
  
  class func getHeight(_ fromString: String, width: CGFloat, font: UIFont) -> CGFloat {
    
    var height = CGFloat(0)
    
    let label = UILabel()
    label.numberOfLines = 0
    label.font = font
    label.text = fromString
    let size = label.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
    height += (size.height)
    
    return height
    
  }

  

}

class IgnoreTouchView : UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView == self {
            return nil
        }
        return hitView
    }
}
