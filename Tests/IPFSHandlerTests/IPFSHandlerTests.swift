import XCTest
@testable import IPFSHandler

final class IPFSHandlerTests: XCTestCase {
    
    
    static func getSettings() -> IPFSSettings {
        IPFSSettings(baseUrl: "http://127.0.0.1:5001/api/v0")
    }
    
    func testAdd() async throws {
        let exp = expectation(description: "wait")
        let handler = IPFSHandler(settings: IPFSHandlerTests.getSettings())
        try handler.add("Added repo".data(using: .utf8)!) { response, error in
            XCTAssertNotNil(response)
            exp.fulfill()
        }
        
        await fulfillment(of: [exp], timeout: 20)
    }
    
    func testGet() async throws {
        let exp = expectation(description: "wait")
        let handler = IPFSHandler(settings: IPFSHandlerTests.getSettings())
        handler.get(hashValue: "QmcAjw6schPVxy21KBubvKVMS44vSMHoHGvhEvTv4UccYY") { response, error in
            XCTAssertNotNil(response)
            exp.fulfill()
        }
        
        await fulfillment(of: [exp], timeout: 20)
    }
    
    func testFullProccess() async throws {
        let exp = expectation(description: "wait")
        let handler = IPFSHandler(settings: IPFSHandlerTests.getSettings())
        try handler.add("Test".data(using: .utf8)!) { response, error in
            XCTAssertNotNil(response)
            handler.get(hashValue: response!.hash) { response, error in
                XCTAssertNotNil(response)
                print(String(data: response!.decodedData!, encoding: .utf8))
                exp.fulfill()
            }
        }
        await fulfillment(of: [exp], timeout: 20)
    }
}
