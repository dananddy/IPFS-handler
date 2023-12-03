//
//  IPFSRequest.swift
//
//
//  Created by busido on 03.12.2023.
//

import Foundation

open class IPFSRequest {
    let urlMethod: String
    let arguments: [URLQueryItem]?
    let httpMethod: String
    let data: Data?
    
    init(urlMethod: String,
         arguments: URLArgument?,
         httpMethod: HTTPMethod = .post,
         data: Data?) {
        self.urlMethod = urlMethod
        self.arguments = arguments?.getAsQueryItem()
        self.httpMethod = httpMethod.rawValue
        self.data = data
    }
}
