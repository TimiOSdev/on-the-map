//
//  TableVC.swift
//  onthemap
//
//  Created by Tim McEwan on 11/2/18.
//  Copyright © 2018 sudo. All rights reserved.
//

import UIKit

class TableVC: UITableViewController {
    var studentInfo: [StudentInformation] = []
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        print(self.studentInfo)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(studentInfo.count)
        return studentInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        print("DATE -\(studentInfo[indexPath.row].createdAt ?? "NO DATE")")
        cell.textLabel?.text = "\(studentInfo[indexPath.row].firstName ?? "NO") \(studentInfo[indexPath.row].lastName ?? "Name")  \(studentInfo[indexPath.row].mediaURL ?? "Empty URL")"
        
        return cell
    }
}
