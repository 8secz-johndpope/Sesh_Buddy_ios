//
//  SeshReviewViewController.swift
//  SESH BUDDY
//
//  Created by test on 17/11/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class SeshReviewViewController: UIViewController {

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var backgroundImsgeView: UIImageView!
    @IBOutlet weak var sessionButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var popUPView: UIView!
    @IBOutlet weak var bottomLabel: UILabel!
    
    let buddyInfoTableViewCell = "BuddyInfoTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
    }
    func registerNib(){
        reviewTableView.registerCellFrom(buddyInfoTableViewCell)
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
    }
    @IBAction func sessionButtonAction(_ sender: Any) {
    }
    
}
extension SeshReviewViewController: UITableViewDelegate {
    
}
extension SeshReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: buddyInfoTableViewCell) as? BuddyInfoTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    
}
