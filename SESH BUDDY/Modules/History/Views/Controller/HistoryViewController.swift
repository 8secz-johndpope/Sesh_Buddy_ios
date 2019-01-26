//
//  HistoryViewController.swift
//  SESH BUDDY
//
//  Created by test on 07/10/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, HistoryViewProtocol {
    
    @IBOutlet weak var historyCollectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var historyCollectionView: UICollectionView!
    var presenter: HistoryPresenterProtocol?
    let historyCollectionViewCell = "HistoryCollectionViewCell"
    var sessionDetailsPopUPVc: SessionDetailViewController!
    var transparentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeStyle(.default)
        self.showMenuBarButton(true)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        registerNib()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavBarRightButton(type: .plus)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        self.changeNavBarColor(.themeNavBarColor)
    }
    func registerNib() {
        historyCollectionView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        historyCollectionView.register(UINib(nibName: historyCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: historyCollectionViewCell)
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
       // historyCollectionViewFlowLayout.itemSize = CGSize(width: (screenWidth)/3, height: (screenWidth)/3 + 10)
        
    }
    @objc func openSeshDetailsButtonAction() {
        let sessionsData = Common.share.getSessionsArray().first
        self.openSeshUPSession(sessionType: .viewSession, session: sessionsData!)
    }
    func openSeshUPSession(sessionType: SessionStatusDetailType, session: Session) {
        sessionDetailsPopUPVc = SessionDetailViewController(nibName: "SessionDetailViewController", bundle: nil)
        sessionDetailsPopUPVc?.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        sessionDetailsPopUPVc?.view.alpha = 0.1
        sessionDetailsPopUPVc?.modalPresentationStyle = .overCurrentContext
        
        sessionDetailsPopUPVc.session = session
        sessionDetailsPopUPVc?.view.transform = CGAffineTransform(translationX: 0, y: 0)
        self.transparentView = UIView()
        transparentView?.frame = self.view.frame
        transparentView?.backgroundColor =  UIColor.black.withAlphaComponent(0.6)
        transparentView?.alpha = 0.1
        sessionDetailsPopUPVc?.sessionDetailType = sessionType
        sessionDetailsPopUPVc.setUPUI()
        self.present((sessionDetailsPopUPVc)!, animated: false
            , completion: {
                self.sessionDetailsPopUPVc.reloadView()
        })
        
        
        self.view.addSubview(transparentView!)
        self.sessionDetailsPopUPVc.reloadView()
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: UIViewAnimationOptions.transitionCrossDissolve,
                       animations: {
                        
                        self.sessionDetailsPopUPVc?.view.alpha = 1.0
                        self.transparentView?.alpha = 1.0
                        self.sessionDetailsPopUPVc?.delegate = self
                        self.sessionDetailsPopUPVc?.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        
        }
        )
    }
    func removeSessionUPC(session: Session?) {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: UIViewAnimationOptions.transitionCrossDissolve,
                       animations: {
                        self.sessionDetailsPopUPVc?.view.alpha = 0.1
                        self.transparentView?.alpha = 0.1
        },
                       completion: { finished in
                        self.dismiss(animated: false, completion: {
                            self.transparentView?.removeFromSuperview()
                            
                        })
        }
        )
        
    }
}
extension HistoryViewController: UICollectionViewDelegate {
    
}
extension HistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: historyCollectionViewCell, for: indexPath) as? HistoryCollectionViewCell else {
            return UICollectionViewCell()
        }
         cell.viewSeshTypeButton.addTarget(self, action: #selector(self.openSeshDetailsButtonAction), for: .touchUpInside)
        return cell
    }
}
extension HistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 20.0
        let width = collectionView.frame.size.width
        return CGSize(width: (width - margin)/3, height: (screenWidth - margin)/3 + 15)
    }
}
extension HistoryViewController: SessionDetailsViewProtocols {
    func cancelSeshButtonClicked(session: Session) {
        self.removeSessionUPC(session: nil)
    }
    func seshUPButtonClicked(session: Session, type: SessionStatusDetailType) {
        self.removeSessionUPC(session: session)
    }
    func crossSeshUPButtonClicked() {
        self.removeSessionUPC(session: nil)
    }
}
