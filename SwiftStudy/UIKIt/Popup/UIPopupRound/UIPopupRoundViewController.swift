//
//  UIPopupRoundViewController.swift
//  SwiftStudy
//
//  Created by dongwoo on 9/2/21.
//  Copyright © 2021 Jell PD. All rights reserved.
//

import UIKit

class UIPopupRoundViewController: UIViewController {
    @IBOutlet weak var infoView: UIView!
    @IBOutlet var guideLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("popup!")

        let containerView = UIView()
        containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        containerView.layer.shadowOffset = CGSize(width: 1, height: 4)
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowOpacity = 1

        containerView.layer.backgroundColor = CGColor.init(red: 1, green: 1, blue: 1, alpha: 1)

        
        containerView.addSubview(infoView)
        containerView.layer.cornerRadius = 25
        containerView.clipsToBounds = true

        infoView.layer.cornerRadius = 25
        infoView.clipsToBounds = true
        view.addSubview(containerView)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 315).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 367).isActive = true

    }
    
//    private let popUpView = UIView()
//       private let dismissButton = UIButton()
//
//       override func viewDidLoad() {
//           super.viewDidLoad()
//
//           // SetUp View
//           view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
//
//           // SetUp PopUpView
//           popUpView.backgroundColor = UIColor.yellow
//           view.addSubview(popUpView)
//
//           // SetUpDismiss Button
//           dismissButton.setTitleColor(UIColor.blue, for: .normal)
//           dismissButton.setTitle("Dismiss", for: .normal)
//           dismissButton.addTarget(self, action: #selector(didTapDismissButton(_:)), for: .touchUpInside)
//           popUpView.addSubview(dismissButton)
//
//           // PopUpView AutoLayout
//           popUpView.translatesAutoresizingMaskIntoConstraints = false
//           popUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//           popUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//           popUpView.widthAnchor.constraint(equalToConstant: 200).isActive = true
//           popUpView.heightAnchor.constraint(equalToConstant: 200).isActive = true
//
//           // DismissButton AutoLayout
//           dismissButton.translatesAutoresizingMaskIntoConstraints = false
//           dismissButton.bottomAnchor.constraint(equalTo: popUpView.bottomAnchor).isActive = true
//           dismissButton.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor).isActive = true
//           dismissButton.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor).isActive = true
//           dismissButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//       }
//
//       @objc func didTapDismissButton(_ sender: UIButton) {
//           dismiss(animated: true, completion: nil)
//       }
}
