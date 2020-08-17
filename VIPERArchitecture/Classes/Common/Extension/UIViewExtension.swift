//
//  UIViewExtension.swift
//  CaseProject
//
//  Created by Arda Onat on 15.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import UIKit

extension UIView {
    
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
}
