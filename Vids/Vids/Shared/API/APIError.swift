//
//  APIError.swift
//  Vids
//
//  Created by AliReza on 2024-06-16.
//

import Foundation

struct APIError: Error {
    let message: String
    init(message: String) {
        self.message = message
    }
}
