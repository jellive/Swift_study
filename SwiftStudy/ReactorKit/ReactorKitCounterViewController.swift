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
        
    }
    
}
