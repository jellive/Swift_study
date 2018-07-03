//
//  RealmViewController.swift
//  SwiftStudy
//
//  Created by KLounge-HG on 2017. 4. 6..
//  Copyright © 2017년 Jell PD. All rights reserved.
//

import UIKit
import RealmSwift

class RealmViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var numberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberTextField.delegate = self
        
        let realm = try! Realm()
        var realmNumber = realm.objects(RealmNumber.self).filter("numberIndex < 2").first
        if(realmNumber == nil) { // 왜 nil로 안들어가지?
            realmNumber = RealmNumber()
            realmNumber?.number = 0
            realmNumber?.numberIndex = 1
            realmNumber?.date = NSDate()
            try! realm.write {
                realm.add(realmNumber!)
            }
        }
        print(realmNumber?.number as Any)
        numberTextField.text = String.init(format: "%d", (realmNumber?.number)!)
        
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

    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let realm = try! Realm()
        let realmNumber = realm.objects(RealmNumber.self).filter("numberIndex < 2").first
        
        realmNumber?.number = Int(textField.text!)!
        
        try! realm.write {
            realm.add(realmNumber!, update: true)
        }
        
    }
}
