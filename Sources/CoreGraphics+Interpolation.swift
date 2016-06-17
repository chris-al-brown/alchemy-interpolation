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
// CoreGraphics+Interpolation.swift
// 06/17/2016
// -----------------------------------------------------------------------------

import Foundation
import CoreGraphics

/// ...
extension CGFloat: Interpolation {
    
    /// ...
    public typealias InterpolationDistance = CGFloat
    
    /// ...
    public static func interpolate(from start: CGFloat, to end: CGFloat, by distance: CGFloat) -> CGFloat {
        return distance * end + (1.0 - distance) * start
    }
}

/// ...
extension CGFloat: InterpolationFloatingPoint {
    
    /// ...
    public static func easeInSine(by distance: CGFloat) -> CGFloat {
        return sin((distance - 1.0) * (.pi / 2.0)) + 1.0
    }
    
    /// ...
    public static func easeInCircular(by distance: CGFloat) -> CGFloat {
        return 1.0 - sqrt(1.0 - (distance * distance))
    }
    
    /// ...
    public static func easeInExponential(by distance: CGFloat) -> CGFloat {
        return distance == 0.0 ? distance : pow(2, 10 * (distance - 1))
    }
}

/// ...
extension CGPoint: Interpolation {
    
    /// ...
    public typealias InterpolationDistance = CGFloat
    
    /// ...
    public static func interpolate(from start: CGPoint, to end: CGPoint, by distance: CGFloat) -> CGPoint {
        let x = start.x.interpolated(to:end.x, by:distance)
        let y = start.y.interpolated(to:end.y, by:distance)
        return CGPoint(x:x, y:y)
    }
}

/// ...
extension CGRect: Interpolation {
    
    /// ...
    public typealias InterpolationDistance = CGFloat
    
    /// ...
    public static func interpolate(from start: CGRect, to end: CGRect, by distance: CGFloat) -> CGRect {
        let origin = start.origin.interpolated(to:end.origin, by:distance)
        let size = start.size.interpolated(to:end.size, by:distance)
        return CGRect(origin:origin, size:size)
    }
}

/// ...
extension CGSize: Interpolation {
    
    /// ...
    public typealias InterpolationDistance = CGFloat
    
    /// ...
    public static func interpolate(from start: CGSize, to end: CGSize, by distance: CGFloat) -> CGSize {
        let width = start.width.interpolated(to:end.width, by:distance)
        let height = start.height.interpolated(to:end.height, by:distance)
        return CGSize(width:width, height:height)
    }
}

/// ...
extension CGVector: Interpolation {
    
    /// ...
    public typealias InterpolationDistance = CGFloat
    
    /// ...
    public static func interpolate(from start: CGVector, to end: CGVector, by distance: CGFloat) -> CGVector {
        let dx = start.dx.interpolated(to:end.dx, by:distance)
        let dy = start.dy.interpolated(to:end.dy, by:distance)
        return CGVector(dx:dx, dy:dy)
    }
}


