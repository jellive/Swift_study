//
//  DrawingViewController.swift
//  SwiftStudy
//
//  Created by KLounge-HG on 2017. 7. 4..
//  Copyright © 2017년 Jell PD. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {
    @IBOutlet weak var penImageView: UIImageView!
    var penImage: UIImage! = nil
    var touchArr: NSMutableArray! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        touchArr = NSMutableArray.init()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesMoved")
        guard let touch = touches.first else { return }
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        penImage?.draw(in: view.bounds)
        
        for touch in touchArr {
            drawStroke(context, touch: touch as! UITouch)
        }
        
        touchArr.add(touch)
        
        penImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        penImageView.image = penImage
    }
    
    fileprivate func drawStroke(_ context: CGContext?, touch: UITouch) {
        let previousLocation = touch.previousLocation(in: view)
        let location = touch.location(in: view)
        
        // Configure line
        context?.setStrokeColor(UIColor.red.cgColor)// 색
        context?.setLineWidth(5) // 너비
        context?.setLineCap(.round)
        
        
        // Set up the points
        context?.move(to: CGPoint(x: previousLocation.x, y: previousLocation.y))
        context?.addLine(to: CGPoint(x: location.x, y: location.y))
        // Draw the stroke
        context?.strokePath()
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        penImageView.image = penImage
    }

    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
