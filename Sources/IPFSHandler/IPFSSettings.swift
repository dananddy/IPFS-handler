//
//  IPFSSettings.swift
//
//
//  Created by busido on 02.12.2023.
//

import Foundation
import IPFSAPICleint

class  IPFSSettings {
    let apiSettings: APISettings
    
    init(baseUrl: String) {
        self.apiSettings = APISettings(baseURL: baseUrl)
    }
}
