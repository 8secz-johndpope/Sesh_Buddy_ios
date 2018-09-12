//
//  UIButton+Extension.swift
//  Jugnoo Driver
//
//  Created by Divyansh Bhardwaj on 26/04/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
     func roundButton() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = (self.frame.width/2)
    }
}

var actionBlockKey: UInt8 = 0

// a type for our action block closure
typealias BlockButtonActionBlock = (_ sender: UIButton) -> Void

class ActionBlockWrapper: NSObject {
  var block: BlockButtonActionBlock
  init(block: @escaping BlockButtonActionBlock) {
    self.block = block
  }
}

extension UIButton {
  func block_setAction(block: @escaping BlockButtonActionBlock) {
    objc_setAssociatedObject(self, &actionBlockKey, ActionBlockWrapper(block: block), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    self.addTarget(self, action: #selector(UIButton.block_handleAction), for: .touchUpInside)
  }
  
  @objc func block_handleAction(sender: UIButton, for control: UIControlEvents) {
    
    guard let wrapper = objc_getAssociatedObject(self, &actionBlockKey) as? ActionBlockWrapper else {
      fatalError("Action Block Wrapper is nil")
    }
    wrapper.block(sender)
  }
}


class MFBadgeButton : UIButton {
  
  var badgeValue : String! = "" {
    didSet {
      self.layoutSubviews()
    }
  }
  
  override init(frame :CGRect)  {
    // Initialize the UIView
    super.init(frame : frame)
    
    self.awakeFromNib()
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.awakeFromNib()
  }
  
  
  override func awakeFromNib()
  {
    self.drawBadgeLayer()
  }
  
  var badgeLayer :CAShapeLayer!
  func drawBadgeLayer() {
    
    if self.badgeLayer != nil {
      self.badgeLayer.removeFromSuperlayer()
    }
    
    // Omit layer if text is nil
    if self.badgeValue == nil || self.badgeValue.count == 0 {
      return
    }
    
    //! Initial label text layer
    let labelText = CATextLayer()
    labelText.contentsScale = UIScreen.main.scale
    labelText.string = self.badgeValue.uppercased()
    labelText.fontSize = 9.0
    labelText.font = UIFont.systemFont(ofSize: 9)
    labelText.alignmentMode = kCAAlignmentCenter
    labelText.foregroundColor = UIColor.white.cgColor
    let labelString = self.badgeValue.uppercased() as String
    let labelFont = UIFont.systemFont(ofSize: 9) as UIFont
    let attributes = [NSAttributedStringKey.font : labelFont]
    let w = self.frame.size.width
    let h = CGFloat(10.0)  // fixed height
    let labelWidth = min(w * 0.8, 10.0)    // Starting point
    let rect = labelString.boundingRect(with: CGSize(width: labelWidth, height: h), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
    let textWidth = round(rect.width * UIScreen.main.scale)
    labelText.frame = CGRect(x: 0, y: 0, width: textWidth, height: h)
    
    //! Initialize outline, set frame and color
    let shapeLayer = CAShapeLayer()
    shapeLayer.contentsScale = UIScreen.main.scale
    let frame : CGRect = labelText.frame
    let cornerRadius = CGFloat(5.0)
    let borderInset = CGFloat(-1.0)
    let aPath = UIBezierPath(roundedRect: frame.insetBy(dx: borderInset, dy: borderInset), cornerRadius: cornerRadius)
    
    shapeLayer.path = aPath.cgPath
    shapeLayer.fillColor = UIColor.red.cgColor
    shapeLayer.strokeColor = UIColor.red.cgColor
    shapeLayer.lineWidth = 0.5
    
    shapeLayer.insertSublayer(labelText, at: 0)
    
    shapeLayer.frame = shapeLayer.frame.offsetBy(dx: w*0.6, dy: 5.0)
    
    self.layer.insertSublayer(shapeLayer, at: 999)
    self.layer.masksToBounds = false
    self.badgeLayer = shapeLayer
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.drawBadgeLayer()
    self.setNeedsDisplay()
  }
  
}

