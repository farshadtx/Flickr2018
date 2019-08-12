//
//  ViewController.swift
//  Flicker Best18
//
//  Created by Farshad Sheykhi on 8/11/19.
//  Copyright © 2019 Farshad. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class MainViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    let disposeBag = DisposeBag()
    let dataSource = RxCollectionViewSectionedReloadDataSource<MainSection>(configureCell: { _, collectionView, indexPath, item in
        return item.configureCell(collectionView: collectionView, indexPath: indexPath) ?? UICollectionViewCell()
    })
}

extension MainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        Observable
            .of(Calendar.months)
            .map(MainSection.createSections)
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        collectionView.rx.itemSelected
            .compactMap { indexPath -> IndexPath? in
                guard indexPath.item != 0 else { return nil }
                return indexPath
            }
            .subscribe(onNext: loadDetailsViewController)
            .disposed(by: disposeBag)
    }
}

extension MainViewController {
    private func loadDetailsViewController(indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailsViewController.indexPath = indexPath
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataSource.sectionModels[indexPath.section].items[indexPath.item].getItemSize(collectionView: collectionView)
    }
}
