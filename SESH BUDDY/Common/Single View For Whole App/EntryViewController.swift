//
//  EntryViewController.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 03/05/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import UIKit
import REFrostedViewController

class EntryViewController: REFrostedViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
      self.addBottomViewForIphoneX()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  func addBottomViewForIphoneX() {
    if UIDevice.current.type == .iPhoneX {
      if #available(iOS 11.0, *) {
        guard let window = appDelegate.window else {
          return
        }
        let bottomPadding = window.safeAreaInsets.bottom
        let view = UIView.init(frame: CGRect.init(x: 0, y: screenHeight - bottomPadding, width: screenWidth, height: bottomPadding))
        view.backgroundColor = .themeNavBarColor
        self.view.addSubview(view)
      }
    }
  }
}
