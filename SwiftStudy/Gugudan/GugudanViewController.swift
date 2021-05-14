//
//  GugudanViewController.swift
//  SwiftStudy
//
//  Created by Jell PD on 2017. 3. 19..
//  Copyright © 2017년 Jell PD. All rights reserved.
//

import UIKit

class GugudanViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var gugudanString : String = "http://www.jell.kr/json/gugudan/"
    var gugudanRequest : URLRequest?
    var gugudanArray : NSMutableArray! = NSMutableArray()
    @IBOutlet weak var gugudanTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // make url.
        gugudanString = "http://www.jell.kr/json/gugudan/".appending(textField.text!);
        
        guard let gugudanUrl = NSURL.init(string: gugudanString) else {
            print("Error: cannot create URL")
            return false;
        }
        
        gugudanRequest = URLRequest.init(url: gugudanUrl as URL);
        
        // make session.
        let config : URLSessionConfiguration! = URLSessionConfiguration.default;
        let session : URLSession = URLSession.init(configuration: config);
        
        session.dataTask(with: (gugudanRequest as URLRequest?)!) {
            data, response, error in
            
            guard let data = data, error == nil else {return}
            
            if let response = response {
                print(response)
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                    self.gugudanArray = NSMutableArray()
                    for eachGugu in json!
                    {
                        print(eachGugu.key)
                        print(eachGugu.value)
                        let gugudanString = eachGugu.key.appending(String.init(format: " = %@", eachGugu.value as! CVarArg))
                        self.gugudanArray.add(gugudanString)
                    }
                    DispatchQueue.main.async {
                        self.gugudanTableView.reloadData()
                    }
                    
                }
                catch
                {
                    print("Error desializing JSON: \(error)")
                }
            }
            if let error = error {
                print(error)
            }
        }.resume()
        
            return true;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gugudanArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "gugudan_tableview_cell")
        let cellLabel : UILabel! = cell.viewWithTag(1) as? UILabel
        cellLabel.text = gugudanArray.object(at: indexPath.row) as? String
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
