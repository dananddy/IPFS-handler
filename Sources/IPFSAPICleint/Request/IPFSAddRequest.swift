//
//  IPFSAddRequest.swift
//
//
//  Created by busido on 03.12.2023.
//

import Foundation

open class IPFSAddRequest: IPFSRequest {
    public init(data: Data) {
        super.init(urlMethod: "/add",
                   arguments: URLArgument(name: "wrap-with-directory", value: "true"),
                   data: data)
    }
}
