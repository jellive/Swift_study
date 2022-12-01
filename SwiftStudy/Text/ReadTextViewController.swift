//
//  ReadTextViewController.swift
//  SwiftStudy
//
//  Created by HGYoo-visualsyn on 2022/12/01.
//  Copyright © 2022 Jell. All rights reserved.
//

import Foundation
import UIKit

class ReadTextViewController: UIViewController {
    
    @IBOutlet private var extrinsicLabel: UILabel!
    @IBOutlet private var intrinsicLabel: UILabel!
    @IBOutlet private var fixedLabel: UILabel!
    @IBOutlet private var fixed2Label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func readBtnClicked(_ sender: Any) {
        let str = readTxtFile(textFile: "00000000_cam")
        if let str = str {
            let pyModel = self.createPyModel(str: str)
            extrinsicLabel.text = .init(describing: pyModel.extrinsic)
            intrinsicLabel.text = .init(describing: pyModel.intricsic)
            fixedLabel.text = .init(describing: pyModel.fixed)
            fixed2Label.text = .init(describing: pyModel.fixed2)
            print("pyModel: \(String(describing: pyModel))")
        }
    }
    
    func readTxtFile(textFile: String) -> String? {
        if let path = Bundle.main.path(forResource: textFile, ofType: "txt"){
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                return data
            } catch {
                print(error)
                return nil
            }
        } else {
            return nil
        }
    }
    
    func createPyModel(str: String) -> PyModel {
        var pyModel = PyModel()
        let strArr = str.components(separatedBy: .newlines)
        var cursorKey: String = ""
        
        for str in strArr {
            print("str: \(str)")
            switch str {
            case "":
                continue
            case "extrinsic":
                cursorKey = str
            case "intrinsic":
                cursorKey = str
            default:
                let seperatedArr: [String] = str.split(separator: " ").map { String($0) }
                let intArr: [Float] = seperatedArr.map { Float($0)! }
                if intArr.count < 3 {
                    cursorKey = "fixed"
                }
                if cursorKey == "extrinsic" {
                    pyModel.extrinsic.append(intArr)
                } else if cursorKey == "intrinsic" {
                    pyModel.intricsic.append(intArr)
                } else if cursorKey == "fixed" {
                    pyModel.fixed = intArr[0]
                    pyModel.fixed2 = intArr[1]
                }
                
            }
        }
        
        return pyModel
        
    }
}
    

/**
 @comment PyModel은 제 마음대로 정한거에요. 편하신대로 바꾸심 됩니당
 fixed와 fixed2는 이름을 따로 안 주셔서 임시로 정했습니다. 편하신대로 바꾸심 됩니당
 */
struct PyModel {
    var extrinsic: [[Float]] = [[Float]]()
    var intricsic: [[Float]] = [[Float]]()
    var fixed: Float = 0
    var fixed2: Float = 0
}
