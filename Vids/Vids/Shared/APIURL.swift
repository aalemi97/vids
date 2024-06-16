//
//  APIURL.swift
//  Vids
//
//  Created by AliReza on 2024-06-16.
//

import Foundation
import Alamofire

enum APIURL: String {
    
    case videos = "videos"
    
    private var baseURLKey: String {
        get {
            "Base URL"
        }
    }
    
    private var protocolType: String {
        get {
            "http"
        }
    }
    
    private var baseURL: String {
        Bundle.main.object(forInfoDictionaryKey: baseURLKey) as? String ?? ""
    }
    
    func generateURLString() -> String {
        return "\(protocolType)://\(baseURL)/\(self.rawValue)"
    }
}
