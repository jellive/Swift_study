//
//  UIView.swift
//  SwiftStudy
//
//  Created by KLounge-HG on 2017. 7. 6..
//  Copyright © 2017년 Jell PD. All rights reserved.
//

import UIKit

extension UIView {
    
    func categoryTest() -> UIView {
        let view : UIView! = UIView.init(frame: CGRect.init(x: 50, y: 50, width: 200, height: 200))
        view.layer.cornerRadius = 3
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 1
        return view
    }
}
