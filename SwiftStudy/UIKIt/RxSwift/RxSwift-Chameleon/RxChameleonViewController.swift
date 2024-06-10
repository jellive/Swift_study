//
//  RxChameleonViewController.swift
//  SwiftStudy
//
//  Created by YooHG on 7/8/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import ChameleonFramework
import UIKit
import RxSwift
import RxCocoa

class RXChameleonViewController: UIViewController {
    var circleView: UIView!
    var circleViewModel: CircleViewModel!
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        circleView = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 100.0, height: 100.0)))
        circleView.layer.cornerRadius = circleView.frame.width / 2.0
        circleView.center = view.center
        circleView.backgroundColor = .green
        view.addSubview(circleView)
        
        circleViewModel = CircleViewModel()
        circleView
            .rx.observe(CGPoint.self, "center")
            .bind(to: circleViewModel.centerVariable)
            .disposed(by: disposeBag) // CircleView의 중앙 지점을 centerObservable에 묶는다.(bind)
        
        // ViewModel의 새로운 색을 얻기 위해 backgroundObservable을 구독한다.
        circleViewModel.backgroundColorObservable
            .subscribe(onNext: {[weak self] backgroundColor in
                UIView.animate(withDuration: 0.1, animations: {
                    self?.circleView.backgroundColor = backgroundColor
                    // 주어진 배경색의 보색을 구한다.
                    let viewBackgroundColor = UIColor(complementaryFlatColorOf: backgroundColor)
                    if viewBackgroundColor != backgroundColor {
                        self?.view.backgroundColor = viewBackgroundColor
                    }
                })
            })
            .disposed(by: disposeBag)
        
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved(_:)))
        circleView.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    @objc func circleMoved(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: view)
        UIView.animate(withDuration: 0.1, animations: {
            self.circleView.center = location
        })
    }
}
