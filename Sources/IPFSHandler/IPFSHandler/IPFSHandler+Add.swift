//
//  IPFSHandler+Add.swift
//
//
//  Created by busido on 03.12.2023.
//

import Foundation
import IPFSAPICleint

extension IPFSHandler {
    func add(_ data: Data, complition: @escaping (IPFSAddResponse?, Error?) -> Void) throws {
        let fileData = try encodeToFile(with: data)
        let request = IPFSAddRequest(data: fileData)
        apiCleint.sendRequest(request) { response, error in
            complition(response, error)
        }
    }
    
    private func encodeToFile(with data: Data) throws -> Data {
        guard let path = Bundle.module.path(forResource: "file", ofType: "txt") else {
            print("File not found")
            throw IPFSError.utilityFileNotFound
        }
        let fileURL = NSURL.fileURL(withPath: path)
        let str = "{\"data\":\"\(data.base64EncodedString())\"}"
        try str.write(toFile: fileURL.relativePath, atomically: false, encoding: .utf8)
        let fileData = try? Data(contentsOf: fileURL)
        let boundary = apiCleint.boundaryString
        var data = Data()
        data.append("--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileURL.lastPathComponent)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
        data.append(fileData!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        return data
    }
}
