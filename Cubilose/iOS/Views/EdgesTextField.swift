//
//  EdgesTextField.swift
//  Cubilose
//
//  Created by HonQi on 2020/5/21.
//  Copyright © 2020 HonQi. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit

open class EdgesTextField: UITextField {
    open var textEdgeInsets: UIEdgeInsets = .zero
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textEdgeInsets)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textEdgeInsets)
    }

}

#endif
