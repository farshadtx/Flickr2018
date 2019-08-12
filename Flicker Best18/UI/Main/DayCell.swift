//
//  DayCell.swift
//  Flicker Best18
//
//  Created by Farshad Sheykhi on 8/11/19.
//  Copyright © 2019 Farshad. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    @IBOutlet weak var numberLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()

        numberLabel.layer.masksToBounds = true
        numberLabel.layer.cornerRadius = numberLabel.frame.width / 2
    }

    func configure(number: Int) {
        numberLabel.text = "\(number)"
    }
}
