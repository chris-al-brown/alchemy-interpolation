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
// AlchemyInterpolate
// Interpolation.swift
// 10/05/2015
// -----------------------------------------------------------------------------

import Foundation
import simd

/// ...
public protocol Interpolation {
    
    /// ...
    associatedtype InterpolationDistance: InterpolationFloatingPoint
    
    /// ...
    static func interpolate(from start: Self, to end: Self, by distance: InterpolationDistance) -> Self
}

/// ...
public protocol InterpolationFloatingPoint: FloatingPoint {

    /// ...
    static func cos(_ value: Self) -> Self

    /// ...
    static func sin(_ value: Self) -> Self

    /// ...
    static func sqrt(_ value: Self) -> Self

    /// ...
    static func pow(_ base: Self, _ exponent: Self) -> Self
}

/// ...
public enum InterpolationMethod {
    
    /// ...
    case easeInLinear
    
    /// ...
    case easeInQuadratic
    
    /// ...
    case easeInCubic
    
    /// ...
    case easeInQuartic

    /// ...
    case easeInQuintic
    
    /// ...
    case easeInSine

    /// ...
    case easeInCircular

    /// ...
    case easeInExponential

    /// ...
    case easeInOutLinear
    
    /// ...
    case easeInOutQuadratic
    
    /// ...
    case easeInOutCubic
    
    /// ...
    case easeInOutQuartic
    
    /// ...
    case easeInOutQuintic
    
    /// ...
    case easeInOutSine
    
    /// ...
    case easeInOutCircular
    
    /// ...
    case easeInOutExponential
    
    /// ...
    case easeOutLinear
    
    /// ...
    case easeOutQuadratic
    
    /// ...
    case easeOutCubic
    
    /// ...
    case easeOutQuartic
    
    /// ...
    case easeOutQuintic
    
    /// ...
    case easeOutSine
    
    /// ...
    case easeOutCircular
    
    /// ...
    case easeOutExponential
}

/// ...
extension Interpolation {

    /// ...
    public static func interpolate(from start: Self, to end: Self, by distance: InterpolationDistance, using method: InterpolationMethod) -> Self {
        switch method {
        case .easeInLinear:
            return interpolate(from:start, to:end, by:distance)
        case .easeInQuadratic:
            return interpolate(from:start, to:end, by:distance * distance)
        case .easeInCubic:
            return interpolate(from:start, to:end, by:distance * distance * distance)
        case .easeInQuartic:
            return interpolate(from:start, to:end, by:distance * distance * distance * distance)
        case .easeInQuintic:
            return interpolate(from:start, to:end, by:distance * distance * distance * distance * distance)
        case .easeInSine:
            let value = InterpolationDistance.sin((distance - 1) * (.pi / 2)) + InterpolationDistance(1)
            return interpolate(from:start, to:end, by:value)
        case .easeInCircular:
            let value = 1 - InterpolationDistance.sqrt(1 - (distance * distance))
            return interpolate(from:start, to:end, by:value)
        case .easeInExponential:
            let value = distance == 0 ? 0 : InterpolationDistance.pow(2, 10 * (distance - 1))
            return interpolate(from:start, to:end, by:value)
        case .easeInOutLinear:
            return interpolate(from:start, to:end, by:distance)
        case .easeInOutQuadratic:
            let half = InterpolationDistance(sign:.plus, exponent:-2, significand:2)
            if distance < half {
                return interpolate(from:start, to:end, by:2 * distance * distance)
            } else {
                return interpolate(from:start, to:end, by:4 * distance - 2 * distance * distance - 1)
            }
        case .easeInOutCubic:
            let half = InterpolationDistance(sign:.plus, exponent:-2, significand:2)
            if distance < half {
                return interpolate(from:start, to:end, by:4 * distance * distance * distance)
            } else {
                let dd = (2 * distance) - 2
                let _1 = InterpolationDistance(1)
                return interpolate(from:start, to:end, by:half * dd * dd * dd + _1)
            }
        case .easeInOutQuartic:
            let half = InterpolationDistance(sign:.plus, exponent:-2, significand:2)
            if distance < half {
                return interpolate(from:start, to:end, by:8 * distance * distance * distance * distance)
            } else {
                let dd = distance - 1
                return interpolate(from:start, to:end, by:-8 * dd * dd * dd * dd + 1)
            }
        case .easeInOutQuintic:
            let half = InterpolationDistance(sign:.plus, exponent:-2, significand:2)
            if distance < half {
                return interpolate(from:start, to:end, by:16 * distance * distance * distance * distance * distance)
            } else {
                let dd = (2 * distance) - 2
                let _1 = InterpolationDistance(1)
                return interpolate(from:start, to:end, by:half * dd * dd * dd * dd * dd + _1)
            }
        case .easeInOutSine:
            let half = InterpolationDistance(sign:.plus, exponent:-2, significand:2)
            return interpolate(from:start, to:end, by:half * (1 - InterpolationDistance.cos(distance * .pi)))
        case .easeInOutCircular:
            let half = InterpolationDistance(sign:.plus, exponent:-2, significand:2)
            if distance < half {
                let value = half * (1 - InterpolationDistance.sqrt(1 - 4 * (distance * distance)))
                return interpolate(from:start, to:end, by:value)
            } else {
                let v1 = -((2 * distance) - 3)
                let v2 = (2 * distance) - 1
                let _1 = InterpolationDistance(1)
                let value = half * (InterpolationDistance.sqrt(v1 * v2) + _1)
                return interpolate(from:start, to:end, by:value)
            }
        case .easeInOutExponential:
            if distance == 0 || distance == 1 {
                return interpolate(from:start, to:end, by:distance)
            } else {
                let half = InterpolationDistance(sign:.plus, exponent:-2, significand:2)
                if distance < half {
                    let value = half * InterpolationDistance.pow(2, (20 * distance) - 10)
                    return interpolate(from:start, to:end, by:value)
                } else {
                    let _1 = InterpolationDistance(1)
                    let _10 = InterpolationDistance(10)
                    let value = -half * InterpolationDistance.pow(2, (-20 * distance) + _10) + _1
                    return interpolate(from:start, to:end, by:value)
                }
            }
        case .easeOutLinear:
            return interpolate(from:start, to:end, by:distance)
        case .easeOutQuadratic:
            return interpolate(from:start, to:end, by:distance * (2 - distance))
        case .easeOutCubic:
            let dd = distance - 1
            return interpolate(from:start, to:end, by:dd * dd * dd + InterpolationDistance(1))
        case .easeOutQuartic:
            let dd = distance - 1
            return interpolate(from:start, to:end, by:dd * dd * dd * (1 - distance) + InterpolationDistance(1))
        case .easeOutQuintic:
            let dd = distance - 1
            return interpolate(from:start, to:end, by:dd * dd * dd * dd * dd + InterpolationDistance(1))
        case .easeOutSine:
            let value = InterpolationDistance.sin(distance * (.pi / 2))
            return interpolate(from:start, to:end, by:value)
        case .easeOutCircular:
            let value = InterpolationDistance.sqrt((2 - distance) * distance)
            return interpolate(from:start, to:end, by:value)
        case .easeOutExponential:
            let value = distance == 1 ? distance : 1 - InterpolationDistance.pow(2, 10 * (distance - 1))
            return interpolate(from:start, to:end, by:value)
        }
    }
    
