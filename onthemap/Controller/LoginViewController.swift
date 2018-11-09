//
//  LoginViewController.swift
//  onthemap
//
//  Created by sudo on 10/23/18.
//  Copyright © 2018 sudo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var _Email: UITextField!
    @IBOutlet weak var _Password: UITextField!
    @IBOutlet weak var _LoginButton: UIButton!
    @IBOutlet weak var surpriseText: UILabel!
    
    var session: URLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _Email.delegate = self
        _Password.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goLogin(_ sender: Any) {
        UdacityParseClient.sharedInstance().Login(userName: _Email.text!, password: _Password.text!)
        { (success, error) in
            performUIUpdatesOnMain {
                if success! {
                    self.loginComplete()
                } else {
                    if self._Email.text?.isEmpty == true {
                        self.showAlert(problem: "Shoot", solution: "Email is empty")
                    }
                    if  self._Password.text?.isEmpty  == true {
                        self.showAlert(problem: "Shoot", solution: "Password is empty")
                    }
                }
            }
        }
}
    func loginComplete() {
        surpriseText.text = ""
        let controller = storyboard!.instantiateViewController(withIdentifier: "PinMapController") as! UITabBarController
        present(controller, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    public func showAlert(problem: String, solution: String)  {
        let alert = UIAlertController(title: problem, message: solution, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
