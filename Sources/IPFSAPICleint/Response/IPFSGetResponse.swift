//
//  IPFSGetResponse.swift
//
//
//  Created by busido on 03.12.2023.
//

import Foundation

open class IPFSGetResponse: IPFSResponse {
    public var decodedData: Data? {
        Data(base64Encoded: data)
    }
    
    let data: String
}
