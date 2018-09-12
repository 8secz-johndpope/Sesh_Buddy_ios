//
//  UIImage+Extension.swift
//  Jugnoo Autos
//
//  Created by cl-macmini-67 on 5/5/17.
//  Copyright © 2017 Socomo Technologies. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    convenience init(view: UIView) {
        if let cgImage = view.snapshot?.cgImage {
            self.init(cgImage: cgImage)
        } else {
            self.init()
        }
        //            UIGraphicsBeginImageContext(view.frame.size)
        //            view.layer.render(in:UIGraphicsGetCurrentContext()!)
        //            let image = UIGraphicsGetImageFromCurrentImageContext()
        //            UIGraphicsEndImageContext()
        //            self.init(cgImage: image!.cgImage!)
    }
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
//    @objc class func getHorizontalGradientImage(_ fromColors: [UIColor], size : CGSize) -> UIImage? {
//
//        var gradientColors = [CGColor]()
//        for value in fromColors {
//            gradientColors.append(value.cgColor)
//        }
//        if gradientColors.count == 0 {
//            gradientColors.append(UIColor.clear.cgColor)
//        }
//
//        let gradientLayer = CAGradientLayer()
//        var actualSize = size
//        if size.width == 0 || size.height == 0 {
//            actualSize = CGSize(width: UIScreen.main.bounds.width, height: 60)
//        }
//        gradientLayer.frame = CGRect(x: 0, y: 0, width: actualSize.width, height: actualSize.height)
//        gradientLayer.colors = gradientColors
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
//        UIGraphicsBeginImageContext(actualSize)
//        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        return image
//
//    }
    
    func normalizedImage() -> UIImage {
        if imageOrientation == .up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let normalizedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage ?? UIImage()
    }
    
//    @objc  class func getVerticalGradientImage(_ fromColors: [UIColor], size : CGSize) -> UIImage? {
//
//        var gradientColors = [CGColor]()
//        for value in fromColors {
//            gradientColors.append(value.cgColor)
//        }
//        if gradientColors.count == 0 {
//            gradientColors.append(UIColor.clear.cgColor)
//        }
//
//        let gradientLayer = CAGradientLayer()
//        var actualSize = size
//        if size.width == 0 || size.height == 0 {
//            actualSize = CGSize(width: UIScreen.main.bounds.width, height: 60)
//        }
//        gradientLayer.frame = CGRect(x: 0, y: 0, width: actualSize.width, height: actualSize.height)
//        gradientLayer.colors = gradientColors
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
//        UIGraphicsBeginImageContext(actualSize)
//        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        return image
//
//    }
    
    @objc func convertImageToBW() -> UIImage? {
        let width = self.size.width
        let height = self.size.height
        let rect = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        
        guard let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }
        guard let cgImage = cgImage else { return nil }
        
        context.draw(cgImage, in: rect)
        guard let imageRef = context.makeImage() else { return nil }
        let newImage = UIImage(cgImage: imageRef.copy()!)
        
        return newImage
    }
    
    
    @objc func coloredImage(color: UIColor) -> UIImage? {
        let image = self
        let backgroundSize = image.size
        UIGraphicsBeginImageContextWithOptions(backgroundSize, false, UIScreen.main.scale)
        
        let ctx = UIGraphicsGetCurrentContext()!
        
        var backgroundRect=CGRect()
        backgroundRect.size = backgroundSize
        backgroundRect.origin.x = 0
        backgroundRect.origin.y = 0
        
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        ctx.setFillColor(red: r, green: g, blue: b, alpha: a)
        ctx.fill(backgroundRect)
        
        var imageRect = CGRect()
        imageRect.size = image.size
        imageRect.origin.x = (backgroundSize.width - image.size.width) / 2
        imageRect.origin.y = (backgroundSize.height - image.size.height) / 2
        
        // Unflip the image
        ctx.translateBy(x: 0, y: backgroundSize.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        
        ctx.setBlendMode(.destinationIn)
        ctx.draw(image.cgImage!, in: imageRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    @objc func imageResize (sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
    
    func scaledWithMaxWidthOrHeightValue(value: CGFloat) -> UIImage? {
        
        let width = self.size.width
        let height = self.size.height
        
        let ratio = width/height
        
        var newWidth = value
        var newHeight = value
        
        if ratio > 1.0 {
            newWidth = width * (newHeight/height)
        } else {
            newHeight = height * (newWidth/width)
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: newHeight), false, 0)
        
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    @objc func scaled(withScale scale: CGFloat) -> UIImage? {
        
        let size = CGSize(width: self.size.width * scale, height: self.size.height * scale)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func addShadow(blurSize: CGFloat = 1.0) -> UIImage {
        
        let shadowColor = UIColor(white:0.0, alpha:0.5).cgColor
        
        let context = CGContext(data: nil,
                                width: Int(self.size.width + blurSize),
                                height: Int(self.size.height + blurSize),
                                bitsPerComponent: self.cgImage!.bitsPerComponent,
                                bytesPerRow: 0,
                                space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        context.setShadow(offset: CGSize(width: 0,height:0),
                          blur: blurSize,
                          color: shadowColor)
        context.draw(self.cgImage!,
                     in: CGRect(x: 0, y: blurSize, width: self.size.width, height: self.size.height),
                     byTiling:false)
        
        return UIImage(cgImage: context.makeImage()!)
    }
    
    func roundedImage(_ value: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: self.size))
        imageView.contentMode = .center
        imageView.image = self
        imageView.layer.cornerRadius = value
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    @objc func flipImageDueToRTL() -> UIImage {
        if #available(iOS 10.0, *) {
            return self.withHorizontallyFlippedOrientation()
        } else if #available(iOS 9.0, *) {
            return self.imageFlippedForRightToLeftLayoutDirection()
        } else {
            return UIImage.init(cgImage: self.cgImage!, scale: 1.0, orientation: .downMirrored)
        }
    }
  
    func imageWithInsets(insetDimen: CGFloat) -> UIImage {
      return imageWithInset(insets: UIEdgeInsets(top: insetDimen, left: insetDimen, bottom: insetDimen, right: insetDimen))
    }
    
    func imageWithInset(insets: UIEdgeInsets) -> UIImage {
      UIGraphicsBeginImageContextWithOptions(
        CGSize(width: self.size.width + insets.left + insets.right,
               height: self.size.height + insets.top + insets.bottom), false, self.scale)
      let origin = CGPoint(x: insets.left, y: insets.top)
      self.draw(at: origin)
      let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode)
      UIGraphicsEndImageContext()
      return imageWithInsets!
    }
    
    
}

