//
//  UICollectionView+Extension.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 25/04/18.
//  Created by Divyansh Bhardwaj on 26/04/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerCellFrom(_ string: String) {
        self.register(UINib.init(nibName: string, bundle: Bundle.main), forCellWithReuseIdentifier: string)
    }
    
}
