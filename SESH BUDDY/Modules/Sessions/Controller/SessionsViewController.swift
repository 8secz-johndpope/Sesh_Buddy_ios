//
//  SessionsViewController.swift
//  SESH BUDDY
//
//  Created by test on 07/10/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class SessionsViewController: UIViewController, SessionsViewProtocol {
    
    var presenter: SessionsPresenterProtocol?

    @IBOutlet weak var sessionsCollectionView: UICollectionView!
    
    let historyCollectionViewCell = "HistoryCollectionViewCell"
    
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
        sessionsCollectionView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        sessionsCollectionView.register(UINib(nibName: historyCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: historyCollectionViewCell)
        sessionsCollectionView.delegate = self
        sessionsCollectionView.dataSource = self
        
    }
}
extension SessionsViewController: UICollectionViewDelegate {
    
}
extension SessionsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: historyCollectionViewCell, for: indexPath) as? HistoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}
extension SessionsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 20.0
        let width = collectionView.frame.size.width
        return CGSize(width: (width - margin)/3, height: (screenWidth - margin)/3 + 15)
    }
}
