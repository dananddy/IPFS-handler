//
//  IPFSHandler.swift
//
//
//  Created by busido on 02.12.2023.
//

import IPFSAPICleint

public class IPFSHandler {
    let settings: IPFSSettings
    let apiCleint: IPFSAPIClient
    
    public init(settings: IPFSSettings) {
        self.settings = settings
        self.apiCleint = IPFSAPIClient(settings: settings.apiSettings)
    }
}
