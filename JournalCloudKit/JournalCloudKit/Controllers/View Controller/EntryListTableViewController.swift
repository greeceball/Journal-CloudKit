//
//  EntryListTableViewController.swift
//  JournalCloudKit
//
//  Created by Colby Harris on 3/30/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func addEntryButtonTapped(_ sender: Any) {
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.shared.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)


        return cell
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEntryDetailVC" {
            
        }
    }
 

}
