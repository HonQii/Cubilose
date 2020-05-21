//
//  CGPoint.swift
//  Cubilose
//
//  Created by HonQi on 2020/5/21.
//  Copyright © 2020 HonQi. All rights reserved.
//

#if os(iOS) || os(tvOS)


import UIKit

extension CGPoint: CubiloseProtocol {}

public extension Cubilose where T == CGPoint {
    static func make(angle: CGFloat) -> CGPoint {
        return CGPoint(x: cos(angle), y: sin(angle))
    }
    
    var angle: CGFloat {
        return atan2(this.y, this.x)
    }
    
    var length: CGFloat {
        return sqrt(this.x * this.x + this.y * this.y)
    }
    
    /// scale CGPoint to 0 ~ 1.0
    var normalized: CGPoint {
        let len = self.length
        return len > 0 ? divide(len) : .zero
    }
    
    mutating func offset(dx: CGFloat, dy: CGFloat) -> CGPoint {
        this.x += dx
        this.y += dy
        return this
    }
    
    func distance(to other: CGPoint) -> CGFloat {
        return minus(other).cb.length
    }
    
    func add(_ other: CGPoint) -> CGPoint {
        return CGPoint(x: this.x + other.x, y: this.y + other.y)
    }
    
    mutating func addTo(other: CGPoint) {
        this = add(other)
    }
    
    func minus(_ other: CGPoint) -> CGPoint {
        return CGPoint(x: this.x - other.x, y: this.y - other.y)
    }
    
    mutating func minusTo(_ other: CGPoint) {
        this = minus(other)
    }
    
    func multiply(_ scalar: CGFloat) -> CGPoint {
        return CGPoint(x: this.x * scalar, y: this.y * scalar)
    }
    
    mutating func multiplyTo(_ scalar: CGFloat) {
        this = multiply(scalar)
    }
    
    func multiply(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: this.x * point.x, y: this.y * point.y)
    }
    
    mutating func multiplyTo(_ point: CGPoint) {
        this = multiply(point)
    }
    
    func divide(_ scalar: CGFloat) -> CGPoint {
        return CGPoint(x: this.x / scalar, y: this.y / scalar)
    }
    
    mutating func divideTo(_ scalar: CGFloat) {
        this = divide(scalar)
    }
    
    func divide(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: this.x / point.x, y: this.y / point.y)
    }
    
    mutating func divideTo(_ point: CGPoint) {
        this = divide(point)
    }

    /// linear interpolation between two CGPoint values;  this + (point - this) * step
    func linearInterpolation(to point: CGPoint, step: CGFloat) -> CGPoint {
        return add(point.cb.minus(this).cb.multiply(step))
    }
}


public extension CGPoint {
    init(angle: CGFloat) {
        self.init(x: cos(angle), y: sin(angle))
    }
}
#endif
