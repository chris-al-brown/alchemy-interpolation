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
// simd+Interpolation.swift
// 06/17/2016
// -----------------------------------------------------------------------------

import Foundation
import simd

/// ...
extension double2: Interpolation {
    
    /// ...
    public typealias InterpolationDistance = Double
    
    /// ...
    public static func interpolate(from start: double2, to end: double2, by distance: Double) -> double2 {
        return mix(start, end, t:distance)
    }
}

/// ...
extension double3: Interpolation {
    
    /// ...
    public typealias InterpolationDistance = Double
    
    /// ...
    public static func interpolate(from start: double3, to end: double3, by distance: Double) -> double3 {
        return mix(start, end, t:distance)
    }
}

/// ...
extension double4: Interpolation {
    
    /// ...
    public typealias InterpolationDistance = Double
    
    /// ...
    public static func interpolate(from start: double4, to end: double4, by distance: Double) -> double4 {
        return mix(start, end, t:distance)
    }
}

/// ...
extension float2: Interpolation {
    
    /// ...
    public typealias InterpolationDistance = Float
    
    /// ...
    public static func interpolate(from start: float2, to end: float2, by distance: Float) -> float2 {
        return mix(start, end, t:distance)
    }
}

/// ...
extension float3: Interpolation {
    
    /// ...
    public typealias InterpolationDistance = Float
    
    /// ...
    public static func interpolate(from start: float3, to end: float3, by distance: Float) -> float3 {
        return mix(start, end, t:distance)
    }
}

/// ...
extension float4: Interpolation {
    
    /// ...
    public typealias InterpolationDistance = Float
    
    /// ...
    public static func interpolate(from start: float4, to end: float4, by distance: Float) -> float4 {
        return mix(start, end, t:distance)
    }
}
