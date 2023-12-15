//
//  IPFSHandler+Add.swift
//
//
//  Created by busido on 03.12.2023.
//

import Foundation
import IPFSAPICleint

extension IPFSHandler {
    public func add(_ data: Data, complition: @escaping (IPFSAddResponse?, Error?) -> Void) throws {
        let fileData = try encodeToFile(with: data)
        let request = IPFSAddRequest(data: fileData)
        apiCleint.sendRequest(request) { response, error in
            complition(response, error)
        }
    }
    
    private func encodeToFile(with data: Data) throws -> Data {
        let str = "{\"data\":\"\(data.base64EncodedString())\"}"
        let fileName = "filenamenoext"
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let path = dir!.appendingPathComponent(fileName)
        try str.write(to: path, atomically: false, encoding: String.Encoding.utf8)
        let fileData = try? Data(contentsOf: path)
        let boundary = apiCleint.boundaryString
        var data = Data()
        data.append("--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(path.lastPathComponent)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
        data.append(fileData!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        return data
    }
}
