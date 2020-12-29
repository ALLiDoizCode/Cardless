//
//  APIClient.swift
//  Cardless
//
//  Created by Jonathan Green on 12/28/20.
//

import Foundation

enum APIClientError: Error {
    case noData
}

final class APIClient {

    func load(request: URLRequest) -> Future<Data> {
        let promise = Promise<Data>()
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard let data = data else {
                promise.reject(with: APIClientError.noData)
                return
            }
            if let error = error {
                promise.reject(with: error)
                return
            }
            print(data)
            promise.resolve(with: data)

        }
        task.resume()
        return promise
    }

}
