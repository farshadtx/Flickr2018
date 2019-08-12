//
//  API.swift
//  Flicker Best18
//
//  Created by Farshad Sheykhi on 8/11/19.
//  Copyright © 2019 Farshad. All rights reserved.
//

import Foundation
import RxSwift

enum API {
    static func getImages(for date: String) -> Observable<Result<FlickrPhotosEnvelope, Error>> {
        var urlString = "https://www.flickr.com/services/rest/?method=flickr.photos.search"
        urlString.append("&api_key=\("#API_KEY")")
        urlString.append("&min_upload_date=\(date)")
        urlString.append("&max_upload_date=\(date)")
        urlString.append("&sort=interestingness-desc")
        urlString.append("&extras=url_l")
        urlString.append("&format=json")
        urlString.append("&nojsoncallback=1")

        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        return API.execute(request: request)
    }
}

extension API {
    typealias Response = (response: HTTPURLResponse, data: Data)
    enum APIError: Error {
        case badResponse
    }

    static private func execute<U: Decodable>(request: URLRequest) -> Observable<Result<U, Error>> {
        return make(request: request)
            .map(handleResponse)
    }

    static private func make(request: URLRequest) -> Observable<Response> {
        return URLSession.shared.rx.response(request: request)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
    }

    static private func handleResponse<U: Decodable>(response: Response) -> Result<U, Error> {
        switch response.response.statusCode {
        case 200...299:
            guard let decodedObject = try? JSONDecoder().decode(U.self, from: response.data) else {
                return .failure(APIError.badResponse)
            }
            return .success(decodedObject)
        default:
            return .failure(APIError.badResponse)
        }
    }
}
