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
    
    var statusView: StatusPopUpView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBottomViewForIphoneX()
    }
    func addStatusSheetView(from: UIViewController) {
        
        if statusView == nil {
            if let statusSheet = Bundle.main.loadNibNamed("StatusPopUpView", owner: self, options: nil)?[0] as? StatusPopUpView {
                statusSheet.source = from
                var frame = statusSheet.frame
                frame = CGRect(x: 0, y: -200, width: Int(screenWidth), height: Int(frame.size.height))
                statusView = statusSheet
                statusView?.frame = frame
                self.view.addSubview(statusView!)
                self.addStatusSheet()
            }
        } else {
            self.removeStatusSheet()
        }
       
    }
    func removeStatusSheet(){
        if statusView != nil {
            UIView.animate(withDuration: 0.5, animations: {
                var frame = self.statusView?.frame
                frame = CGRect(x: 0, y: -200, width: Int(screenWidth), height: Int((frame?.size.height)!))
                self.statusView?.frame = frame!
            }) { (complete) in
                self.statusView?.removeFromSuperview()
                self.statusView = nil
            }
        }
    }
    func addStatusSheet(){
        if statusView != nil {
            UIView.animate(withDuration: 0.5, animations: {
                var frame = self.statusView?.frame
                frame = CGRect(x: 0, y: navigationBarHeight, width: Int(screenWidth), height: Int((frame?.size.height)!))
                self.statusView?.frame = frame!
            }) { (complete) in
                
            }
        }
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

extension EntryViewController: StatusPopUpProtocol {
    func changeStatus(to: StatusTypes) {
        
        
    }
}
