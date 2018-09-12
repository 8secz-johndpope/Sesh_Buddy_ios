//
//  ReFrosted+Extension.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/04/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import REFrostedViewController


extension REFrostedViewController {
  func setupForCurrentApp() {
    if Locale.characterDirection(forLanguage: L102Language.currentAppleLanguage()) == .rightToLeft {
      self.direction = REFrostedViewControllerDirection.right
      UIView.appearance().semanticContentAttribute = .forceRightToLeft
      UITextField.appearance().semanticContentAttribute = .forceRightToLeft
      UIButton.appearance().semanticContentAttribute = .forceRightToLeft
      UIImageView.appearance().semanticContentAttribute = .forceRightToLeft
      UITableView.appearance().semanticContentAttribute = .forceRightToLeft
      UITableViewCell.appearance().semanticContentAttribute = .forceRightToLeft
      UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
      UICollectionViewCell.appearance().semanticContentAttribute = .forceRightToLeft
      UILabel.appearance().semanticContentAttribute = .forceRightToLeft
      UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
        UISwitch.appearance().semanticContentAttribute = .forceRightToLeft

    } else {
      self.direction = REFrostedViewControllerDirection.left
      UIView.appearance().semanticContentAttribute = .forceLeftToRight
      UITextField.appearance().semanticContentAttribute = .forceLeftToRight
      UIButton.appearance().semanticContentAttribute = .forceLeftToRight
      UIImageView.appearance().semanticContentAttribute = .forceLeftToRight
      UITableView.appearance().semanticContentAttribute = .forceLeftToRight
      UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
      UITableViewCell.appearance().semanticContentAttribute = .forceLeftToRight
      UICollectionViewCell.appearance().semanticContentAttribute = .forceLeftToRight
      UILabel.appearance().semanticContentAttribute = .forceLeftToRight
      UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
        UISwitch.appearance().semanticContentAttribute = .forceLeftToRight

    }
    self.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyle.light
    self.liveBlur = true
    self.limitMenuViewSize = true
    self.backgroundFadeAmount = 0.6
  }
  
  func addSideMenu() {
    let storyBoard = Storyboards.homeFlow.getStoryBoard()
    let sideMenuViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenuViewController")
    self.menuViewController = sideMenuViewController
  }
}
