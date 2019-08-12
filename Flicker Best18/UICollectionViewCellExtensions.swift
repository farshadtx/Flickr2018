//
//  UICollectionViewCellExtensions.swift
//  Flicker Best18
//
//  Created by Farshad Sheykhi on 8/11/19.
//  Copyright © 2019 Farshad. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
