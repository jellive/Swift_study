//
//  CounterViewController.swift
//  SwiftStudy
//
//  Created by YooHG on 2021/05/14.
//  Copyright © 2021 Jell PD. All rights reserved.
//

import ReactorKit
import RxSwift
import RxCocoa

final class ReactorKitCounterViewController: UIViewController, StoryboardView {
    
    @IBOutlet var increaseButton: UIButton!
    @IBOutlet var decreaseButton: UIButton!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: ReactorKitCounterViewReactor) {
        // Action
        increaseButton.rx.tap
            .map {Reactor.Action.increase}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        decreaseButton.rx.tap
            .map {Reactor.Action.decrease}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map {$0.value}
            .distinctUntilChanged()
            .map { "\($0)"}
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
        reactor.state.map {$0.isLoading}
            .distinctUntilChanged()
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
}
