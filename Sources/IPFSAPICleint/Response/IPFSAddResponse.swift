//
//  IPFSAddResponse.swift
//
//
//  Created by busido on 03.12.2023.
//

import Foundation

open class IPFSAddResponse: IPFSResponse {
    public let hash: String
    let name: String
    let size: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case hash = "Hash"
        case size = "Size"
    }
}
