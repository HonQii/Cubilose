//
//  Cubilose.swift
//  Cubilose
//
//  Created by HonQi on 2020/5/16.
//  Copyright © 2020 HonQi. All rights reserved.
//

import Foundation

public protocol CubiloseProtocol {
    associatedtype T
    var cb: T { get }
    static var cb: T.Type { get }
}

public extension CubiloseProtocol {
    var cb: Cubilose<Self> { return Cubilose(self) }
    static var cb: Cubilose<Self>.Type { return Cubilose.self }
}


public struct Cubilose<T> {
    public let this: T
    public init(_ val: T) { this = val }
}
