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
    static func easeInSine(by distance: Self) -> Self
    
    /// ...
    static func easeInCircular(by distance: Self) -> Self

    /// ...
    static func easeInExponential(by distance: Self) -> Self
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
            return interpolate(from:start, to:end, by:InterpolationDistance.easeInSine(by:distance))
        case .easeInCircular:
            return interpolate(from:start, to:end, by:InterpolationDistance.easeInCircular(by:distance))
        case .easeInExponential:
            return interpolate(from:start, to:end, by:InterpolationDistance.easeInExponential(by:distance))
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
    public static func easeInSine(by distance: Double) -> Double {
        return sin((distance - 1.0) * (.pi / 2.0)) + 1.0
    }
    
    /// ...
    public static func easeInCircular(by distance: Double) -> Double {
        return 1.0 - sqrt(1.0 - (distance * distance))
    }
    
    /// ...
    public static func easeInExponential(by distance: Double) -> Double {
        return distance == 0.0 ? distance : pow(2, 10 * (distance - 1))
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
    public static func easeInSine(by distance: Float) -> Float {
        return sin((distance - 1.0) * (.pi / 2.0)) + 1.0
    }
    
    /// ...
    public static func easeInCircular(by distance: Float) -> Float {
        return 1.0 - sqrt(1.0 - (distance * distance))
    }
    
    /// ...
    public static func easeInExponential(by distance: Float) -> Float {
        return distance == 0.0 ? distance : pow(2, 10 * (distance - 1))
    }
}

///// AnimationTween
//public enum AnimationTween {
//    case Linear
//    case Quadratic
//    case Cubic
//    case Quartic
//    case Quintic
//    case Sine
//    case Circular
//    case Exponential
//
//    private func easeIn(x: Time) -> Time {
//        switch self {
//        case .Linear:
//            return x
//        case .Quadratic:
//            return x * x
//        case .Cubic:
//            return x * x * x
//        case .Quartic:
//            return x * x * x * x
//        case .Quintic:
//            return x * x * x * x * x
//        case .Sine:
//            return sin((x - 1) * M_PI_2) + 1
//        case .Circular:
//            return 1 - sqrt(1 - (x * x))
//        case .Exponential:
//            return x == 0.0 ? x : pow(2, 10 * (x - 1))
//        }
//    }
//
//    private func easeInOut(x: Time) -> Time {
//        switch self {
//        case .Linear:
//            return x
//        case .Quadratic:
//            if x < 0.5 {
//                return 2.0 * x * x
//            } else {
//                return 4.0 * x - 2.0 * x * x - 1.0
//            }
//        case .Cubic:
//            if x < 0.5 {
//                return 4.0 * x * x * x
//            } else {
//                let xx = (2 * x) - 2
//                return 0.5 * xx * xx * xx + 1
//            }
//        case .Quartic:
//            if x < 0.5 {
//                return 8.0 * x * x * x * x
//            } else {
//                let xx = x - 1
//                return -8.0 * xx * xx * xx * xx + 1
//            }
//        case .Quintic:
//            if x < 0.5 {
//                return 16.0 * x * x * x * x * x
//            } else {
//                let xx = (2 * x) - 2
//                return  0.5 * xx * xx * xx * xx * xx + 1
//            }
//        case .Sine:
//            return 0.5 * (1 - cos(x * M_PI))
//        case .Circular:
//            if x < 0.5 {
//                return 0.5 * (1 - sqrt(1 - 4 * (x * x)))
//            } else {
//                return 0.5 * (sqrt(-((2 * x) - 3) * ((2 * x) - 1)) + 1)
//            }
//        case .Exponential:
//            if x == 0.0 || x == 1.0 {
//                return x
//            }
//            if x < 0.5 {
//                return  0.5 * pow(2, (20 * x) - 10)
//            } else {
//                return -0.5 * pow(2, (-20 * x) + 10) + 1
//            }
//        }
//    }
//
//    private func easeOut(x: Time) -> Time {
//        switch self {
//        case .Linear:
//            return x
//        case .Quadratic:
//            return x * (2.0 - x)
//        case .Cubic:
//            let xx = x - 1
//            return xx * xx * xx + 1
//        case .Quartic:
//            let xx = x - 1
//            return xx * xx * xx * (1 - x) + 1
//        case .Quintic:
//            let xx = x - 1
//            return xx * xx * xx * xx * xx + 1
//        case .Sine:
//            return sin(x * M_PI_2)
//        case .Circular:
//            return sqrt((2 - x) * x)
//        case .Exponential:
//            return x == 1.0 ? x : 1 - pow(2, -10 * x)
//        }
//    }
//}

