//
//  NetworkingHelper.swift
//  InfinityWarApp
//
//  Created by Roger Silva on 28/04/2018.
//  Copyright © 2018 The Guardians Of Brotherhood. All rights reserved.
//

import Foundation

enum NetworkingHelperError: Error {
    case RequestError
    case HttpStatusError
    case SerializationJsonError
}

class NetworkingHelper {

    let baseUrl = PListHelper().getInfo(filename: "Url", key: "baseUrl")
    let queryParam = PListHelper().getInfo(filename: "Url", key: "queryParam")
    
    func startLoad<T>(_ type: T.Type, _ url: String, _ funcSucess: @escaping (T) -> Void,
                      _ funcError: @escaping (NetworkingHelperError) -> Void) throws where T: Decodable {
        
        let url = URL(string: baseUrl + url + queryParam)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                funcError(NetworkingHelperError.RequestError)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    funcError(NetworkingHelperError.HttpStatusError)
                    return
            }
            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
                let data = data {
                do {
                    let objects = try JSONDecoder().decode(type, from: data)
                    funcSucess(objects)
                } catch {
                    funcError(NetworkingHelperError.SerializationJsonError)
                }
            }
        }
        task.resume()
    }
    
}
