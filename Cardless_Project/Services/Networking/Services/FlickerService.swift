//
//  FlickerService.swift
//  Flicker
//
//  Created by Jonathan Green on 12/28/20.
//

import Foundation
import Combine

enum FlickerAPI {
    static let client = APIClient()
    static let base = URLComponents(string: "https://api.unsplash.com/search/photos")!

}

extension FlickerAPI {

    static func search(text: String) -> Future<Photos> {
        var components = FlickerAPI.base
        let method = URLQueryItem(name: "page", value: "flickr.photos.search")
        let api_key = URLQueryItem(name: "client_id", value: Constants.API_KEY)
        let text = URLQueryItem(name: "query", value: text)

        components.queryItems = [method, api_key, text]

        let request = URLRequest(url: components.url!)
        let result = client.load(request: request)
        let decodedFuture = result.decoded(as: Photos.self)
        return decodedFuture
    }
}
