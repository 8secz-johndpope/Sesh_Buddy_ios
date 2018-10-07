//
//  HistoryViewController.swift
//  SESH BUDDY
//
//  Created by test on 07/10/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, HistoryViewProtocol {
    
    @IBOutlet weak var historyCollectionView: UICollectionView!
    var presenter: HistoryPresenterProtocol?
    let HistoryCollectionViewCell = "HistoryCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
    }
    func registerNib() {
        historyCollectionView.registerCellFrom(HistoryCollectionViewCell)
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
    }
}
extension HistoryViewController: UICollectionViewDelegate {
    
}
extension HistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
