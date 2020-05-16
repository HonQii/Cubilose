//
//  FuncTools.swift
//  Cubilose
//
//  Created by HonQi on 2020/5/16.
//  Copyright © 2020 HonQi. All rights reserved.
//

import Foundation

public func after<P, R>(times: Int, function: @escaping (P...) -> R) -> ((P...) -> R?) {
    typealias Function = ([P]) -> R
    var remain = times
    
    return { (params: P...) -> R? in
        let adaptedFunction = unsafeBitCast(function, to: Function.self)
        defer { remain -= 1 }
        
        if remain <= 0 {
            return adaptedFunction(params)
        }
        return nil
    }
}

public func after<T>(times: Int, function:@escaping () -> T) -> (() -> T?) {
    func callAfter(args: Any?...) -> T {
        return function()
    }
    let f = after(times: times, function: callAfter)
    return { f([nil]) }
}





public func once<P, R>(function: @escaping (P...) -> R) -> ((P...) -> R) {
    typealias Function = ([P]) -> R
    var returnValue: R? = nil
    
    return { (params: P...) -> R in
        if let r = returnValue { return r }
        let adaptedFunction = unsafeBitCast(function, to: Function.self)
        returnValue = adaptedFunction(params)
        return returnValue!
    }
}

public func once<T>(function: @escaping () -> T) -> (() -> T) {
    let f = once{ (params: Any?...) -> T in
        return function()
    }
    return { f([nil]) }
}




public func partial<P, R>(function: @escaping (P...) -> R, _ parameters: P...) -> ((P...) -> R) {
    typealias Function = ([P]) -> R
    return { (params: P...) -> R in
        let adaptedFunction = unsafeBitCast(function, to: Function.self)
        return adaptedFunction(parameters+params)
    }
}

public func bind<P, R>(function:@escaping (P...) -> R, _ parameters: P...) -> (() -> R) {
    typealias Function = ([P]) -> R
    return { () -> R in
        let adaptedFunction = unsafeBitCast(function, to: Function.self)
        return adaptedFunction(parameters)
    }
}




public func cached<P: Hashable, R>(function:@escaping (P) -> R) -> ((P) -> R) {
    var cache = [P:R]()
    
    return { (param: P) -> R in
        if let cachedResult = cache[param] {
            return cachedResult
        } else {
            let value = function(param)
            cache[param] = value
            return value
        }
    }
}


public func cached<P: Hashable, R>(function:@escaping (P...) -> R, hash:@escaping ((P...)->P)) -> ((P...) -> R) {
    typealias Function = ([P]) -> R
    typealias Hash = ([P]) -> P
    
    var cache = [P:R]()
    return { (params: P...) -> R in
        let adaptedFunction = unsafeBitCast(function, to: Function.self)
        let adaptedHash = unsafeBitCast(hash, to: Hash.self)
        
        let key = adaptedHash(params)
        if let cachedResult = cache[key] {
            return cachedResult
        } else {
            let value = adaptedFunction(params)
            cache[key] = value
            return value
        }
    }
}



public func regex(pattern: String, ignoreCase: Bool = false) -> NSRegularExpression? {
    var options = NSRegularExpression.Options.dotMatchesLineSeparators.rawValue
    
    if ignoreCase {
        options = NSRegularExpression.Options.caseInsensitive.rawValue | options
    }
    
    return try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: options))
}
