//
//  SPSTests.swift
//  SPSTests
//
//  Created by Soriyany keo on 7/10/16.
//  Copyright © 2016 Soriyany keo. All rights reserved.
//

import XCTest
@testable import SPS

class GetJSONRequestTests: XCTestCase {
    var getJSonRequest:GetJSONRequest!
    
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var dataTask: NSURLSessionDataTask?
    var url:String!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        url  = REQUESTURL + "news"
        getJSonRequest = GetJSONRequest(url: url)
    }
    func testParseServerDataDoesntCallCompletionWithBrokenJSON() {
        let brokenJsonData = "{".dataUsingEncoding(NSUTF8StringEncoding)
        getJSonRequest.parseServerData(brokenJsonData, response: nil, error: nil) { (result) in
            XCTAssertTrue(result == nil, "Completion closure must not be called with broken JSON data.")
        }
        
    }
    func testParseServerDataCallsCompletionWithProperJSON() {
        let goodJsonData = "[{\"Title\": \"Transforming yourself with testosterone\"}]".dataUsingEncoding(NSUTF8StringEncoding)
        getJSonRequest.parseServerData(goodJsonData, response: nil, error: nil) { (result) in
            XCTAssertTrue(result != nil, "Completion closure must not be called with proper JSON data.")
        }
    }
    
    func testDataTask() {
        if let encodedString = url.stringByAddingPercentEncodingWithAllowedCharacters(
            NSCharacterSet.URLFragmentAllowedCharacterSet()),
            url = NSURL(string: encodedString) {
            dataTask = defaultSession.dataTaskWithURL(url) {
                data, response, error in
                XCTAssertNil(error, "dataTaskWithURL error \(error)")
                
                if let httpResponse = response as? NSHTTPURLResponse {
                    XCTAssertEqual(httpResponse.statusCode, 200, "status code was not 200; was \(httpResponse.statusCode)");
                }
                XCTAssertNil(data, "data nil")
                self.dataTask!.resume()
            }
        }
    }
}