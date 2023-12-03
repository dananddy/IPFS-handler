//
//  Arguments.swift
//
//
//  Created by busido on 03.12.2023.
//

import Foundation

class URLArgument {
    struct Argument {
        let name: String?
        let value: String?
    }
    
    var arguments: [Argument]
    
    init(name: String?,
         value: String?) {
        self.arguments = [Argument(name: name, value: value)]
    }
    
    func addArgument(_ name: String, _ value: String) {
        arguments.append(Argument(name: name, value: value))
    }
    
    func getAsQueryItem() -> [URLQueryItem]? {
        var queryItems: [URLQueryItem] = []
        for arg in arguments {
            if let name = arg.name, let value = arg.value {
                queryItems.append(URLQueryItem(name: name,
                                               value: value))
            }
        }
        return queryItems.isEmpty ? nil : queryItems
    }
}
