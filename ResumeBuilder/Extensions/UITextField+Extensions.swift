//
//  UITextField+Extensions.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/12/22.
//

import UIKit

extension UITextField {
    func addSpaceBeforeText() {
        let leftView = UIView(frame: CGRect(x: 10, y: 0, width: 7, height: bounds.height))
        leftView.backgroundColor = .clear
        self.leftView = leftView
        self.leftViewMode = .always
        self.contentVerticalAlignment = .center
    }
}
