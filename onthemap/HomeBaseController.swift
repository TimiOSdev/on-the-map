//
//  ViewController.swift
//  onthemap
//
//  Created by sudo on 10/22/18.
//  Copyright © 2018 sudo. All rights reserved.
//

import UIKit

class HomeBaseController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func showAlert(_ title:String?, message:String){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Yup", style: .cancel){ action in
      alertController.dismiss(animated: true, completion: nil)
    }
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
  
  
}
