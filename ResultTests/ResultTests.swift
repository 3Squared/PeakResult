//
//  ResultTests.swift
//  ResultTests
//
//  Created by Sam Oakley on 28/11/2016.
//  Copyright © 2016 3Squared. All rights reserved.
//

import XCTest
@testable import Result

class ResultTests: XCTestCase {
    
    public enum TestError: Error {
        case justATest
    }
    
    func testResultResolution() {
        // Both are same type even though one has a string and the other contains an error
        let niceResult: Result<String> = Result { return "Hello!" }
        let throwingResult: Result<String> = Result { throw TestError.justATest }
        
        switch niceResult {
        case .success(let value):
            XCTAssertEqual(value, "Hello!")
            break
        case .failure(_):
            XCTFail()
        }
        
        switch throwingResult {
        case .failure(TestError.justATest):
            break
        default:
            XCTFail()
        }
        
        // Or, converting to do-catch:
        
        do {
            let result = try niceResult.resolve()
            XCTAssertEqual(result, "Hello!")
        } catch {
            XCTFail()
        }
        
        do {
            let _ = try throwingResult.resolve()
            XCTFail()
        } catch {
            switch error {
            case TestError.justATest:
                break
            default:
                XCTFail()
            }
        }
    }
    
}
