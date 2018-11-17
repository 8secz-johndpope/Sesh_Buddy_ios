//
//  UIViewController+Extension.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 28/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

enum RightBarButtonType{
    case plus
    case save
}
extension UIViewController {
  func changeNavBarColor(_ to: UIColor) {
    guard let navController = self.navigationController else {
      return
    }
    switch to {
    case .clear:
      navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
      navController.navigationBar.shadowImage = UIImage()
      navController.navigationBar.backgroundColor = .clear
      navController.navigationBar.isTranslucent = false
    default:
      navController.navigationBar.setBackgroundImage(nil, for: .default)
      navController.navigationBar.shadowImage = nil
      navController.navigationBar.backgroundColor = .clear
      navController.navigationBar.isTranslucent = true
      navController.navigationBar.barTintColor = to
    }
  }
    func add(_ child: UIViewController) {
        addChildViewController(child)
        view.addSubview(child.view)
        child.didMove(toParentViewController: self)
    }
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
  
  func changeStyle(_ to: UIBarStyle) {
    guard let navController = self.navigationController else {
      return
    }
    navController.navigationBar.barStyle = to
  }
    
    @objc func menuBarBurronItemAction(_ sender: UIBarButtonItem) {
        self.frostedViewController.presentMenuViewController()
    }
    @objc func statusBarButtonItemAction(_ sender: UIBarButtonItem) {
        guard let window = appDelegate.window, let rootController = window.rootViewController as? EntryViewController else {
            return
        }
        rootController.addStatusSheetView(from: self)
    }
    func removeStatusSheetView() {
        guard let window = appDelegate.window, let rootController = window.rootViewController as? EntryViewController else {
            return
        }
        rootController.removeStatusSheet()
    }
    func setNavBarTitleView(image: UIImage) {
        let imageView = UIImageView()
        imageView.image = image
        self.navigationItem.title = ""
        self.navigationItem.titleView = imageView
    }
    // MARK: Show Menu Bar Button
    func showMenuBarButton(_ status: Bool = true) {
        if status {
            let menuBarButtonIcon = UIBarButtonItem(image: Icons.menu, style: .plain, target: self, action: #selector(menuBarBurronItemAction))
            menuBarButtonIcon.tintColor = UIColor.white
            self.navigationItem.leftBarButtonItem = menuBarButtonIcon
        } else {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    func setNavBarRightButton(type: RightBarButtonType) {
        switch type {
        case .plus:
            var image = Icons.plus_green
            switch AppInfo.selectedStatusType {
            case .redUP:
                image = Icons.plus_green
            case .holding:
                image = Icons.plus_brown
            case .dry:
                image = Icons.plus_black

            }
            let btn = BarButton(type: .custom)
            btn.backgroundColor = .white
            btn.setImage(image, for: .normal)
            btn.topAnchor.constraint(equalTo: btn.topAnchor, constant: -20).isActive = true
            btn.addTarget(self, action: #selector(self.statusBarButtonItemAction(_:)), for: .touchUpInside)
            btn.widthAnchor.constraint(equalToConstant: 44).isActive = true
            btn.heightAnchor.constraint(equalToConstant: 64).isActive = true
            btn.translatesAutoresizingMaskIntoConstraints = false
            let barButton = UIBarButtonItem(customView: btn)
            self.navigationItem.rightBarButtonItem = barButton
            
        case .save:
            self.removeStatusSheetView()
            let btn = BarButton(type: .custom)
            btn.setTitle("Save", for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.titleLabel?.font = Fonts.mavenProMedium.getFont(16)
            let barButton = UIBarButtonItem(customView: btn)
            self.navigationItem.rightBarButtonItem = barButton
            
            break
        }
    }
   
    func changerightNavBarButton(type: StatusTypes) {
        let vw = self.navigationItem.rightBarButtonItem?.customView as! UIButton
        var image = Icons.plus_green
        switch type {
        case .redUP:
            image = Icons.plus_green
        case .holding:
            image = Icons.plus_brown
        case .dry:
            image = Icons.plus_black
        }
        AppInfo.selectedStatusType = type
        vw.setImage(image, for: .normal)
        let barButton = UIBarButtonItem(customView: vw)
        self.navigationItem.rightBarButtonItem = barButton
        self.statusBarButtonItemAction(barButton)
    }
    func getNavigationBarHeight() -> CGFloat {
        return  self.navigationController?.navigationBar.frame.size.height ?? 0
    }
}
class BarButton: UIButton {
    
    override var alignmentRectInsets: UIEdgeInsets {
        return UIEdgeInsetsMake(0, -12, 0, 22)
    }
    
}







