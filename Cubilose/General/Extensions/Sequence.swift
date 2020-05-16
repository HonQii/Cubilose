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






public struct ConditionSequence <S: Sequence> : Sequence {
    public struct Iterator<I: IteratorProtocol>: IteratorProtocol {
        public typealias Element = I.Element
        
        private var subIterator: I
        private let condition: (I.Element?) -> Bool
        
        init(iter: I, condition:@escaping (Self.Element?) -> Bool) {
            self.subIterator = iter
            self.condition = condition
        }
        
        public mutating func next() -> I.Element? {
            let next = subIterator.next()
            if condition(next) {
                return next
            } else {
                return nil
            }
        }
    }

    
    public typealias Element = S.Element
    
    private let subSequece: S
    private let condition: (Self.Element?) -> Bool
    
    public init(base: S, condition: @escaping (Self.Element?) -> Bool) {
        subSequece = base
        self.condition = condition
    }
    
    public func makeIterator() -> Self.Iterator<S.Iterator> {
        return ConditionSequence.Iterator(iter: subSequece.makeIterator(), condition: condition)
    }

    public var underestimatedCount: Int { return 0 }

    public func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Self.Element>) throws -> R) rethrows -> R? {
        return nil
    }
}
