//
//  UIViewController+Extension.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 28/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

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
      navController.navigationBar.isTranslucent = true
    default:
      navController.navigationBar.setBackgroundImage(nil, for: .default)
      navController.navigationBar.shadowImage = nil
      navController.navigationBar.backgroundColor = .clear
      navController.navigationBar.isTranslucent = false
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
}








