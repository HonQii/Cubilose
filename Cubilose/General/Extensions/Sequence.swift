//
//  Sequence.swift
//  Cubilose
//
//  Created by HonQi on 2020/5/16.
//  Copyright © 2020 HonQi. All rights reserved.
//

import Foundation

public extension Cubilose where T: Sequence {
    func any(predicate: (T.Element) -> Bool) -> Bool {
        for value in this where predicate(value) { return true }
        return false
    }
}

public extension Cubilose where T: Sequence, T.Iterator.Element: Hashable {
    func unique() -> [T.Iterator.Element] {
        var seen: Set<T.Iterator.Element> = []
        return this.filter{ seen.insert($0).inserted }
    }
}


public extension Cubilose where T: Sequence {
    func unique(by compareClosure: @escaping (T.Element, T.Element) -> Bool) -> [T.Element] {
        var seen = [T.Element]()
        this.forEach { outer in
            if !seen.contains(where: { (inner) -> Bool in return compareClosure(outer, inner) }) {
                seen.append(outer)
            }
        }
        return seen
    }
}


/// Iterates through enum elements
/// http://stackoverflow.com/questions/24007461/how-to-enumerate-an-enum-with-string-type
/// Starting with Swift 4.2 (with Xcode 10), just add protocol conformance to CaseIterable to benefit from allCases
#if !swift(>=4.2)
public protocol CaseIterable {
    associatedtype AllCases: Collection where AllCases.Element == Self
    static var allCases: AllCases { get }
}
extension CaseIterable where Self: Hashable {
    static var allCases: [Self] {
        return [Self](AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            var first: Self?
            return AnyIterator {
                let current = withUnsafeBytes(of: &raw) { $0.load(as: Self.self) }
                if raw == 0 {
                    first = current
                } else if current == first {
                    return nil
                }
                raw += 1
                return current
            }
        })
    }
}
#endif



public struct ConditionSequence <S: Sequence> : Sequence {
    public typealias Element = S.Element
    public typealias Iterator = AnyIterator
    
    private let subSequece: S
    private let condition: (Self.Element?) -> Bool
    
    public init(base: S, condition: @escaping (Self.Element?) -> Bool) {
        subSequece = base
        self.condition = condition
    }
    
    public func makeIterator() -> AnyIterator<Element> {
        var generator = subSequece.makeIterator()
        var isEndIterator = false
        
        return AnyIterator<Element> {
            let next = generator.next()
            if !isEndIterator { isEndIterator = !self.condition(next) }
            if isEndIterator { return nil }
            return next
        }
    }
}
