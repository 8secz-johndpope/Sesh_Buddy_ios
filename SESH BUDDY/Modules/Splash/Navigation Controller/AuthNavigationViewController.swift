//
//  AuthNavigationViewController.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 26/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import UIKit

class AuthNavigationViewController: UINavigationController {
  

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI() {
      if #available(iOS 11.0, *) {
        self.navigationBar.prefersLargeTitles = false
      } 
        self.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationBar.shadowImage = nil
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = UIColor.themeNavBarButtonColor
        self.view.backgroundColor = .clear
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: Fonts.mavenProRegular.getFont(20), NSAttributedStringKey.foregroundColor : UIColor.themeNavBarTitleColor]
       self.navigationBar.layer.masksToBounds = false

    }

}
