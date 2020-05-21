//
//  Array.swift
//  Cubilose
//
//  Created by HonQi on 2020/5/16.
//  Copyright © 2020 HonQi. All rights reserved.
//

import Foundation

extension Array: CubiloseProtocol {}
public extension Cubilose where T == Array<Any> {
    func partition(n: Int, step: Int? = nil, pad: [T.Element]? = nil) -> Array<Array<T.Element>>{
        if n > this.count { return [this] }
        
        var result = Array<Array<T.Element>>()
        let step = max(1, step ?? n)
        let num = max(0, n)
        
        for i in stride(from: 0, to: this.count, by: step) {
            var end = i + num
            if end > this.count { end = this.count }
            result.append(Array(this[i..<end]))
            
            if end != i + n { break }
        }
        
        if let padding = pad {
            let remaining = this.count % n
            result[result.count-1].append(contentsOf: padding[0..<remaining] )
        }

        return result
    }

    func forEach(body: (T.Element, Int) -> Void) {
        for (index, item) in this.enumerated() {
            body(item, index)
        }
    }
}
