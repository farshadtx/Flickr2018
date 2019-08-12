//
//  MonthHeaderCell.swift
//  Flicker Best18
//
//  Created by Farshad Sheykhi on 8/11/19.
//  Copyright © 2019 Farshad. All rights reserved.
//

import UIKit

class MonthHeaderCell: UICollectionViewCell {
    @IBOutlet weak var monthLabel: UILabel!

    func configure(name: String) {
        monthLabel.text = name
    }
}
