//
//  RealmViewController.swift
//  SwiftStudy
//
//  Created by KLounge-HG on 2017. 4. 6..
//  Copyright © 2017년 Jell PD. All rights reserved.
//

import UIKit

class RealmViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }

}