    /// ...
    public mutating func interpolate(to end: Self, by distance: InterpolationDistance) {
        self = Self.interpolate(from:self, to:end, by:distance, using:.easeInLinear)
    }

    /// ...
    public mutating func interpolate(to end: Self, by distance: InterpolationDistance, using method: InterpolationMethod) {
        self = Self.interpolate(from:self, to:end, by:distance, using:method)
    }

    /// ...
    public func interpolated(to end: Self, by distance: InterpolationDistance) -> Self {
        return Self.interpolate(from:self, to:end, by:distance, using:.easeInLinear)
    }

    /// ...
    public func interpolated(to end: Self, by distance: InterpolationDistance, using method: InterpolationMethod) -> Self {
        return Self.interpolate(from:self, to:end, by:distance, using:method)
    }
}

/// ...
extension Double: Interpolation {
    
    /// ...
    public typealias InterpolationDistance = Double
    
    /// ...
    public static func interpolate(from start: Double, to end: Double, by distance: Double) -> Double {
        return distance * end + (1.0 - distance) * start
    }
}

/// ...
extension Double: InterpolationFloatingPoint {

    /// ...
    public static func cos(_ value: Double) -> Double {
        return Darwin.cos(value)
    }
    
    /// ...
    public static func sin(_ value: Double) -> Double {
        return Darwin.sin(value)
    }
    
    /// ...
    public static func sqrt(_ value: Double) -> Double {
        return Darwin.sqrt(value)
    }
    
    /// ...
    public static func pow(_ base: Double, _ exponent: Double) -> Double {
        return Darwin.pow(base, exponent)
    }
}

/// ...
extension Float: Interpolation {
    
    /// ...
    public typealias InterpolationDistance = Float
    
    /// ...
    public static func interpolate(from start: Float, to end: Float, by distance: Float) -> Float {
        return distance * end + (1.0 - distance) * start
    }
}

/// ...
extension Float: InterpolationFloatingPoint {

    /// ...
    public static func cos(_ value: Float) -> Float {
        return Darwin.cos(value)
    }
    
    /// ...
    public static func sin(_ value: Float) -> Float {
        return Darwin.sin(value)
    }
    
    /// ...
    public static func sqrt(_ value: Float) -> Float {
        return Darwin.sqrt(value)
    }
    
    /// ...
    public static func pow(_ base: Float, _ exponent: Float) -> Float {
        return Darwin.pow(base, exponent)
    }
}
