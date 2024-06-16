//
//  Interactor.swift
//  Vids
//
//  Created by AliReza on 2024-06-16.
//

import Combine
import Alamofire

class Interactor: NetworkInteractorProvider {
    func request<Model: Decodable>(url: APIURL,
                    method: Alamofire.HTTPMethod = .get,
                    parameters: [String : Any]? = nil,
                    encoding: Alamofire.URLEncoding = .queryString,
                    headers: [String : String]? = nil) -> AnyPublisher<Model, APIError>{
        let urlString = url.generateURLString()
        var httpHeaders: HTTPHeaders? = nil
        if let headers {
            httpHeaders = HTTPHeaders(headers)
        }
        return AF.request(urlString,
                          method: method,
                          parameters: parameters,
                          encoding: encoding,
                          headers: httpHeaders)
        .validate()
        .publishDecodable(type: Model.self, queue: DispatchQueue.global(qos: .background))
        .value()
        .receive(on: DispatchQueue.main)
        .mapError({ error in
            return APIError(message: error.localizedDescription)
        })
        .eraseToAnyPublisher()
    }
    
    
}
