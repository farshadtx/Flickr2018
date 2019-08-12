//
//  MainCollectionViewDataSource.swift
//  Flicker Best18
//
//  Created by Farshad Sheykhi on 8/11/19.
//  Copyright © 2019 Farshad. All rights reserved.
//

import RxDataSources

enum MainRow {
    case monthHeader( _ name: String)
    case day(_ number: Int)
}

extension MainRow {
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        switch self {
        case let .monthHeader(name):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthHeaderCell.reuseIdentifier, for: indexPath) as? MonthHeaderCell
            cell?.configure(name: name)
            return cell
        case let .day(number):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.reuseIdentifier, for: indexPath) as? DayCell
            cell?.configure(number: number)
            return cell
        }
    }

    func getItemSize(collectionView: UICollectionView) -> CGSize {
        let width = collectionView.frame.size.width
        switch self {
        case .monthHeader:
            return CGSize(width: width, height: 30)
        case .day:
            return CGSize(width: (width - 35) / 7, height: (width - 35) / 7)
        }
    }
}

struct MainSection {
    var items: [Item]
}

extension MainSection: SectionModelType {
    typealias Item = MainRow

    init(original: MainSection, items: [Item]) {
        self = original
        self.items = items
    }
}

extension MainSection {
    static func createSections(months: [Calendar.Month]) -> [MainSection] {
        return months.map { month in
            var items: [MainRow] = []
            items.append(MainRow.monthHeader(month.name))
            let days = Array(1...month.days).map(MainRow.day)
            items.append(contentsOf: days)
            return MainSection(items: items)
        }
    }
}
