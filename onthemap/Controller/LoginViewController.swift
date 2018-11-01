//
//  LoginViewController.swift
//  onthemap
//
//  Created by sudo on 10/23/18.
//  Copyright © 2018 sudo. All rights reserved.
//

import UIKit

class LoginViewController: HomeBaseController {

    // MARK: Properties
    
  @IBOutlet weak var _Email: UITextField!
  @IBOutlet weak var _Password: UITextField!
  @IBOutlet weak var _LoginButton: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  @IBAction func goLogin(_ sender: Any) {
    guard let myEmail = _Email.text, !myEmail.isEmpty else {
      showAlert(nil, message: "Empty Email! please resolve this")
      return
    }
    guard let myPassword = _Password.text, !myPassword.isEmpty else {
      showAlert(nil, message: "Empty Password! please resolve this")
      return
    }
  }


}
