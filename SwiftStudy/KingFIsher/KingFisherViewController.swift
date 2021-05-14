//
//  KingFisherViewController.swift
//  SwiftStudy
//
//  Created by YooHG on 2021/04/01.
//  Copyright © 2021 Jell PD. All rights reserved.
//

import UIKit
import Kingfisher

class KingFisherViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        guard let url = URL(string: "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png") else {return}
        imageView.kf.setImage(with: url)
    }
    
}
