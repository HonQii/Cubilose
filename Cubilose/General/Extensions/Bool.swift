//
//  Bool.swift
//  Cubilose
//
//  Created by HonQi on 2020/5/21.
//  Copyright © 2020 HonQi. All rights reserved.
//

import Foundation

extension Bool: CubiloseProtocol {}

public extension Cubilose where T == Bool {
    mutating func toggle() -> Bool {
        this = !this
        return this
    }
}


