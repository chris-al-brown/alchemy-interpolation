// -----------------------------------------------------------------------------
// Copyright (c) 2015 - 2016, Christopher A. Brown (chris-al-brown)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
// AlchemyInterpolation
// AlchemyInterpolationTests.swift
// 06/17/2016
// -----------------------------------------------------------------------------

import XCTest
@testable import AlchemyInterpolation

/// Returns a uniform Float in [0.0, 1.0] using arc4random
public func uniform() -> Double {
    return Double(uniform() as Float)
}

/// Returns a uniform Float in [0.0, 1.0] using arc4random
public func uniform() -> Float {
    return uniformCast(arc4random_uniform(UINT32_MAX))
}

/// Returns a uniform value in [0.0, 1.0] bitcasting from an input in {0, 1, ..., UINT32_MAX}
public func uniformCast(_ input: UInt32) -> Float {
    let kExponentBits = UInt32(0x3F800000)
    let kMantissaMask = UInt32(0x007FFFFF)
    let u = (input & kMantissaMask) | kExponentBits
    return unsafeBitCast(u, to:Float.self) - 1.0
}

/// ...
public let methods: [InterpolationMethod] = [
    .easeInLinear,
    .easeInQuadratic,
    .easeInCubic,
    .easeInQuartic,
    .easeInQuintic,
    .easeInSine,
    .easeInCircular,
    .easeInExponential
]

/// ...
public let sampleCount: Int = 10_000

/// ...
public class AlchemyInterpolationTests: XCTestCase {
    
    /// ...
    public func testFloat() {
        for _ in 0..<sampleCount {
            let x: Float = uniform()
            let y: Float = uniform()
            let min = Swift.min(x, y)
            let max = Swift.max(x, y)
            for method in methods {
                let value = min.interpolated(to:max, by:uniform(), using:method)
                let minValue = min - FLT_EPSILON
                let maxValue = max + FLT_EPSILON
                XCTAssert(minValue < value && value < maxValue, "\(method) produced \(value) outside of [\(min), \(max)].")
            }
        }
    }
    
    /// ...
    public func testDouble() {
        for _ in 0..<sampleCount {
            let x: Double = uniform()
            let y: Double = uniform()
            let min = Swift.min(x, y)
            let max = Swift.max(x, y)
            for method in methods {
                let value = min.interpolated(to:max, by:uniform(), using:method)
                let minValue = min - DBL_EPSILON
                let maxValue = max + DBL_EPSILON
                XCTAssert(minValue < value && value < maxValue, "\(method) produced \(value) outside of [\(min), \(max)].")
            }
        }
    }

//    func testFloat2() {
//        
//    }
//
//    func testFloat3() {
//        
//    }
//
//    func testFloat4() {
//        
//    }
//
//    func testDouble() {
//        
//    }
//
//    func testDouble2() {
//        
//    }
//
//    func testDouble3() {
//        
//    }
//
//    func testDouble4() {
//        
//    }

    public static var allTests : [(String, (AlchemyInterpolationTests) -> () throws -> Void)] {
        return [
            ("testFloat", testFloat),
        ]
    }
}
