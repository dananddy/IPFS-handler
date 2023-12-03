//
//  IPFSHandler+Get.swift
//
//
//  Created by busido on 03.12.2023.
//

import Foundation
import IPFSAPICleint

extension IPFSHandler {
    public func get(hashValue: String, complition: @escaping (IPFSGetResponse?, Error?) -> Void) {
        let request = IPFSGetRequest(hashValue: hashValue)
        apiCleint.sendRequest(request) { response, error in
            complition(response, error)
        }
    }
}
