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

/// ...
public struct Circle {
    
    /// ...
    public var x: Float
    
    /// ...
    public var y: Float

    /// ...
    public var radius: Float
}

/// ...
extension Circle: CustomStringConvertible {
    
    /// ...
    public var description: String {
        return "Circle(\(x), \(y), \(radius))"
    }
}

/// ...
extension Circle: Interpolation {
    
    /// ...
    public typealias InterpolationDistance = Float
    
    /// ...
    public static func interpolate(from start: Circle, to end: Circle, by distance: Float) -> Circle {
        let x = start.x.interpolated(to:end.x, by:distance)
        let y = start.y.interpolated(to:end.y, by:distance)
        let radius = start.radius.interpolated(to:end.radius, by:distance)
        return Circle(x:x, y:y, radius:radius)
    }
}

var circle = Circle(x:0.0, y:0.0, radius:10.0)
var target = Circle(x:10.0, y:10.0, radius:20.0)
//var newCircle = circle.interpolated(to:target, by:0.5, using:.cubic)
var newCircle = circle.interpolated(to:target, by:0.5)
circle.interpolate(to:target, by:0.5, using:.easeInSine)

