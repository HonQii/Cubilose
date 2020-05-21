//
//  EdgesLabel.swift
//  Cubilose
//
//  Created by HonQi on 2020/5/21.
//  Copyright © 2020 HonQi. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit

open class EdgesLabel: UILabel {
    open var textEdgeInsets: UIEdgeInsets = .zero

    open override func drawText(in rect: CGRect) {
        super.drawText(in: bounds.inset(by: textEdgeInsets))
    }
    
    open override var intrinsicContentSize: CGSize {
        return super.intrinsicContentSize.cb.insert(textEdgeInsets)
    }
}

#endif


