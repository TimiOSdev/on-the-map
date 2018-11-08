//
//  LoginViewController.swift
//  onthemap
//
//  Created by sudo on 10/23/18.
//  Copyright © 2018 sudo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var _Email: UITextField!
    @IBOutlet weak var _Password: UITextField!
    @IBOutlet weak var _LoginButton: UIButton!
    @IBOutlet weak var surpriseText: UILabel!
    
    var session: URLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goLogin(_ sender: Any) {
        UdacityParseClient.sharedInstance().Login(userName: _Email.text!, password: _Password.text!)
        { (success, error) in
            performUIUpdatesOnMain {
                if success! {
                    self.loginComplete()
                } else {
                    self.displayError(error)
                }
            }
        }
    
    
}
    func loginComplete() {
        surpriseText.text = ""
        let controller = storyboard!.instantiateViewController(withIdentifier: "PinMapController") as! UITabBarController
        present(controller, animated: true, completion: nil)
    }
    
    
    func displayError(_ errorString: String?) {
        if let errorString = errorString {
            surpriseText.text = "Credentials failed"
        }
    }

}
