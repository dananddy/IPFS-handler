//
//  IPFSGetRequest.swift
//
//
//  Created by busido on 03.12.2023.
//

import Foundation

open class IPFSGetRequest: IPFSRequest {
    public init(hashValue: String) {
        super.init(urlMethod: "/cat",
                   arguments: URLArgument(name: "arg",
                                          value: hashValue),
                   data: nil)
    }
}
