//
//  TableVC.swift
//  onthemap
//
//  Created by Tim McEwan on 11/2/18.
//  Copyright © 2018 sudo. All rights reserved.
//

import UIKit

class TableVC: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        

        var studentLocations = StudentDataFarm.sharedInstance.arrayOfStudentLocations
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return StudentDataFarm.sharedInstance.arrayOfStudentLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentLocations = StudentDataFarm.sharedInstance.arrayOfStudentLocations
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        print("DATE -\(studentLocations[indexPath.row].createdAt ?? "NO DATE")")
        cell.textLabel?.text = "\(studentLocations[indexPath.row].firstName ?? "NO") \(studentLocations[indexPath.row].lastName ?? "Name")  \(studentLocations[indexPath.row].mediaURL ?? "Empty URL")"
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentLocations = StudentDataFarm.sharedInstance.arrayOfStudentLocations
        guard let string = studentLocations[indexPath.row].mediaURL else { return }
        if let url = URL(string: string)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    @IBAction func loggingOut(_ sender: Any) {
        UdacityParseClient.sharedInstance().taskForDELETELogoutMethod()
        let controller = storyboard!.instantiateViewController(withIdentifier: "loginNow")
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func addPin(_ sender: Any) {
 performSegue(withIdentifier: "toPinMake", sender: self)
        
    }
    


    
}

