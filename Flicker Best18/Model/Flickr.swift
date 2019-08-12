//
//  FlickerImage.swift
//  Flicker Best18
//
//  Created by Farshad Sheykhi on 8/11/19.
//  Copyright © 2019 Farshad. All rights reserved.
//

import Foundation

struct FlickrPhotosEnvelope: Codable {
    let photos: FlickrPhoto
}

struct FlickrPhoto: Codable {
    let photo: [FlickrImage]
}

struct FlickrImage: Codable {
    let title: String?
    let url_l: String?
}
