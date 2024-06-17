//
//  NetworkInteractorProvider.swift
//  Vids
//
//  Created by AliReza on 2024-06-16.
//

import Foundation
import Combine
import Alamofire

protocol NetworkInteractorProvider {
    func request<Model: Codable>(url: APIURL,
                             method: HTTPMethod,
                             parameters: [String: Any]?,
                             encoding: URLEncoding,
                             headers: [String: String]?) -> AnyPublisher<Model, APIError>
}
