//
//  CustomRectView.swift
//  SwiftStudy
//
//  Created by Jell PD on 2017. 4. 26..
//  Copyright © 2017년 Jell PD. All rights reserved.
//

import UIKit

@IBDesignable

class CustomRectView: UIView {
    @IBInspectable var integer: Int = 0
    @IBInspectable var float: CGFloat = 0
    @IBInspectable var double: Double = 0
    @IBInspectable var point: CGPoint = CGPoint.zero
    @IBInspectable var size: CGSize = CGSize.zero
    @IBInspectable var customFrame: CGRect = CGRect.zero
    @IBInspectable var color: UIColor = UIColor.clear
    @IBInspectable var string: String = "Jell"
    @IBInspectable var bool: Bool = false
    
    @IBInspectable var lineWidth: Int = 100
    @IBInspectable var fillColor: UIColor = UIColor.blue

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let myFrame = self.bounds
        context!.setLineWidth(CGFloat(lineWidth))
        myFrame.insetBy(dx: 5, dy: 5)
        fillColor.set()
        UIRectFrame(myFrame)
    }
}
