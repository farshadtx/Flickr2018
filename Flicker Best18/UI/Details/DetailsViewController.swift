//
//  DetailsViewController.swift
//  Flicker Best18
//
//  Created by Farshad Sheykhi on 8/11/19.
//  Copyright © 2019 Farshad. All rights reserved.
//

import UIKit
import RxSwift

class DetailsViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let disposeBag = DisposeBag()
    var indexPath: IndexPath!
}

extension DetailsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        dateLabel.text = "\(Calendar.months[indexPath.section].name), \(indexPath.item - 1)"
        activityIndicator.startAnimating()
        API.getImages(for: "2018-\(indexPath.section + 1)-\(indexPath.item)")
            .subscribe(onNext: handle)
            .disposed(by: disposeBag)

    }

    private func handle(_ result: Result<FlickrPhotosEnvelope, Error>) {

        switch result {
        case let .success(envelope):
            guard let photo = envelope.photos.photo.first else { fallthrough }
            guard let urlString = photo.url_l, let url = URL(string: urlString) else { fallthrough }
            titleLabel.text = photo.title
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.imageView.image = UIImage(data: data!)
                }
            }
        default:
            activityIndicator.stopAnimating()
            titleLabel.text = "Failed to load the top photo!"
            imageView.image = nil
        }
    }
}
