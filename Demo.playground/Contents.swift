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
// Demo.playground
// 06/17/2016
// -----------------------------------------------------------------------------

import AlchemyInterpolation
import CoreGraphics

/// ...
public struct Circle {
    
    /// ...
    public var point: CGPoint
    
    /// ...
    public var radius: CGFloat
}

/// ...
extension Circle: CustomStringConvertible {
    
    /// ...
    public var description: String {
        return "Circle(\(point.x), \(point.y), \(radius))"
    }
}

/// ...
extension Circle: Interpolation {
    
    /// ...
    public typealias InterpolationDistance = CGFloat
    
    /// ...
    public static func interpolate(from start: Circle, to end: Circle, by distance: CGFloat) -> Circle {
        let point = start.point.interpolated(to:end.point, by:distance)
        let radius = start.radius.interpolated(to:end.radius, by:distance)
        return Circle(point:point, radius:radius)
    }
}

var startCircle = Circle(point:CGPoint(x:0.0, y:0.0), radius:10.0)
var finalCircle = Circle(point:CGPoint(x:10.0, y:10.0), radius:20.0)
var currentCircle = startCircle.interpolated(to:finalCircle, by:0.25, using:.easeInOutCircular)