///// easeInStep: Float
//public func easeInStep(animation: Animation<Float>, tween: AnimationTween = .Quadratic) -> Float {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeIn(animation.stepUnit)))
//}
//
///// easeInStep: float2
//public func easeInStep(animation: Animation<float2>, tween: AnimationTween = .Quadratic) -> float2 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeIn(animation.stepUnit)))
//}
//
///// easeInStep: float3
//public func easeInStep(animation: Animation<float3>, tween: AnimationTween = .Quadratic) -> float3 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeIn(animation.stepUnit)))
//}
//
///// easeInStep: float4
//public func easeInStep(animation: Animation<float4>, tween: AnimationTween = .Quadratic) -> float4 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeIn(animation.stepUnit)))
//}
//
///// easeInOutStep: Float
//public func easeInOutStep(animation: Animation<Float>, tween: AnimationTween = .Quadratic) -> Float {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeInOut(animation.stepUnit)))
//}
//
///// easeInOutStep: float2
//public func easeInOutStep(animation: Animation<float2>, tween: AnimationTween = .Quadratic) -> float2 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeInOut(animation.stepUnit)))
//}
//
///// easeInOutStep: float3
//public func easeInOutStep(animation: Animation<float3>, tween: AnimationTween = .Quadratic) -> float3 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeInOut(animation.stepUnit)))
//}
//
///// easeInOutStep: float4
//public func easeInOutStep(animation: Animation<float4>, tween: AnimationTween = .Quadratic) -> float4 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeInOut(animation.stepUnit)))
//}
//
///// easeOutStep: Float
//public func easeOutStep(animation: Animation<Float>, tween: AnimationTween = .Quadratic) -> Float {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeOut(animation.stepUnit)))
//}
//
///// easeOutStep: float2
//public func easeOutStep(animation: Animation<float2>, tween: AnimationTween = .Quadratic) -> float2 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeOut(animation.stepUnit)))
//}
//
///// easeOutStep: float3
//public func easeOutStep(animation: Animation<float3>, tween: AnimationTween = .Quadratic) -> float3 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeOut(animation.stepUnit)))
//}
//
///// easeOutStep: float4
//public func easeOutStep(animation: Animation<float4>, tween: AnimationTween = .Quadratic) -> float4 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeOut(animation.stepUnit)))
//}
//
///// easeInPulse: Float
//public func easeInPulse(animation: Animation<Float>, tween: AnimationTween = .Quadratic) -> Float {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeIn(animation.pulseUnit)))
//}
//
///// easeInPulse: float2
//public func easeInPulse(animation: Animation<float2>, tween: AnimationTween = .Quadratic) -> float2 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeIn(animation.pulseUnit)))
//}
//
///// easeInPulse: float3
//public func easeInPulse(animation: Animation<float3>, tween: AnimationTween = .Quadratic) -> float3 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeIn(animation.pulseUnit)))
//}
//
///// easeInPulse: float4
//public func easeInPulse(animation: Animation<float4>, tween: AnimationTween = .Quadratic) -> float4 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeIn(animation.pulseUnit)))
//}
//
///// easeInOutPulse: Float
//public func easeInOutPulse(animation: Animation<Float>, tween: AnimationTween = .Quadratic) -> Float {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeInOut(animation.pulseUnit)))
//}
//
///// easeInOutPulse: float2
//public func easeInOutPulse(animation: Animation<float2>, tween: AnimationTween = .Quadratic) -> float2 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeInOut(animation.pulseUnit)))
//}
//
///// easeInOutPulse: float3
//public func easeInOutPulse(animation: Animation<float3>, tween: AnimationTween = .Quadratic) -> float3 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeInOut(animation.pulseUnit)))
//}
//
///// easeInOutPulse: float4
//public func easeInOutPulse(animation: Animation<float4>, tween: AnimationTween = .Quadratic) -> float4 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeInOut(animation.pulseUnit)))
//}
//
///// easeOutPulse: Float
//public func easeOutPulse(animation: Animation<Float>, tween: AnimationTween = .Quadratic) -> Float {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeOut(animation.pulseUnit)))
//}
//
///// easeOutPulse: float2
//public func easeOutPulse(animation: Animation<float2>, tween: AnimationTween = .Quadratic) -> float2 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeOut(animation.pulseUnit)))
//}
//
///// easeOutPulse: float3
//public func easeOutPulse(animation: Animation<float3>, tween: AnimationTween = .Quadratic) -> float3 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeOut(animation.pulseUnit)))
//}
//
///// easeOutPulse: float4
//public func easeOutPulse(animation: Animation<float4>, tween: AnimationTween = .Quadratic) -> float4 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeOut(animation.pulseUnit)))
//}
//
///// easeInPeriodic: Float
//public func easeInPeriodic(animation: Animation<Float>, period: Time, tween: AnimationTween = .Quadratic) -> Float {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeIn(animation.periodicUnit(period))))
//}
//
///// easeInPeriodic: float2
//public func easeInPeriodic(animation: Animation<float2>, period: Time, tween: AnimationTween = .Quadratic) -> float2 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeIn(animation.periodicUnit(period))))
//}
//
///// easeInPeriodic: float3
//public func easeInPeriodic(animation: Animation<float3>, period: Time, tween: AnimationTween = .Quadratic) -> float3 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeIn(animation.periodicUnit(period))))
//}
//
///// easeInPeriodic: float4
//public func easeInPeriodic(animation: Animation<float4>, period: Time, tween: AnimationTween = .Quadratic) -> float4 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeIn(animation.periodicUnit(period))))
//}
//
///// easeInOutPeriodic: Float
//public func easeInOutPeriodic(animation: Animation<Float>, period: Time, tween: AnimationTween = .Quadratic) -> Float {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeInOut(animation.periodicUnit(period))))
//}
//
///// easeInOutPeriodic: float2
//public func easeInOutPeriodic(animation: Animation<float2>, period: Time, tween: AnimationTween = .Quadratic) -> float2 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeInOut(animation.periodicUnit(period))))
//}
//
///// easeInOutPeriodic: float3
//public func easeInOutPeriodic(animation: Animation<float3>, period: Time, tween: AnimationTween = .Quadratic) -> float3 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeInOut(animation.periodicUnit(period))))
//}
//
///// easeInOutPeriodic: float4
//public func easeInOutPeriodic(animation: Animation<float4>, period: Time, tween: AnimationTween = .Quadratic) -> float4 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeInOut(animation.periodicUnit(period))))
//}
//
///// easeOutPeriodic: Float
//public func easeOutPeriodic(animation: Animation<Float>, period: Time, tween: AnimationTween = .Quadratic) -> Float {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeOut(animation.periodicUnit(period))))
//}
//
///// easeOutPeriodic: float2
//public func easeOutPeriodic(animation: Animation<float2>, period: Time, tween: AnimationTween = .Quadratic) -> float2 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeOut(animation.periodicUnit(period))))
//}
//
///// easeOutPeriodic: float3
//public func easeOutPeriodic(animation: Animation<float3>, period: Time, tween: AnimationTween = .Quadratic) -> float3 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeOut(animation.periodicUnit(period))))
//}
//
///// easeOutPeriodic: float4
//public func easeOutPeriodic(animation: Animation<float4>, period: Time, tween: AnimationTween = .Quadratic) -> float4 {
//    return mix(animation.startValue, animation.endValue, t:Float(tween.easeOut(animation.periodicUnit(period))))
//}
//
///// Animation<T>
//public struct Animation<T> {
//
//    public init(value: T) {
//        self.startValue = value
//        self.endValue = value
//        self.currentTime = 1_000
//        self.startTime = 0
//        self.endTime = 1_000
//    }
//
//    public init(start: T, end: T, duration: Time) {
//        self.startValue = start
//        self.endValue = end
//        self.currentTime = 0
//        self.startTime = 0
//        self.endTime = duration
//    }
//
//    public init(start: T, end: T, lag: Time, duration: Time) {
//        self.startValue = start
//        self.endValue = end
//        self.currentTime = 0
//        self.startTime = lag
//        self.endTime = lag + duration
//    }
//
//    public mutating func update(deltaTime: Time) {
//        if currentTime < endTime {
//            currentTime += deltaTime
//        }
//    }
//
//    private func periodicUnit(period: Time) -> Time {
//        let t = period * stepUnit
//        let tt = t - floor(t)
//        return tt < 0.5 ? 2.0 * tt : 2.0 * (1.0 - tt)
//    }
//
//    private var pulseUnit: Time {
//        let t = stepUnit
//        return t < 0.5 ? 2.0 * t : 2.0 * (1.0 - t)
//    }
//
//    private var stepUnit: Time {
//        if currentTime < startTime {
//            return 0.0
//        } else if currentTime > endTime {
//            return 1.0
//        } else {
//            return (currentTime - startTime) / (endTime - startTime)
//        }
//    }
//
//    public var isFinished: Bool {
//        return currentTime >= endTime
//    }
//
//    public let startValue: T
//    public let endValue: T
//
//    public var currentTime: Time
//    public let startTime: Time
//    public let endTime: Time
//}
//

