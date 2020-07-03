//
//  CombineController.swift
//  SwiftStudy
//
//  Created by YooHG on 7/3/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import UIKit
import SwiftUI

//protocol CombineController {
//    func sinkTest() -> Int
//}

struct CombineViewController: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
    
    @Binding var text: String
    
    func sinkTest() -> Int { return 1 }
    
    func makeCoordinator() -> Coordinator {
        CombineCoordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    
    class CombineCoordinator: NSObject {
        var parent: CombineViewController
        
        init(_ viewController: CombineViewController) {
            self.parent = viewController
        }
    }
}

//extension CombineController: UIViewControllerRepresentable {
//    func sinkText() -> Int {
//        return 1
//    }
//}
