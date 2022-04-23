//
//  UIViewController+Extension.swift
//  Upbit-Clone
//
//  Created by 김민창 on 2022/04/23.
//

import UIKit

extension UIViewController {
    static var className: String {
        return String(describing: self)
    }
}
