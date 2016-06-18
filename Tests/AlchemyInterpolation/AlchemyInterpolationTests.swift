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

/// Returns a uniform CGFloat in [0.0, 1.0] using arc4random
public func uniform() -> CGFloat {
    return CGFloat(uniform() as Float)
}

/// Returns a uniform Double in [0.0, 1.0] using arc4random
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
public let easeInMethods: [InterpolationMethod] = [
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
public let easeInOutMethods: [InterpolationMethod] = [
    .easeInOutLinear,
    .easeInOutQuadratic,
    .easeInOutCubic,
    .easeInOutQuartic,
    .easeInOutQuintic,
    .easeInOutSine,
    .easeInOutCircular,
    .easeInOutExponential
]

/// ...
public let easeOutMethods: [InterpolationMethod] = [
    .easeOutLinear,
    .easeOutQuadratic,
    .easeOutCubic,
    .easeOutQuartic,
    .easeOutQuintic,
    .easeOutSine,
    .easeOutCircular,
    .easeOutExponential
]

/// ...
public let stepMethods: [InterpolationMethod] = [
    .stepFade,
    .stepSmooth
]

/// ...
public let allMethods: [InterpolationMethod] = easeInMethods + easeInOutMethods + easeOutMethods + stepMethods

/// ...
public let sampleCount: Int = 10_000

/// ...
public class AlchemyInterpolationTests: XCTestCase {
    
    /// ...
    public func testCGFloatBounds() {
        for _ in 0..<sampleCount {
            let x: CGFloat = uniform()
            let y: CGFloat = uniform()
            let min = Swift.min(x, y)
            let max = Swift.max(x, y)
            for method in allMethods {
                let value = min.interpolated(to:max, by:uniform(), using:method)
                let minValue = min - CGFloat(DBL_EPSILON)
                XCTAssert(minValue < value, "\(method) produced \(value) < \(min) with difference: \(value - min)")
                let maxValue = max + CGFloat(DBL_EPSILON)
                XCTAssert(value < maxValue, "\(method) produced \(value) > \(max) with difference: \(max - value)")
            }
        }
    }

    /// ...
    public func testDoubleBounds() {
        for _ in 0..<sampleCount {
            let x: Double = uniform()
            let y: Double = uniform()
            let min = Swift.min(x, y)
            let max = Swift.max(x, y)
            for method in allMethods {
                let value = min.interpolated(to:max, by:uniform(), using:method)
                let minValue = min - DBL_EPSILON
                XCTAssert(minValue < value, "\(method) produced \(value) < \(min) with difference: \(value - min)")
                let maxValue = max + DBL_EPSILON
                XCTAssert(value < maxValue, "\(method) produced \(value) > \(max) with difference: \(max - value)")
            }
        }
    }

    /// ...
    public func testFloatBounds() {
        for _ in 0..<sampleCount {
            let x: Float = uniform()
            let y: Float = uniform()
            let min = Swift.min(x, y)
            let max = Swift.max(x, y)
            for method in allMethods {
                let value = min.interpolated(to:max, by:uniform(), using:method)
                let minValue = min - FLT_EPSILON
                XCTAssert(minValue < value, "\(method) produced \(value) < \(min) with difference: \(value - min)")
                /// stepFade accumulates excessive floating point error in calculation
                let maxValue = (method == .stepFade) ? max + 3 * FLT_EPSILON : max + FLT_EPSILON
                XCTAssert(value < maxValue, "\(method) produced \(value) > \(max) with difference: \(max - value)")
            }
        }
    }
    
    /// ...
    public func testCGFloatContinuity() {
        for method in allMethods {
            let min = CGFloat.interpolate(from:0.0, to:1.0, by:0.0 - CGFloat(DBL_EPSILON))
            let max = CGFloat.interpolate(from:0.0, to:1.0, by:0.0 + CGFloat(DBL_EPSILON))
            XCTAssert(max - min <= 2 * CGFloat(DBL_EPSILON), "\(method) is not continuous at 0.0")
        }
        for method in easeInOutMethods {
            let min = CGFloat.interpolate(from:0.0, to:1.0, by:0.5 - CGFloat(DBL_EPSILON))
            let max = CGFloat.interpolate(from:0.0, to:1.0, by:0.5 + CGFloat(DBL_EPSILON))
            XCTAssert(max - min <= 2 * CGFloat(DBL_EPSILON), "\(method) is not continuous at 0.5")
        }
        for method in allMethods {
            let min = CGFloat.interpolate(from:0.0, to:1.0, by:1.0 - CGFloat(DBL_EPSILON))
            let max = CGFloat.interpolate(from:0.0, to:1.0, by:1.0 + CGFloat(DBL_EPSILON))
            XCTAssert(max - min <= 2 * CGFloat(DBL_EPSILON), "\(method) is not continuous at 1.0")
        }
    }

    /// ...
    public func testDoubleContinuity() {
        for method in allMethods {
            let min = Double.interpolate(from:0.0, to:1.0, by:0.0 - DBL_EPSILON)
            let max = Double.interpolate(from:0.0, to:1.0, by:0.0 + DBL_EPSILON)
            XCTAssert(max - min <= 2 * DBL_EPSILON, "\(method) is not continuous at 0.0")
        }
        for method in easeInOutMethods {
            let min = Double.interpolate(from:0.0, to:1.0, by:0.5 - DBL_EPSILON)
            let max = Double.interpolate(from:0.0, to:1.0, by:0.5 + DBL_EPSILON)
            XCTAssert(max - min <= 2 * DBL_EPSILON, "\(method) is not continuous at 0.5")
        }
        for method in allMethods {
            let min = Double.interpolate(from:0.0, to:1.0, by:1.0 - DBL_EPSILON)
            let max = Double.interpolate(from:0.0, to:1.0, by:1.0 + DBL_EPSILON)
            XCTAssert(max - min <= 2 * DBL_EPSILON, "\(method) is not continuous at 1.0")
        }
    }

    /// ...
    public func testFloatContinuity() {
        for method in allMethods {
            let min = Float.interpolate(from:0.0, to:1.0, by:0.0 - FLT_EPSILON)
            let max = Float.interpolate(from:0.0, to:1.0, by:0.0 + FLT_EPSILON)
            XCTAssert(max - min <= 2 * FLT_EPSILON, "\(method) is not continuous at 0.0")
        }
        for method in easeInOutMethods {
            let min = Float.interpolate(from:0.0, to:1.0, by:0.5 - FLT_EPSILON)
            let max = Float.interpolate(from:0.0, to:1.0, by:0.5 + FLT_EPSILON)
            XCTAssert(max - min <= 2 * FLT_EPSILON, "\(method) is not continuous at 0.5")
        }
        for method in allMethods {
            let min = Float.interpolate(from:0.0, to:1.0, by:1.0 - FLT_EPSILON)
            let max = Float.interpolate(from:0.0, to:1.0, by:1.0 + FLT_EPSILON)
            XCTAssert(max - min <= 2 * FLT_EPSILON, "\(method) is not continuous at 1.0")
        }
    }

    public static var allTests : [(String, (AlchemyInterpolationTests) -> () throws -> Void)] {
        return [
            ("testCGFloatBounds", testCGFloatBounds),
            ("testCGFloatContinuity", testCGFloatContinuity),
            ("testDoubleBounds", testDoubleBounds),
            ("testDoubleContinuity", testDoubleContinuity),
            ("testFloatBounds", testFloatBounds),
            ("testFloatContinuity", testFloatContinuity)
        ]
    }
}
