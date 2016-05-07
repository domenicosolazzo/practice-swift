//: Playground - noun: a place where people can play

import UIKit
import Foundation
import XCTest

enum SampleError: ErrorType {case ItCouldBeWorse, ThisIsBad, ThisIsReallyBad}

func sampleThrowingFunc(v: Int) throws -> Int
{
    if (v == 0) {throw SampleError.ItCouldBeWorse}
    if (v < 0) {throw SampleError.ThisIsBad}
    if (v > 255) {throw SampleError.ThisIsReallyBad}
    return v
}


class SwiftErrorTestingSample: XCTestCase
{
    func test_Examples()
    {
        let a = -35
        
        XCTempAssertThrowsError() {try sampleThrowingFunc(a)}
        
        XCTempAssertThrowsSpecificError(SampleError.ThisIsBad) {try sampleThrowingFunc(a)}
        
        XCTempAssertNoThrowError("customized failure message") {
            
            let x = Int(arc4random() % 256)
            let y = try sampleThrowingFunc(x)
            
            XCTAssert(x == y, "")
        }
        
        XCTempAssertNoThrowSpecificError(SampleError.ThisIsReallyBad) {try sampleThrowingFunc(a)}
    }
    
}



func XCTempAssertThrowsError(message: String = "", _ block: () throws -> ())
{
    do
    {
        try block()
        
        let msg = (message == "") ? "Tested block did not throw error as expected." : message
        XCTFail(msg)
    }
    catch {}
}


func XCTempAssertThrowsSpecificError(kind: ErrorType, _ message: String = "", _ block: () throws -> ())
{
    do
    {
        try block()
        
        let msg = (message == "") ? "Tested block did not throw expected \(kind) error." : message
        XCTFail(msg)
    }
    catch let error as NSError
    {
        let expected = kind as NSError
        if ((error.domain != expected.domain) || (error.code != expected.code))
        {
            let msg = (message == "") ? "Tested block threw \(error), not expected \(kind) error." : message
            XCTFail(msg)
        }
    }
}


func XCTempAssertNoThrowError(message: String = "", _ block: () throws -> ())
{
    do {try block()}
    catch
    {
        let msg = (message == "") ? "Tested block threw unexpected error." : message
        XCTFail(msg)
    }
}


func XCTempAssertNoThrowSpecificError(kind: ErrorType, _ message: String = "", _ block: () throws -> ())
{
    do {try block()}
    catch let error as NSError
    {
        let unwanted = kind as NSError
        if ((error.domain == unwanted.domain) && (error.code == unwanted.code))
        {
            let msg = (message == "") ? "Tested block threw unexpected \(kind) error." : message
            XCTFail(msg)
        }
    }
}
