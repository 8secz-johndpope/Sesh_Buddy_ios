//
//  BuddiesViewController.swift
//  SESH BUDDY
//
//  Created by test on 07/10/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class BuddiesViewController: UIViewController, BuddiesViewProtocol {
    var presenter: BuddiesPresenterProtocol?

    @IBOutlet weak var buddiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

