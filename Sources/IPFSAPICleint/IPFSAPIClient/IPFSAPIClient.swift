//
//  IPFSAPIClient.swift
//
//
//  Created by busido on 02.12.2023.
//

import Foundation

enum APIError: Error {
    case badCode
    case badRequest
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

open class IPFSAPIClient {
    
    public let boundaryString: String
    let settings: APISettings
    let session: URLSession
    let baseURL: String
    
    public init(settings: APISettings) {
        self.settings = settings
        self.baseURL = settings.baseURL
        self.session = URLSession(configuration: .default)
        self.boundaryString = UUID().uuidString
    }
    
    public func sendRequestX<T: IPFSResponse>(_ ipfsRequest: IPFSRequest) async throws -> T {
        var request = try populateURL(ipfsRequest)
        request.httpMethod = ipfsRequest.httpMethod
        
        print("Request:\n\(request)")
        let (data, urlResponse) = try await session.data(for: request)
        print("Data:\n\(data)")
        print("Url Reponse:\n\(urlResponse)")
        guard let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode,
                200...299 ~=  statusCode else {
            throw APIError.badCode
        }
        let response: T = try parseResponse(of: data)
        print("Url Reponse:\n\(response)")
        return response
    }
    
    public func sendRequest<T: IPFSResponse>(
        _ ipfsRequest: IPFSRequest, completion: @escaping (T?, Error?) -> Void) {
        var request = try! populateURL(ipfsRequest)
        request.httpMethod = ipfsRequest.httpMethod
        request.httpBody = ipfsRequest.data
        if let _ = request.httpBody {
            request.setValue("multipart/form-data; boundary=\(boundaryString)", forHTTPHeaderField: "Content-Type")
        }
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(nil, APIError.badCode)
                return
            }
            let response: T? = try? self.parseResponse(of: data)
            print("Response: \n\(String(data: data, encoding: .utf8))")
            completion(response, nil)
        }.resume()
    }
    
    private func populateURL(_ request: IPFSRequest) throws -> URLRequest {
        let urlString = baseURL + request.urlMethod
        guard var url = URL(string: urlString) else {
            throw APIError.badRequest
        }
        if let arguments = request.arguments {
            url.append(queryItems: arguments)
        }
        return URLRequest(url: url)
    }
    
    private func parseResponse<T: Codable>(of data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}

extension Data{
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8){
            self.append(data)
        }
    }
}
