//
//  PeakResultTests.swift
//  PeakResultTests
//
//  Created by Sam Oakley on 28/11/2016.
//  Copyright © 2016 3Squared. All rights reserved.
//

import XCTest
@testable import PeakResult

class ResultTests: XCTestCase {
    
    public enum TestError: Error {
        case justATest
        case alsoATest
    }
    
    func testResultResolution() {
        // Both are same type even though one has a string and the other contains an error
        let niceResult = Result { return "Hello!" }
        let throwingResult = Result { throw TestError.justATest }
        
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
    
    func testMappingSuccess() {
        let expect = expectation(description: "")
        let niceResult = Result { return "Hello!" }
        
        niceResult.map { string in
            XCTAssertEqual(string, "Hello!")
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 0)
    }
    
    func testMappingError() {
        let expect = expectation(description: "")
        let throwingResult = Result { throw TestError.justATest }
        
        throwingResult.map { string in
            XCTFail()
        }.mapError { error in
            XCTAssertNotNil(error)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 0)
    }
    
    func testMappingChaining() {
        let niceResult = Result { return 0 }
        
        let result = try! niceResult.map({ value in
            return value + 1
        }).map({ value -> String in
            return "Hello, \(value)!"
        }).resolve()
        
        XCTAssertEqual(result, "Hello, 1!")
    }
    
    func testFlatMappingSuccess() {
        let niceResult = Result { return "Hello!" }
        
        let result = try! niceResult.flatMap { string -> Result<String> in
            return Result { "Goodbye" }
        }.resolve()
        
                
        XCTAssertEqual(result, "Goodbye")
    }

    func testFlatMapErrorWithError() {
        let throwingResult = Result { throw TestError.justATest }
        
        let result = throwingResult.flatMapError { error in
            return Result { throw TestError.alsoATest }
        }
        
        do {
            let _ = try result.resolve()
            XCTFail()
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testFlatMapErrorWithSuccess() {
        let niceResult = Result { return "Hello!" }

        let result = niceResult.flatMapError { error in
            XCTFail()
            return Result { throw TestError.alsoATest }
        }
        
        do {
            let _ = try result.resolve()
        } catch {
            XCTFail()
        }
    }

    func testFoldingWithSuccess() {
        let result = Result { return "Hello!" }
        
        let unwrapped = result.fold({ value in
            return true
        }) { error in
            return false
        }
        
        XCTAssertTrue(unwrapped)
    }
    
    func testFoldingWithFailure() {
        let result = Result { throw TestError.justATest }

        let unwrapped = result.fold({ value in
            return true
        }) { error in
            return false
        }
        
        XCTAssertFalse(unwrapped)
    }
}
