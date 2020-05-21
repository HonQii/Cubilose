//
//  CGSize.swift
//  Cubilose
//
//  Created by HonQi on 2020/5/21.
//  Copyright © 2020 HonQi. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit

extension CGSize: CubiloseProtocol {}

public extension Cubilose where T == CGSize {
    func insert(_ insets: UIEdgeInsets) -> CGSize {
        return CGSize(width: this.width + insets.left + insets.right, height: this.height + insets.top + insets.bottom)
    }
    
    mutating func insertTo(_ insets: UIEdgeInsets) {
        this = insert(insets)
    }
}

#endif
