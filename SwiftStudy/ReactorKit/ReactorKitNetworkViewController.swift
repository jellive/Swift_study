//
//  ReactorKitNetworkViewController.swift
//  SwiftStudy
//
//  Created by HGYoo-visualsyn on 2022/11/17.
//  Copyright © 2022 Jell PD. All rights reserved.
//

import ReactorKit
import RxSwift
import RxCocoa
import UIKit

final class ReactorKitNetworkViewController: UIViewController, StoryboardView {

    @IBOutlet weak var listlabel: UILabel!
    @IBOutlet weak var getBtn: UIButton!

    var disposeBag = DisposeBag()


    func bind(reactor: ReactorKitNetworkReactor) {
        getBtn.rx.tap
            .map { ReactorKitNetworkReactor.Action.get }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map {$0.resource}
            .distinctUntilChanged(==)
            .map { "\($0)" }
            .bind(to: listlabel.rx.text)
            .disposed(by: disposeBag)
    }

}
